#ifndef CMOC_COMPILER
#include <string.h>
#include <stdio.h>
#else
#include <cmoc.h>
#endif


#include "Tree.h"

NODE NO_NODE = {0,0,0,0,0};
NODE memory[MEMORY_SIZE];
INT lastIndex;

void treeInit()
{
    lastIndex = 0;
    // memcpy(memory, &NO_NODE, sizeof(NODE) * MEMORY_SIZE);

    for (int i = 0; i < MEMORY_SIZE; i++)
        memory[i] = NO_NODE;

    lastIndex = -1;
    logOut(1, "reserving %d bytes for tree api", (int) sizeof(memory));
}

NODE *createNode(void *pValue)
{
    if (lastIndex > MEMORY_SIZE)
        return NULL;
    NODE node;
    node.pValue = pValue;
    node.used = 1;
    node.left = NULL;
    node.right = NULL;
    lastIndex++;
    node.index = lastIndex;
    memcpy(&memory[lastIndex], &node, sizeof(node));
    return &memory[lastIndex];
}

void addChildLeft(NODE *parent, NODE *left)
{
    parent->left = left;
}

void addChildRight(NODE *parent, NODE *right)
{
    parent->right = right;
}

NODE *getNode(INT index)
{
    if (index <= lastIndex && memory[index].used)
        return &memory[index];
    return NULL;
}

INT getLastIndex()
{
    return lastIndex;
}

// void recurseTree(NODE *startNode, void *arg, CHAR (*fp)(NODE *, void *))
// {
//     if (!startNode) return;
//     static char stopRecurse = 0;
//     if (stopRecurse) return;
//     CHAR stop = fp(startNode, arg);
//     if (!stop) {
//         recurseTree(startNode->left, arg, fp);
//         recurseTree(startNode->right, arg, fp);
//     } else {
//         stopRecurse++;
//         return;
//     }
// }

void debugTree(NODE *startNode, const char *indentString, void (*fp)(NODE *), CHAR isLast)
{
    // printf("%s+-", indentString);
    logOut(0, "%s+-", indentString);
    fp(startNode);
    // printf("%c%c", 10, 13);

    char reindentString[STRING_INDENT_SIZE];
    memcpy(reindentString, indentString, STRING_INDENT_SIZE);
    if (isLast)
        strcat(reindentString, "   ");
    else
        strcat(reindentString, "|  ");

    if (startNode->left)
        debugTree(startNode->left, reindentString, fp, 0);

    if (startNode->right)
        debugTree(startNode->right, reindentString, fp, 1);
}
