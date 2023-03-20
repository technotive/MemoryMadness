// based on documentation by Geeks for Geeks: https://www.geeksforgeeks.org/socket-programming-cc/
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define PORT 9001

int main() {
    int listener = socket(AF_INET, SOCK_STREAM, 0);

    return 0;
}