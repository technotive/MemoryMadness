/**
 * Since the intended audience is familiar with C#, this file will refer to the C# project for similarities.
 * This does not mean the code is "the same" or even "equivalent". I left out several safeguards (1) (naive code
 * on purpose), that C# takes care of automatically and you really *should* take care of it manually in C as well.
 * What I mean is: DO NOT use this code in production. Ever.
 * (1) For example: I have not set up any socket options. When setting something up yourself you should *at least*
 * read up on these socket options and decide for yourself if you would need any of those.
 * 
 * For those who have never seen a header (*.h) file before: You may think of it as a JS export statement of sorts.
 **/

#ifndef MY_HELPER
#define MY_HELPER

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_RESET   "\x1b[0m"

void split(unsigned char* source, int s_size, char split_at, unsigned char* left, unsigned char* right);
void log_connected(int handler);
void log_disconnected(int handler);
void log_request(unsigned char* buffer, int length);

#endif
