#ifndef HUFFMAN_H
#define HUFFMAN_H

#define UNREFUCHAR(x)(*((UCHAR *) x))
#define UNREFINT(x)(*((INT *) x))
#define UNREFULONG(x)(*((ULONG *) x))
#define UNREFVALUE(x)(*((VALUE *) x))

#define TREE_DEPTH 4
#define MAX_PATH 32 // tree depth * 8
#define SYMBOLS 256
#define MAX_NODES 511    // TODO find max

#include "Tree.h"
#include "BitField.h"

enum WHAT_TO_DO_WITH_DIC {
    USE_CURRENT_AND_DONT_INSERT_DIC = 0,
    COMPUTE_AND_INSERT_NEW_DIC = 1,
    INSERT_CURRENT_DIC = 2
};
typedef enum WHAT_TO_DO_WITH_DIC WTD;

struct VALUE_STRUCT {
    ULONG occ;
    UCHAR ch;
};
typedef struct VALUE_STRUCT VALUE;

// first 256 indexes -> message occurences
extern VALUE occurences[MAX_NODES];
extern UINT occurencesCount;
extern NODE *rootNode;

struct DICTIONARY_STRUCT {
    UCHAR code[TREE_DEPTH];
    UCHAR bitsLen;
};
typedef struct DICTIONARY_STRUCT DICTIONARY;
extern DICTIONARY dictionary[SYMBOLS];


struct HARVEST_BITS_STRUCT {
    UCHAR ch;
    UCHAR path[MAX_PATH];
    UCHAR size;
};
typedef struct HARVEST_BITS_STRUCT HARVEST_BITS;

void huffInit();
void findOccurences(UCHAR *input, UINT iSize);
CHAR compareLong(LONG a, LONG b);
UINT findMinNode(NODE **queue, /*UCHAR*/UINT occCount);
void createTree();
UCHAR findDicCode(const UCHAR ch, UCHAR *symbolCode);
void updateDic();
void computeDic(UCHAR *input, UINT iSize);
void encodeDic(BitField *dic);
void decodeDic(BitField *dic, NODE *root, VALUE *backValues, UINT backValuesSize);
INT compress(UCHAR *input, UINT iSize, UCHAR *output, UINT oSize, WTD wtd);
INT uncompress(UCHAR *input, UINT iSize, UCHAR *output, UINT oSize);

#endif