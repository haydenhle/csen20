
#include <stdint.h>
#include <stdlib.h>

static void Magnitude2String(uint8_t magnitude, char* string, unsigned radix)
{
    int num[20];
    int reverse[3];

    static const char table[] = "0123456789ABCDEF";
    int index = 0;
    int i = 0;

    // convert to radix
    if (magnitude == 0)
    {
        string[index++] = '0';
    }
    else
    {
        while (magnitude > 0)
        {
            string[index++] = table[magnitude % radix];
            magnitude /= radix;
        }
    }

    // reverse
    for (int i = 0, j = index - 1; i < j; i++, j--) 
    {
        char temp = string[i];
        string[i] = string[j];
        string[j] = temp;
    }

    // last is \0 to end string
    string[index] = '\0';
    }

//radix 8
void Bits2OctalString(uint8_t bits, char string[])
    {
    Magnitude2String(bits, string, 8);
    }

//radix 10
void Bits2UnsignedString(uint8_t bits, char string[])
    {
    Magnitude2String(bits, string, 10);
    }

//radix 16
void Bits2HexString(uint8_t bits, char string[])
    {
    Magnitude2String(bits, string, 16);
    }


void Bits2TwosCompString(uint8_t bits, char string[])
    {
    // check MSB
    if ((bits & 0b10000000) != 0)
    {
        string[0] = '-';
        // flip
        bits = ~bits + 1;
    }
    else
    {
        string[0] = '+';
    }
    Bits2UnsignedString(bits, string + 1);
    }

void Bits2SignMagString(uint8_t bits, char string[])
    {
    unsigned mag = 0;
    // check MSB
    if ((bits & 0b10000000) != 0)
    {
        string[0] = '-';
        unsigned mag = bits & 0b01111111;
    }
    else
    {
        string[0] = '+';
        unsigned mag = bits;
    }
    Bits2UnsignedString(mag, &string[1]);
    }


//Alternative: create magnitude to string conversion function
//and use it in Bits2OctalString, Bits2UnsignedString and Bits2HexString
