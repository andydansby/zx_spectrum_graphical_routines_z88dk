
PUBLIC _PSRL_RG
_PSRL_RG:
;;-------------------------------------------
;;Shift right by one pixel (17)
;;-------------------------------------------
;PSRL_RG:
         LD      HL,$4000      ; address of the first byte of the graphics
         LD      C,$C0         ; shift - 192 lines
LP_PSR1: OR      A             ; CF=0 for an empty column on the left
         LD      B,$20         ; number of bytes in one line
LP_PSR2: RR      (HL)          ; shift one byte to the right
         INC     HL            ; next byte of the image line
         DJNZ    LP_PSR2       ; shift the entire line - 32 bytes
         DEC     C             ; decrease the line counter
         JR      NZ,LP_PSR1    ; if all lines have been shifted, then STOP
         RET                   ; exit the procedure
