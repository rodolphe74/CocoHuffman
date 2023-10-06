#ifndef CMOC_COMPILER
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#else
#include <cmoc.h>
#endif
#include "Tree.h"
#include "Huffman.h"
#include "Useful.h"
#include "BitField.h"

// void printNode(NODE *n)
// {
//     // if (UNREFVALUE(n->pValue).ch)
//     //     logOut(1, "(%d)", UNREFVALUE(n->pValue).ch);
//     // else
//     //     logOut(1, "[%lu]", UNREFVALUE(n->pValue).occ);

//     if (n->left || n->right)
//         logOut(1, "[%lu]", UNREFVALUE(n->pValue).occ);
//     else
//         logOut(1, "(%d)", UNREFVALUE(n->pValue).ch);
// }

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

CHAR debugNodeWithArg(NODE *n, void *arg) {
    logOut(1, "[%lu][%c], arg=%c", UNREFVALUE(n->pValue).occ, UNREFVALUE(n->pValue).ch, arg ? *((char *) arg) : '*');
    return 0;
}

#ifndef CMOC_COMPILER
int main(int argc, char *argv[])
#else
int main()
#endif
{
    // Huffman starts here
    huffInit();
    //UCHAR message[] = "Ceci est un message à caractère informatif!";
    UCHAR message[] = "éà";
    // UCHAR message[] = "a";
    // UCHAR message[] = "aabbbcc";
    // UCHAR message[] = "abcdefghikkk";
    // UCHAR message[] = "***Ceci est un message a caractere informatif!***";
    // UCHAR message[] = "this is an example of a huffman tree";

    logOut(1, "compressing:[%s]", message);

    findOccurences(message, sizeof(message));

    int u = 0;
    logOut(1, "before:%p", &u);
    /*UCHAR occCount =*/ createTree(occurences);
    int x = 0;
    logOut(1, "after:%p", &x);
    char indentString[STRING_INDENT_SIZE];
    memset(indentString, 0, STRING_INDENT_SIZE);
    // recurseTree(rootNode, NULL, debugNodeWithArg);
    debugTree(rootNode, indentString, printNode, 0);


    updateDic(rootNode, occurences, occurencesCount);


    // BitField bf;

    // UCHAR buffer[512];
    // // write
    // memset(buffer, 0, 512);
    // initBitField(&bf, buffer);
    // encodeDic(/*rootNode, occurencesCount, occCount,*/ &bf);

    // read (tree reconstitution)
    // treeInit();
    // VALUE readTreeNodeValue;
    // readTreeNodeValue.ch = 0;
    // readTreeNodeValue.occ = 0;
    // NODE *readTreeNode = createNode((void *) &readTreeNodeValue);
    
    // VALUE readOcc[MAX_NODES];
    // initBitField(&bf, buffer);
    // decodeDic(&bf, readTreeNode, readOcc, MAX_NODES);
    // memset(indentString, 0, STRING_INDENT_SIZE);
    // debugTree(readTreeNode, indentString, printNode, 0);


    // Compression test
    UCHAR compressedOutput[512];
    INT sz = compress(message, sizeof(message), compressedOutput, sizeof(compressedOutput), COMPUTE_AND_INSERT_NEW_DIC);
    logOut(1, "compressed size:%d", sz);

    // Decompression test
    UCHAR uncompressedOutput[512];
    sz = uncompress(compressedOutput, sizeof(compressedOutput), uncompressedOutput, sizeof(uncompressedOutput));

    // Compare
    INT diffIdx = -1;
    for (int i = 0; i < sizeof(message); i++)
        if (message[i] != uncompressedOutput[i])
            diffIdx = i;
    if (diffIdx > -1)
        logOut(1, "Messages differ at %d", diffIdx);
    else
        logOut(1, "No difference between uncompressed and compressed message");

    // Display tree after decompression
    // memset(indentString, 0, STRING_INDENT_SIZE);
    // debugTree(rootNode, indentString, printNode, 0);

    return 0;
}
