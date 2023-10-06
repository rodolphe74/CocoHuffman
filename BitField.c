#include "BitField.h"


void initBitField(BitField *bf, UCHAR *buf)
{
    bf->bitLeft = 7;
    bf->currentIndex = 0;
    bf->buffer = buf;
}

void writebits(BitField *bf, UINT value, UCHAR bitCount)
{
    // value must fit in bitCount !
    // little endian notation (last bit stored first)
    UCHAR bitSet = 0;
    while (value) {
        UCHAR currentBit = (UCHAR)(value & 1);
        bf->buffer[bf->currentIndex] |= currentBit << (bf->bitLeft);
        bf->bitLeft--;
        if (bf->bitLeft < 0) {
            bf->bitLeft = 7;
            bf->currentIndex++;
        }
        bitSet++;
        value = value >> 1;
    }
    for (UCHAR i = 0; i < bitCount - bitSet; i++) {
        bf->buffer[bf->currentIndex] |= (UCHAR)(0 << (bf->bitLeft));
        bf->bitLeft--;
        if (bf->bitLeft < 0) {
            bf->bitLeft = 7;
            bf->currentIndex++;
        }
    }
}

UINT readbits(BitField *bf, UCHAR bitCount)
{
    // little endian notation (last bit stored first)
    UCHAR mask = 0;
    UINT value = 0;
    UINT currentBit = 0;
    UCHAR bitSet = 0;
    while (bitCount) {
        mask = (UCHAR)(1 << bf->bitLeft);
        currentBit = (bf->buffer[bf->currentIndex] & mask) >> bf->bitLeft;
        value |= currentBit << bitSet;
        bitCount--;
        bitSet++;
        bf->bitLeft--;
        if (bf->bitLeft < 0) {
            bf->bitLeft = 7;
            bf->currentIndex++;
        }
    }
    return value;
}