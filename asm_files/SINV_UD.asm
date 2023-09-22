
PUBLIC _SINV_UD
_SINV_UD:
;;-------------------------------------------
;;Invert character vertically (20)
;;-------------------------------------------
;SINV_UD:
         ;LD      HL,(CONSTS)   ; take the address from the variable
         LD      HL, $4000

         LD      D,H           ; save this
         LD      E,L           ; address in DE
         LD      B,#08         ; in a symbol - 8 bytes
LP_SIU1: LD      A,(HL)        ; take one byte of the character
         PUSH    AF            ; and push it onto the stack
         INC     HL            ; move to next character byte
         DJNZ    LP_SIU1       ; repeat the cycle for eight bytes
         LD      B,#08         ; how many bytes we will read
LP_SIU2: POP     AF            ; pop a byte from the stack and back
         LD      (DE),A        ; in nom order we write into the symbol
         INC     DE            ; next character byte
         DJNZ    LP_SIU2       ; rotate the loop eight times
         RET                   ; exit the procedure
