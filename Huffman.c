#ifndef CMOC_COMPILER
#include <stdio.h>
#include <string.h>
#else
#include <cmoc.h>
#endif
#include "Huffman.h"
#include "BitField.h"


// Globals
VALUE occurences[MAX_NODES];
UINT occurencesCount = 0;
NODE *rootNode;
DICTIONARY dictionary[SYMBOLS];


CHAR stopIfCharOnLeaf(NODE *n, void *ch)
{
    if (UNREFVALUE(n->pValue).ch == UNREFUCHAR(ch) && (n->left == NULL && n->right == NULL)) {
        // logOut(1, "[%lu][%c], arg=%c -> %s", UNREFVALUE(n->pValue).occ, UNREFVALUE(n->pValue).ch, *((char *) ch), "BREAK");
        return 1;
    } else {
        // logOut(1, "[%lu][%c], arg=%c", UNREFVALUE(n->pValue).occ, UNREFVALUE(n->pValue).ch, *((char *) ch));
        return 0;
    }
}

void huffInit()
{
    treeInit();
    memset(occurences, 0, sizeof(occurences));
    // memset(dictionnary, 0, sizeof(dictionnary));

    logOut(1, "occurences array memory size:%d bytes", sizeof(occurences));
    logOut(1, "dictionary array memory size:%d bytes", sizeof(dictionary));
}

void findOccurences(UCHAR *input, UINT iSize)
{
    for (int i = 0; i < iSize; i++) {
        // occurences[input[i]]++;
        occurences[input[i]].occ++;
        occurences[input[i]].ch = input[i];
    }
}

CHAR compareLong(LONG a, LONG b)
{
    UINT la = (a & 0xFFFF0000) >> 16;
    UINT lb = (b & 0xFFFF0000) >> 16;
    UINT ra = (a & 0x0000FFFF);
    UINT rb = (b & 0x0000FFFF);

    if (la > lb) return 1;
    if (lb > la) return -1;
    if (la == lb && ra > rb) return 1;
    if (la == lb && ra < rb) return -1;
    if (la == lb && ra == rb) return 0;

    return 2;   // ?
}

UINT getUsedNodes(NODE **queue, UINT occCount)
{
    int u = 0;
    for (UINT i = 0; i < occCount; i++) {
        if (queue[i]->used) {
            u++;
        }
    }
    return u;
}

/*UCHAR*/UINT findMinNode(NODE **queue, /*UCHAR*/UINT occCount)
{
    ULONG maxNode =  0xFF << 24 | 0xFF << 16 | 0xFF << 8 | 0xFF;
    /*UCHAR*/UINT minNodeIndex = 0;
    for (/*UCHAR*/UINT i = 0; i < occCount; i++) {
        if (queue[i]->used && (compareLong(UNREFULONG(queue[i]->pValue), maxNode) == -1 /* || compareLong(UNREFULONG(queue[i]->pValue), maxNode) == 0 */)) {
            maxNode = UNREFULONG(queue[i]->pValue);
            minNodeIndex = i;
        }
    }
    return minNodeIndex;
}

