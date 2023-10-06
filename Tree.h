#ifndef TREE_H
#define TREE_H

#include "Useful.h"

struct NODE_STRUCT {
    CHAR used;
    INT index;
    void *pValue;
    struct NODE_STRUCT *left;
    struct NODE_STRUCT *right;
};
typedef struct NODE_STRUCT NODE;

extern NODE NO_NODE;/* = { 0, 0, 0, 0, 0 };*/
#define MEMORY_SIZE /*128*/512
extern NODE memory[MEMORY_SIZE];
extern INT lastIndex;
#define STRING_INDENT_SIZE 80

void treeInit();
NODE *createNode(void *pValue);
void addChildLeft(NODE *parent, NODE *left);
void addChildRight(NODE *parent, NODE *right);
NODE *getNode(INT value);
// void unfragmentMemory();
INT getLastIndex();
// void recurseTree(NODE *startNode, void *arg, CHAR (*fp)(NODE *, void *));
void debugTree(NODE *startNode, const char *indentString, void (*fp)(NODE *), CHAR isLast);


#endif