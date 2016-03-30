/*
 * tp3.c
 *
 *  Created on: 2015-09-17
 *      Author: mazola
 */
#include "lwIP_webserver.h"

#include <stdio.h>
#include <string.h>

#include "lwip/err.h"
#include "lwip/tcp.h"
#include "xil_printf.h"

#include "ff.h"
#include "lwip/tcp.h"
#include "netif/xadapter.h"
#include "platform.h"
#include "platform_config.h"
#include "xparameters.h"
#include "http_responses.h"

/* Fichier servant � envoyer dans un payload d'une response */
FIL fil;
/* Systeme de fichier pour mounter la carte SD */
FATFS FatFs;
/* lwIP network interfaces. Utilise pour sp�cifier les param. de l'interface r�seau. */
struct netif webserver_netif;

struct file_to_send {
	FIL *file;
	unsigned long file_size;
	unsigned long bytes_sent;
};
struct file_to_send fts;

void print_app_header()
{
	xil_printf("\n\r\n\r-----lwIP serveur de l'application embarqu� ------\n\r");
	xil_printf("\n\r----- R�pond aux requ�tes d'un fureteur internet par protocole HTTP");
}

FRESULT ouverture_fichier(FIL *file, char *path)
{
	FRESULT fr;    /* FatFs return code */

	/* Register work area to the default drive */
	fr = f_mount(&FatFs, "", 0);
	if (fr) {
		xil_printf("Probleme mount carte SD\n");
		goto error;
	}

	/* Ouverture du fichier */
	fr = f_open(file, path, FA_READ);
	if (fr) {
		xil_printf("Probleme ouverture fichier\n");
		goto error;
	}

error:
	return fr;
}

void parse_http_request(void *arg, struct tcp_pcb *tpcb, struct pbuf *p)
{
	char *token = NULL;
	err_t err;

	/* On regarde si on a un GET */
	token = strtok((char*)p->payload, " ");
	if( strcmp(token,"GET") != 0 ) {
		tcp_arg(tpcb, NULL);
		err = tcp_write(tpcb, reponse_failed, sizeof(reponse_failed)-1, 1);
		if (err) { xil_printf("Erreur tcp_write"); }
	}

	/* Lecture de la page demand� */
	token = strtok(NULL, " ");

	/* Test1 */
	if(strcmp(token,"/test1") == 0) {
		tcp_arg(tpcb, NULL);
		err = tcp_write(tpcb, reponse_test1, sizeof(reponse_test1)-1, 1);
		if (err) {
			xil_printf("Erreur tcp_write");
		}
	} else if(strcmp(token,"/test2") == 0) {  /* Test2 */
		tcp_arg(tpcb, NULL);
		err = tcp_write(tpcb, reponse_test2, sizeof(reponse_test2)-1, 1);
		if (err) { xil_printf("Erreur tcp_write"); }
	} else if(strcmp(token,"/test3") == 0) { /* Test3 */
		char reponse_test3_1[] = "HTTP/1.1 200 OK\n"
		                "Content-Type: image/bmp\n"
		                "Content-Length: 3089620\n"
						"Connection: close\n"
						"\n";

		ouverture_fichier(&fil, "zedboard.bmp");

		fts.file = &fil;
		fts.file_size = fil.fsize;
		fts.bytes_sent = 0;

		/* On passe la struct qui decrit le fichier a envoyer au sent_callback */
		tcp_arg(tpcb, (void*)&fts);

		err = tcp_write(tpcb, reponse_test3_1, sizeof(reponse_test3_1)-1, 1);
		if (err) {
			xil_printf("Erreur tcp_write");
		}
	} else {
			err = tcp_write(tpcb, reponse_failed, sizeof(reponse_failed)-1, 1);
			if (err) {
				xil_printf("Erreur tcp_write");
			}
		}
}