void createTree()
{
    UINT occCount = 0/*, occ = 0*/;
    UINT parentOccIdx = 0;
    // NODE *queue[256];
    NODE *queue[MAX_NODES];   // n symbols -> 2n nodes max
    for (int i = 0, j = 0; i < 256; i++) {
        if (occurences[i].occ) {
            // logOut(1, "occ[%c/%d]=%lu", occurences[i].ch, occurences[i].ch, occurences[i].occ);
            queue[j++] = createNode((void *) &occurences[i]);
            occCount++;
        }
    }
    // logOut(1, "Occurences count:%d", occCount);
    // occ = occCount;
    occurencesCount = occCount; // save occurences count

    // for (int i = 0; i < occCount; i++) {
    //     logOut(1, "idx=%d %lu %d=%c", queue[i]->index, UNREFVALUE(queue[i]->pValue).occ, UNREFVALUE(queue[i]->pValue).ch, UNREFVALUE(queue[i]->pValue).ch);
    // }

    while(1) {

        // find two highest priority nodes (lowest probability)
        /*UCHAR*/ UINT maxNodeIndexFirst = findMinNode(queue, occCount);
        // logOut(1, "minNode=%lu[%c] at %d", UNREFVALUE(queue[maxNodeIndexFirst]->pValue).occ, UNREFVALUE(queue[maxNodeIndexFirst]->pValue).ch, maxNodeIndexFirst);
        queue[maxNodeIndexFirst]->used = 0;

        // check if remaining node
        UINT u = getUsedNodes(queue, occCount);

        /*UCHAR*/ UINT maxNodeIndexSecond = findMinNode(queue, occCount);
        queue[maxNodeIndexSecond]->used = 0;

        // Tree node values are backed on occurences VALUES
        // occurences is splitted in two zones :
        // 0-255 message : symbols occurences
        // 256-MAX_NODES : parent nodes occurences
        occurences[SYMBOLS + parentOccIdx].occ = UNREFVALUE(queue[maxNodeIndexFirst]->pValue).occ + UNREFVALUE(queue[maxNodeIndexSecond]->pValue).occ;
        NODE *parent = createNode((void *) &occurences[SYMBOLS + parentOccIdx++]);
        addChildLeft(parent, queue[maxNodeIndexFirst]);

        if (u == 0) {
            // when only one node left
            rootNode = parent;
            break;
        }

        addChildRight(parent, queue[maxNodeIndexSecond]);
        rootNode = parent;

        u = getUsedNodes(queue, occCount);
        if (u == 0) {
            break;
        }

        // Queue update
        // logOut(1, "Adding node at %d", occCount);
        queue[occCount++] = parent;
    }

    // DEBUG
    for (int i = 0; i < MAX_NODES; i++)
        queue[i] = NULL;

    // return occ;
}

void findPath(NODE *startNode, void *arg, CHAR (*fp)(NODE *, void *), UCHAR resultPath[MAX_PATH], UCHAR *resultPathSize, CHAR *stopRecursion)
{
    if (!startNode) return;
    if (*stopRecursion) return;
    HARVEST_BITS *hb = (HARVEST_BITS *) (arg);
    CHAR stop = fp(startNode, arg);
    if (!stop) {
        hb->path[hb->size] = 0;
        hb->size++;
        findPath(startNode->left, arg, fp, resultPath, resultPathSize, stopRecursion);
        hb->size--;
        hb->path[hb->size] = 1;
        hb->size++;
        findPath(startNode->right, arg, fp, resultPath, resultPathSize, stopRecursion);
        hb->size--;
    } else {
        *resultPathSize = hb->size;
        memcpy(resultPath, hb->path, MAX_PATH);
        (*stopRecursion)++;
        return;
    }
}


UCHAR findDicCode(const UCHAR ch, UCHAR *symbolCode)
{
    // Harvest bits
    HARVEST_BITS hb;
    hb.ch = ch;
    hb.size = 0;
    UCHAR resultPathSize;
    CHAR stopRecursion = 0;
    findPath(rootNode, (void*) &hb, stopIfCharOnLeaf, symbolCode, &resultPathSize, &stopRecursion);

    // for (int i = 0; i < resultPathSize; i++)
    //     logOut(0, "%d", symbolCode[i]);
    // logOut(1, "", "");

    return resultPathSize;
}

UCHAR countBits(UCHAR n)
{
    UCHAR count = 0;
    while (n) {
        count++;
        n >>= 1;
    }
    return count;
}

void updateDic()
{
    // Occurences count
    logOut(1, "occurences count:%d", occurencesCount);
    UCHAR symbolCode[MAX_PATH];

    // Max symbol length
    UCHAR maxLen = 0;
    UCHAR bitsReq = 0;
    for (int i = 0; i < SYMBOLS; i++) {
        if (occurences[i].occ) {
            UCHAR symbolLen = findDicCode(occurences[i].ch, symbolCode);
            if (symbolLen > maxLen)
                maxLen = symbolLen;
        }
    }
    bitsReq = countBits(maxLen);
    logOut(1, "max length path:%d - bits required:%d", maxLen, bitsReq);

    // Each symbol : symbol | len on maxLen | bits on len
    BitField bf;
    UCHAR buffer[TREE_DEPTH];
    for (int i = 0; i < SYMBOLS; i++) {
        if (occurences[i].occ) {
            memset(buffer, 0, TREE_DEPTH);
            initBitField(&bf, buffer);
            // logOut(0, "occ[%c=%d]=%lu=", occurences[i].ch, occurences[i].ch, occurences[i].occ);
            // writebits(&bf, occurences[i].ch, 8);    // leaf node symbol
            UCHAR symbolLen = findDicCode(occurences[i].ch, symbolCode);
            // writebits(&bf, symbolLen, bitsReq);     // coded on symbolLen bits
            for (int j = 0; j < symbolLen; j++) {
                writebits(&bf, symbolCode[j], 1);   // write each symbol bit
            }
            dictionary[occurences[i].ch].bitsLen = symbolLen;
            memcpy(dictionary[occurences[i].ch].code, bf.buffer, TREE_DEPTH);
        }
    }
}

