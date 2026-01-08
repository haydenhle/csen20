/*
    This code was written to support the book, "ARM Assembly for Embedded Applications",
    by Daniel W. Lewis. Permission is granted to freely share this software provided
    that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY 
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
        .syntax     unified
        .cpu        cortex-m4
        .text

// uint32_t Mul32X10(uint32_t multiplicand) ;

        .global     Mul32X10
        .thumb_func
        .align
Mul32X10:                         // R0 = multiplicand
        LSLS.N R1, R0, #2            // shift the bits of R0 left by 2 places (R0 * 4) and store in R1
        ADDS.N R1, R1, R0            // R1 = R1 + R0
        LSLS.N R0, R1, #1            // shift the bits of r1 left by 1 place (R1 * 2) and store in R0
        BX          LR

// uint32_t Mul64X10(uint32_t multiplicand) ;

        .global     Mul64X10
        .thumb_func
        .align
Mul64X10:                         // R1.R0 = multiplicand
        LSLS.N R3, R1, #2            // mult high part R1 by 4 by shifting its bits left by 2
        ORR R3, R3, R0, LSR 30    // merge the top 2 bits of the low part R0 into R3
        LSLS.N R2, R0, #2            // mult low part R0 by 4 shifting its bits by 2 places
        ADDS.N R2, R2, R0            // add original low part to R2. R2 = 5 * low part
        ADCS.N R3, R3, R1           // add high part with carry into R3
        LSLS.N R0, R2, #1            // mult low part result by 2 and store in R0
        ADC R1, R3, R3            // add carry into R1 (final high part)
        BX          LR

// uint32_t Div32X10(uint32_t dividend) ;

        .global     Div32X10
        .thumb_func
        .align
Div32X10:           // R0 = dividend
        LDR         R1,=3435973837
        UMULL       R2,R1,R1,R0
        LSRS.N      R0,R1,3
        BX          LR

        .end


