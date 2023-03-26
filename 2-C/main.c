// based on documentation by Geeks for Geeks:
// https://www.geeksforgeeks.org/socket-programming-cc/

#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>

#include "main.h" //See this file for some extra information as well.

#define MAX_CONNECTIONS_PENDING 8
#define PORT 9001

int main() {
    struct sockaddr_in endpoint;
    endpoint.sin_family = AF_INET; // IPv4
    endpoint.sin_addr.s_addr = INADDR_ANY;
    endpoint.sin_port = htons(PORT);
    int endpoint_size = sizeof(endpoint);

    uint8_t buffer[256] = {0};

    int listener       = socket(AF_INET, SOCK_STREAM, 0); // Options roughly mean: IPv4 TCP/IP
    int binding_result = bind(listener, (struct sockaddr*)&endpoint, endpoint_size);

    // Ideally you would check if binding worked. C# would throw an exception. C gives you a return code.
    if(binding_result < 0) { printf("Could not bind listener to port %d\n", PORT); exit(BIND_FAIL); }

    int listening_result = listen(listener, MAX_CONNECTIONS_PENDING);
    printf("Listening on port %d on any interface.", PORT);

    bool listening = true;
    while(listening) {
        int handler = accept(listener, (struct sockaddr*)&endpoint, (socklen_t*)&endpoint_size);

        unsigned char client_addr[16] = {0};
        client_name(handler, client_addr);

        printf("%s", ANSI_COLOR_GREEN);
        printf("Client %s connected\n", client_addr);
        printf("%s", ANSI_COLOR_BLUE);

        bool connected = true;
        while(connected) {
            int bytecount = read(handler, buffer, 256);
            
            if(bytecount > 0) {
                printf("\nReceived %d bytes\n%s", bytecount, buffer);
                uint8_t contents_0[256];
                uint8_t contents_1[256];
                split(buffer, bytecount, (uint8_t*) contents_0, (uint8_t*) contents_1);
                int size = atoi(contents_1);
                contents_0[size] = '\n';
                write(handler, contents_0, size+1);
            } else {
                printf("\nReceived nothing\n");
                connected = false;
            }
        }

        printf("%s", ANSI_COLOR_RED);
        printf("Client %s disconnected\n", client_addr);
        close(handler);
        printf("%s", ANSI_COLOR_RESET);
    }
    shutdown(listener, SHUT_RDWR); // Done automatically in C# by the using directive and the destructor.
    return 0;
}