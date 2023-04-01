#include <string.h>
#include <arpa/inet.h>
#include <stdio.h>
#include "helper.h"

#ifndef CLIENT_NAME
#define CLIENT_NAME
void client_name(int handler, unsigned char* address);
#endif

void log_connected(int handler) {
    unsigned char client_addr[16] = {0};
    client_name(handler, client_addr);
    printf(ANSI_COLOR_GREEN);
    printf("Client %s connected\n", client_addr);
    printf(ANSI_COLOR_RESET);
    fflush(stdout);
}
void log_disconnected(int handler) {
    unsigned char client_addr[16] = {0};
    client_name(handler, client_addr);
    printf(ANSI_COLOR_RED);
    printf("Client %s disconnected\n", client_addr);
    printf(ANSI_COLOR_RESET);
    fflush(stdout);
}
void log_request(unsigned char* buffer, int length) {
    printf(ANSI_COLOR_BLUE);
    printf("Received %d raw bytes\n", length);
    printf(ANSI_COLOR_RESET);
    printf("%s", buffer);
    fflush(stdout);
}

void split(unsigned char* source, int s_size, char split_at, unsigned char* left, unsigned char* right) {
    int location = 0;
    int ending = 0;
    for(int i = 0; i < s_size; i++) {
        if(source[i] == '\n') { 
            ending = i;
            break;
        } 
        if(source[i] == split_at) { location = i; } // If we found where to split, note that number down.
    }
    memcpy(left, source, location);
    unsigned char* next = source+location+1;
    memcpy(right, next, ending-location);
}

void client_name(int handler, unsigned char* address) {
    struct sockaddr_in client;
    unsigned int client_size = sizeof(client);
    getpeername(handler, (struct sockaddr*) &client, &client_size);
    memcpy(address, inet_ntoa(client.sin_addr), 16);
}