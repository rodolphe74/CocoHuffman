#ifndef USEFUL_H
#define USEFUL_H

#ifdef CMOC_COMPILER
#include <cmoc.h>
#else
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#endif

#ifdef CMOC_COMPILER
typedef unsigned long ULONG;
typedef long LONG;
typedef unsigned int UINT;
typedef int INT;
typedef unsigned char UCHAR;
typedef char CHAR;
#else
#include <stdint.h>
typedef uint32_t ULONG;
typedef int32_t LONG;
typedef uint16_t UINT;
typedef int16_t INT;
typedef unsigned char UCHAR;
typedef char CHAR;
#endif

char *strreplace(char *s, const char *s1, const char *s2);
void changePrintfFormat(char *wanted);
void logOut(char withCr, const char *format, ...);
#endif