err_t recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err)
{
	xil_printf(p->payload);

	/* On attend d'�tre dans l'�tat ESTABLISHED avant de commencer */
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		goto error_1;
	}

	/* Indiquer la r�ception du paquet */
	tcp_recved(tpcb, p->len);

	/* Assez de place dans le sand buffer pour envoyer l'ent�te? */
	if (tcp_sndbuf(tpcb) < 512) {
		xil_printf("no space in tcp_sndbuf\n");
		goto error_2;
	}

	/* Traitement de la demande */
	parse_http_request(arg, tpcb, p);

error_2:
	pbuf_free(p);
error_1:
	return ERR_OK;
}

err_t sent_callback(void *arg, struct tcp_pcb *tpcb, u16_t len)
{
	FRESULT fr = ERR_OK;
	struct file_to_send *fts;

	if(tpcb->state > ESTABLISHED)
		goto end;

	fts = (struct file_to_send*)arg;
	if (arg == NULL)
		goto end;

	if (fts->bytes_sent != fts->file_size) {
		FRESULT fr;
		unsigned int byteread;
		unsigned int sndbuf_space;
		unsigned int buf_size;

		sndbuf_space = tcp_sndbuf(tpcb);

		if( fts->bytes_sent + sndbuf_space > fts->file_size ) {
			buf_size = fts->file_size - fts->bytes_sent;
		} else {
			buf_size = sndbuf_space;
		}

		fts->bytes_sent += buf_size;
		unsigned char buf[buf_size];

		fr = f_read(&fil, buf, buf_size, &byteread);
		if (fr) {
			xil_printf("erreur fread");
			goto end;
		}

		err_t err = tcp_write(tpcb, buf, buf_size, 1);
		if (err) {
			xil_printf("erreur tcp_write");
			goto end;
		}
	} else {
		tcp_close(tpcb);
	}

end:
	return fr;
}

err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;

	tcp_recv(newpcb, recv_callback);
	tcp_sent(newpcb, sent_callback);
	tcp_arg(newpcb, (void*)connection);
	connection++;

	return ERR_OK;
}

int start_application()
{
	struct tcp_pcb *pcb; /* the TCP protocol control block */
	err_t err;
	unsigned port = 80;

	/* create new TCP PCB structure */
	pcb = tcp_new();
	if (!pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}

	/* bind to specified @port */
	err = tcp_bind(pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	/* we do not need any arguments to callback functions */
	tcp_arg(pcb, NULL);     /* Used to specify the argument that should be passed callback functions. */

	/* listen for connections */
	pcb = tcp_listen(pcb);
	if (!pcb) {
		xil_printf("Out of memory while tcp_listen\n\r");
		return -3;
	}

	/* specify callback to use for incoming connections */
	tcp_accept(pcb, accept_callback);

	xil_printf("TCP tp3 server started @ port %d\n\r", port);

	return 0;
}

void
print_ip(char *msg, struct ip_addr *ip)
{
	print(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip),
			ip4_addr3(ip), ip4_addr4(ip));
}

void
print_ip_settings(struct ip_addr *ip, struct ip_addr *mask, struct ip_addr *gw)
{

	print_ip("Board IP: ", ip);
	print_ip("Netmask : ", mask);
	print_ip("Gateway : ", gw);
}

void init_netif()
{
	struct ip_addr ipaddr, netmask, gw;

	/* the mac address of the board. this should be unique per board */
	unsigned char mac_ethernet_address[] =
	{ 0x00, 0x18, 0x3e, 0x00, 0x00, 0x25 };

	init_platform();

	/* initliaze IP addresses to be used */
	IP4_ADDR(&ipaddr,  132, 207,   89, 25);
	IP4_ADDR(&netmask, 255, 255, 255,  0);
	IP4_ADDR(&gw,      132, 207,   89,  1);

	print_app_header();

	lwip_init();

  	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(&webserver_netif, &ipaddr, &netmask,
						&gw, mac_ethernet_address,
						PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\n\r");
		return;
	}
	netif_set_default(&webserver_netif);

	/* now enable interrupts */
	platform_enable_interrupts();

	/* specify that the network if is up */
	netif_set_up(&webserver_netif);

	print_ip_settings(&ipaddr, &netmask, &gw);

	/* start the application (web server, rxtest, txtest, etc..) */
	start_application();
}
