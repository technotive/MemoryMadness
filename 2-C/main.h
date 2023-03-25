/**
 * Since the intended audience is familiar with C#, this file will refer to the C# project for similarities.
 * This does not mean the code is "the same" or even "equivalent". I left out several safeguards (1) (naive code
 * on purpose), that C# takes care of automatically and you really *should* take care of it manually in C as well.
 * What I mean is: DO NOT use this code in production. Ever.
 * (1) For example: I have not set up any socket options. When setting soemthign up yourself you should *at least*
 * read up on these socket options and decide for yourself if you would need any of those.
 * 
 * For those who have never seen a header (*.h) file before: You may think of it as a JS export statement of sorts.
 **/

#ifndef MY_MAIN
#define MY_MAIN

#include <string.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_RESET   "\x1b[0m"

#define BIND_FAIL 1001

void split(unsigned char* source, int s_size, unsigned char* left, unsigned char* right) {
    int location = 0;
    int ending = 0;
    for(int i = 0; i < s_size; i++) {
        if(source[i] == '\n') { 
            ending = i;
            break;
        } 
        if(source[i] == ':') { location = i; } // If we found where to split, note that number down.
    }
    memcpy(left, source, location);
    unsigned char* next = source+location+1;
    memcpy(right, next, ending-location);
}

#endif