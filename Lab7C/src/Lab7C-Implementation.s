        .syntax     unified
        .cpu        cortex-m4
        .text

// void PutNibble(void *nibbles, uint32_t index, uint32_t nibble) ;

        .global     PutNibble
        .thumb_func
        .align

PutNibble:
	LSRS R1, R1, 1                        // R1 = byte offset; shifts the index right by 1 bit to divide it by 2
    LDRB R3, [R0, R1]                     // R3 = byte containing nibble; load the byte containing the sudoku cell
    IT CS                                 // c = which (0 or 1) conditional block if c = 1
    RORCS R3, R3, 4                       // rotate the byte so the high nibble is now in the low nibble position
    BIC R3, R3, 0xF                       // mask out the nibble to be replaced. clears bits 0-3 of R3
    ORR R3, R3, R2                        // combine the cleared byte with the new nibble value R2
    IT CS
    RORCS R3, R3, 28                      // rotate back by 28 if modifying high nibble
    STRB R3, [R0, R1]                     // store modified byte back to memory
        BX          LR

// uint32_t GetNibble(void *nibbles, uint32_t index) ;

        .global     GetNibble
        .thumb_func
        .align

GetNibble:
	LSRS R1, R1, 1                        // R1 = byte offset; shift the index right by 1 similar to PutNibble
    LDRB R0, [R0, R1]                     // R0 = byte containing nibble; load the byte containing the nibble
    ITE CS                                // if c = 1 (USE ITE for two instruction block)
    LSRCS R0, R0, 4                       // shift the byte right by 4 bits to align the high nibble with low nibble position
    ANDCC R0, R0, 0xF                     // strip other bits and keep bits 0-3 of R0
        BX          LR

        .end