void computeDic(UCHAR *input, UINT iSize)
{
    // Create a dictionary on current input
    huffInit();
    findOccurences(input, iSize);
    createTree(occurences);
    // direct access to symbols codes by updating
    // the dictionnary array.
    updateDic(rootNode, occurences, occurencesCount);
}

void encodeDic(BitField *bf)
{
    // Warning : BitField buffer must large enough and initialized
    UINT sz = 0;

    // Occurences count
    logOut(1, "occurences count:%d", occurencesCount);
    writebits(bf, occurencesCount, 8);
    sz += 8;
    UCHAR symbolCode[MAX_PATH];

    // Max symbol length
    UCHAR maxLen = 0;
    UCHAR bitsReq = 0;
    for (int i = 0; i < SYMBOLS; i++) {
        if (occurences[i].occ) {
            // logOut(0, "occ[%c]=%d=", occurences[i].ch, occurences[i].occ);
            UCHAR symbolLen = findDicCode(occurences[i].ch, symbolCode);
            if (symbolLen > maxLen)
                maxLen = symbolLen;
            // logOut(1, "len:%d", symbolLen);
        }
    }
    bitsReq = countBits(maxLen);
    logOut(1, "max length path:%d - bits required:%d", maxLen, bitsReq);

    writebits(bf, maxLen, 8);
    sz += 8;

    // Each symbol : symbol | len on maxLen | bits on len
    for (int i = 0; i < SYMBOLS; i++) {
        if (occurences[i].occ) {
            // logOut(0, "occ[%c=%d]=%lu=", occurences[i].ch, occurences[i].ch, occurences[i].occ);
            writebits(bf, occurences[i].ch, 8);    // leaf node symbol
            sz += 8;
            UCHAR symbolLen = findDicCode(occurences[i].ch, symbolCode);
            writebits(bf, symbolLen, bitsReq);     // coded on symbolLen bits
            sz += bitsReq;
            for (int j = 0; j < symbolLen; j++) {
                writebits(bf, symbolCode[j], 1);   // write each symbol bit
                sz += 1;
                // logOut(0, "-%d", symbolCode[j]);
            }
            // logOut(1, "", "");
        }
    }
    logOut(1, "Dictionnary size:%d bits (%d bytes) - %d", sz, sz / 8, bf->currentIndex);

}

void decodeDic(BitField *dic, NODE *root, VALUE *backValues, UINT backValuesSize)
{
    // occurences
    UINT occCount = readbits(dic, 8);
    logOut(1, "occurences count:%d", occCount);

    // max symbol length
    UCHAR maxLen = (UCHAR) readbits(dic, 8);
    UCHAR bitsReq = (UCHAR) countBits(maxLen);
    logOut(1, "max length path:%d - bits required:%d", maxLen, bitsReq);

    // Each symbol : symbol | len on maxLen | bits on len
    UCHAR symbol;
    UINT symbolLen;
    UINT backValuesIdx = 0;
    NODE *parent = root;

    while (occCount) {
        symbol = (UCHAR) readbits(dic, 8);
        // logOut(1, "symbol:%d", symbol);

        symbolLen = readbits(dic, bitsReq);
        // logOut(1, "symbolLen:%d", symbolLen);

        // logOut(0, "  code:", "");
        parent = root;
        for (int i = 0; i < symbolLen; i++) {
            UCHAR bit = (UCHAR) readbits(dic, 1);
            // logOut(0, "%d", bit);
            // last node, create char leaf
            if (bit) {
                if (i == symbolLen - 1)
                    backValues[backValuesIdx].ch = symbol;  // only leaves are symbols
                else
                    backValues[backValuesIdx].ch = 0;
                backValues[backValuesIdx].occ = 0;

                NODE *n;
                if (parent->right) {
                    n = parent->right;
                } else {
                    n = createNode((void *) &backValues[backValuesIdx]);
                    backValuesIdx++;
                }
                addChildRight(parent, n);

                // backValuesIdx++;
                parent = n;
            } else {
                if (i == symbolLen - 1)
                    backValues[backValuesIdx].ch = symbol;  // only leaves are symbols
                else
                    backValues[backValuesIdx].ch = 0;
                backValues[backValuesIdx].occ = 0;

                NODE *n;
                if (parent->left) {
                    n = parent->left;
                } else {
                    n = createNode((void *) &backValues[backValuesIdx]);
                    backValuesIdx++;
                }
                addChildLeft(parent, n);

                // backValuesIdx++;
                parent = n;
            }
        }
        // logOut(1, "", "");
        occCount--;
    }
}



