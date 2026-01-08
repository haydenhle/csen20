        .syntax         unified
        .cpu            cortex-m4
        .text


// int32_t Return32Bits(void) ;
        .global         Return32Bits
        .thumb_func
        .align
Return32Bits:
    MOV R0, #10
        BX              LR


// int64_t Return64Bits(void) ;
        .global         Return64Bits
        .thumb_func
        .align
Return64Bits:
	LDR R0, =-10
    LDR R1, =-1
        BX              LR


// uint8_t Add8Bits(uint8_t x, uint8_t y) ;
        .global         Add8Bits
        .thumb_func
        .align
Add8Bits:
    ADD R0, R0, R1
    UXTB R0, R0
        BX             LR


// uint32_t FactSum32(uint32_t x, uint32_t y) ;
        .global         FactSum32
        .thumb_func
        .align
FactSum32:
	PUSH {R4, LR}

    ADD R0, R1

    BL Factorial
    MOV R0, R0

    POP {R4, LR}
        BX             LR


// uint32_t XPlusGCD(uint32_t x, uint32_t y, uint32_t z) ;
        .global         XPlusGCD
        .thumb_func
        .align
XPlusGCD:
    PUSH {R4, LR}

    MOV R4, R0
    MOV R0, R1
    MOV R1, R2

    BL gcd

    ADD R0, R4, R0

    POP {R4, LR}
        BX             LR

        .end


