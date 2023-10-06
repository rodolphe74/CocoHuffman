#ifndef CMOC_COMPILER
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#else
#include <cmoc.h>
#endif

#include "Huffman.h"

#define MAX_BUFFER_U_SIZE 1024*1
#define MAX_BUFFER_C_SIZE 1024*2*1
#define BUFFER_COUNT 5


void printNode(NODE *n)
{
    if (n->left || n->right)
        if (n->pValue)
            logOut(1, "[%lu]", UNREFVALUE(n->pValue).occ);
        else
            logOut(1, "[x]");
    else
        logOut(1, "(%d)", UNREFVALUE(n->pValue).ch);
}

int compareBuffers(UCHAR *first, UINT firstSz, UCHAR *second, UINT secondSz, UINT testIdx, UINT cSz)
{
    if (firstSz != secondSz) {
        logOut(1, "### messages sizes differ!\n");
    }
    for (int k = 0; k < firstSz; k++) {
        if (first[k] != second[k]) {
            logOut(1, "%d<>%d\n", first[k], second[k]);
            logOut(1, "### messages differ at %d\n", k);
            return 1;
        }
    }
    logOut(1, "### test %d (%f) all good! %d vs %d\n", testIdx, (float) secondSz / (float) cSz, cSz, firstSz);
    return 0;
}

int main()
{
    INT cidx = 0;
    INT bidx = 0;

    UCHAR buf[MAX_BUFFER_U_SIZE];
    UCHAR cbuf[MAX_BUFFER_C_SIZE];
    UCHAR back[MAX_BUFFER_U_SIZE];
    // char indentString[STRING_INDENT_SIZE];

    // Tests with dedicated dictionary
    // *******************************
    for (int i = 0; i < BUFFER_COUNT; i++) {
        size_t sz = rand() % MAX_BUFFER_U_SIZE + 1;
        UCHAR u = 0;
        memset(buf, 0, MAX_BUFFER_U_SIZE);
        memset(cbuf, 0, MAX_BUFFER_C_SIZE);
        memset(back, 0, MAX_BUFFER_U_SIZE);
        for (int j = 0; j < sz; j++) {
            if (j % 40 == 0)
                u =  (UCHAR) (rand() % 254 + 1);
            buf[j] = u;
        }
        cidx = compress(buf, sz, cbuf, MAX_BUFFER_C_SIZE, COMPUTE_AND_INSERT_NEW_DIC);
        // Display tree after compression
        // memset(indentString, 0, STRING_INDENT_SIZE);
        // debugTree(rootNode, indentString, printNode, 0);
        logOut(1, "size:%lu cidx:%d", sz, cidx);



        bidx = uncompress(cbuf, cidx, back, MAX_BUFFER_U_SIZE);
        // Display tree after decompression
        // memset(indentString, 0, STRING_INDENT_SIZE);
        // debugTree(rootNode, indentString, printNode, 0);

        compareBuffers(buf, sz, back, bidx, i, cidx);
    }


    // Tests with a global dictionary
    // ******************************
    size_t sz = MAX_BUFFER_U_SIZE;
    UCHAR u = 0;
    memset(buf, 0, MAX_BUFFER_U_SIZE);
    memset(cbuf, 0, MAX_BUFFER_C_SIZE);
    memset(back, 0, MAX_BUFFER_U_SIZE);
    for (int j = 0; j < sz; j++) {
        if (j % 40 == 0)
            u = (UCHAR) (rand() % 254 + 1);
        buf[j] = u;
    }
    computeDic(buf, sz);
    // memset(indentString, 0, STRING_INDENT_SIZE);
    // debugTree(rootNode, indentString, printNode, 0);

    // first compression, insert current dictionary
    cidx = compress(buf, sz, cbuf, MAX_BUFFER_C_SIZE, INSERT_CURRENT_DIC);
    bidx = uncompress(cbuf, cidx, back, MAX_BUFFER_U_SIZE);
    compareBuffers(buf, sz, back, bidx, 0, cidx);

    // then use former dictionary on another message containing
    // same symbols
    for (int i = 1; i < 5; i++) {
        sz = rand() % MAX_BUFFER_U_SIZE + 1;
        memset(cbuf, 0, MAX_BUFFER_C_SIZE);
        memset(back, 0, MAX_BUFFER_U_SIZE);
        cidx = compress(buf, sz, cbuf, MAX_BUFFER_C_SIZE, USE_CURRENT_AND_DONT_INSERT_DIC);
        bidx = uncompress(cbuf, cidx, back, MAX_BUFFER_U_SIZE);
        compareBuffers(buf, sz, back, bidx, i, cidx);
    }

    return 0;
}