INT compress(UCHAR *input, UINT iSize, UCHAR *output, UINT oSize, WTD wtd)
{
    // init output
    memset(output, 0, oSize);   // uber wichtig !
    BitField bfOut;
    initBitField(&bfOut, output);

    // dic options (compression can reuse a former dictionary)
    if (wtd == COMPUTE_AND_INSERT_NEW_DIC) {
        // marker
        writebits(&bfOut, 1, 1);
        // Create a dictionary on current input
        computeDic(input, iSize);
        // and save dictionary in out buffer
        encodeDic(&bfOut);
    } else if (wtd == INSERT_CURRENT_DIC) {
        // marker
        writebits(&bfOut, 1, 1);
        // save current dictionary
        encodeDic(&bfOut);
    } else /* (wtd == USE_CURRENT_AND_DONT_INSERT_DIC) */ {
        // marker
        writebits(&bfOut, 0, 1);
    }

    // input size (UINT!)
    writebits(&bfOut, iSize, sizeof(UINT) * 8);

    // encode symbols
    UCHAR code[TREE_DEPTH];
    BitField bfCode;
    initBitField(&bfCode, code);
    // int slen = 0;
    for (int i = 0; i < iSize; i++) {
        UCHAR symbolLen = dictionary[input[i]].bitsLen;
        // logOut(1, "Symbol length:%d (%d)", symbolLen, input[i]);
        // slen += symbolLen;
        memcpy(code, dictionary[input[i]].code, TREE_DEPTH);
        initBitField(&bfCode, code);
        // logOut(0, "Code:%d=", input[i]);
        for (int j = 0; j < symbolLen; j++) {
            UCHAR bit = (UCHAR) readbits(&bfCode, 1);
            writebits(&bfOut, bit, 1);   // write each symbol bit
            // logOut(0, "%d", bit);
        }
        // logOut(1, "", "");
    }
    return bfOut.currentIndex + 1;  // return size
}


INT uncompress(UCHAR *input, UINT iSize, UCHAR *output, UINT oSize)
{
    BitField bfIn;
    memset(output, 0, oSize);
    initBitField(&bfIn, input);
    UINT outputIdx = 0;

    UCHAR isThereADic = readbits(&bfIn, 1);
    if (isThereADic) {
        huffInit();
        rootNode->right = NULL;
        rootNode->left = NULL;
        decodeDic(&bfIn, rootNode, occurences, MAX_NODES);
    }

    UINT nodeCount = readbits(&bfIn, sizeof(UINT) * 8);

    for (int i = 0; i < nodeCount; i++) {
        NODE *currentNode = rootNode;

        while (currentNode->left != NULL || currentNode->right != NULL) {
            UCHAR bit = (UCHAR) readbits(&bfIn, 1);
            // logOut(0, "%d", bit);
            if (bit) {
                currentNode = currentNode->right;
            } else {
                currentNode = currentNode->left;
            }
        }
        // logOut(1, "", "");
        output[outputIdx++] =  UNREFVALUE(currentNode->pValue).ch;
        // logOut(0, "%d-%c,", output[outputIdx-1], output[outputIdx-1]);
        // logOut(0, "%c,", output[outputIdx-1], output[outputIdx-1]);
    }
    // logOut(1, "", "");

    return outputIdx;   // size
}