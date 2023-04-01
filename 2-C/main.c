// based on documentation by Geeks for Geeks:
// https://www.geeksforgeeks.org/socket-programming-cc/

#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>
#include <string.h>

int processRequest(uint8_t* buffer, int length, uint8_t* output);

#include "helper.h" //See this file for some extra information as well.

#define MAX_CONNECTIONS_PENDING 8
#define PORT 9001

int main() {
    struct sockaddr_in endpoint;
    endpoint.sin_family = AF_INET; // IPv4
    endpoint.sin_addr.s_addr = INADDR_ANY;
    endpoint.sin_port = htons(PORT);
    int endpoint_size = sizeof(endpoint);

    int listener  = socket(AF_INET, SOCK_STREAM, 0); // Options roughly mean: IPv4 TCP/IP
    int _l_result = bind(listener, (struct sockaddr*)&endpoint, endpoint_size);

    int _b_result = listen(listener, MAX_CONNECTIONS_PENDING);
    printf("Listening on port %d on any interface.\n", PORT);

    bool listening = true;
    while(listening) {
        int handler = accept(listener, (struct sockaddr*)&endpoint, (socklen_t*)&endpoint_size);
        logConnected(handler);

        bool connected = true;
        while(connected) {
            uint8_t buffer[256]; // Volatile
            int byte_count = read(handler, buffer, 256);
            
            if(byte_count > 0) {
                logRequest(buffer, byte_count);
                uint8_t response[256];
                int length = processRequest(buffer, byte_count, response);
                write(handler, response, length);
            } else {
                connected = false;
            }
        }

        logDisconnected(handler);
        close(handler);
    }
    shutdown(listener, SHUT_RDWR); // Done automatically in C# by the using directive.
    return 0;
}

 int processRequest(uint8_t* buffer, int length, uint8_t* output) {
    uint8_t contents_0[256];
    uint8_t contents_1[256];
    split(buffer, length, ':', (uint8_t*) contents_0, (uint8_t*) contents_1);
    int size = atoi(contents_1);
    memcpy(output, contents_0, size);
    output[size] = '\n';
    return size+1;
}