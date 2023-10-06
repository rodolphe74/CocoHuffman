#ifndef BITFIELD_H
#define BITFIELD_H

#include "Useful.h"

struct bitFieldStruct {
    UCHAR *buffer;
    UINT currentIndex;
    CHAR bitLeft;
};

typedef struct bitFieldStruct BitField;

void initBitField(BitField *bf, UCHAR *buf);
void writebits(BitField *bf, UINT value, UCHAR bitCount);
UINT readbits(BitField *bf, UCHAR bitCount);

#endif