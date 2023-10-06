#include "Useful.h"


#define MAX_FORMAT_PRINTF_SIZE 128

char *strreplace(char *s, const char *s1, const char *s2) {
    char *p = strstr(s, s1);
    if (p != NULL) {
        size_t len1 = strlen(s1);
        size_t len2 = strlen(s2);
        if (len1 != len2)
            memmove(p + len2, p + len1, strlen(p + len1) + 1);
        memcpy(p, s2, len2);
    } else {
        return NULL;
    }
    return s;
}


#if(PRINTF_FORMAT == 0)
void changePrintfFormat(char *wanted)
{
    char *b = strreplace((char *) wanted, (const char *) "%lu", (const char *) "%ld");
    while(b)
        b = strreplace((char *) wanted, (const char *) "%lu", (const char *) "%ld");
}
#endif

#if(PRINTF_FORMAT == 1)
void changePrintfFormat(char *wanted)
{
    char *b = strreplace((char *) wanted, (const char *) "%lu", (const char *) "%ld");
    while(b)
        b = strreplace((char *) wanted, (const char *) "%lu", (const char *) "%ld");
}
#endif

#if (PRINTF_FORMAT != 0 && PRINTF_FORMAT != 1)
void changePrintfFormat(char *wanted)
{
}
#endif

void logOut(char withCr, const char *format, ...)
{
    // BEWARE: format is 128 bytes max
    va_list arg;
    char f[MAX_FORMAT_PRINTF_SIZE];
    strcpy(f, format);
    changePrintfFormat(f);

    // printf("Format:%s\n", f);

    va_start (arg, format);
    #ifndef CMOC_COMPILER
    vfprintf(stdout, f, arg);
    #else 
    vprintf(format, arg);
    #endif
    va_end (arg);

    if (withCr) {
        #if(PRINTF_FORMAT == 0)
        printf("\n");
        #endif
        #if(PRINTF_FORMAT == 1)
        printf("%c%c", 10, 13);
        #endif
        #if (PRINTF_FORMAT != 0 && PRINTF_FORMAT != 1)
        printf("\n");
        #endif
    }
}

