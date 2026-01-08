// void CopyCell(uint32_t *dst, uint32_t *src) ;        // R0 = dst, R1 = src

            .syntax     unified
            .cpu        cortex-m4
            .text

            .global     CopyCell
            .thumb_func
            .align
CopyCell:   PUSH {R4-R11}

            LDR R2, =60                 // rows = 60
NextRow1:   LDMIA R1!, {R3-R12}     	// copy 1 row
            STMIA R0!, {R3-R12}
            LDMIA R1!, {R3-R12}     	// copy 1 row
            STMIA R0!, {R3-R12}
            LDMIA R1!, {R3-R12}     	// copy 1 row
            STMIA R0!, {R3-R12}
            LDMIA R1!, {R3-R12}     	// copy 1 row
            STMIA R0!, {R3-R12}
            LDMIA R1!, {R3-R12}     	// copy 1 row
            STMIA R0!, {R3-R12}
            LDMIA R1!, {R3-R12}     	// copy 1 row
            STMIA R0!, {R3-R12}
            
            ADD R0, R0, 4*(240-60)     	// next dst row
            ADD R1, R1, 4*(240-60)    	// next src row
            SUBS.N R2, R2, 1
             
            BNE         NextRow1
EndRows1:   POP {R4-R11}
            BX          LR


// void FillCell(uint32_t *dst, uint32_t color) ;       // R0 = dst, R1 = color

            .global     FillCell
            .thumb_func
            .align 
FillCell:   LDR R2, =60                      // rows = 60
NextRow2:   LDR R3, =30                      // cols = 60
NextCol2:   STRD R1, R1, [R0], 8             // store 2 pixels
            SUBS.N R3, R3, 1                 // decrement R3
            BNE         NextCol2
            ADD R0, R0, 4*(240-60)           // next dst row same as above
            SUBS.N R2, R2, 1                 // decrement R2
            BNE         NextRow2
            BX          LR

            .end















