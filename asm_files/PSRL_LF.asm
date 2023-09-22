
PUBLIC _PSRL_LF
_PSRL_LF:
;;-------------------------------------------
;;Shift left by one pixel (16<=17)
;;-------------------------------------------
;PSRL_LF:
         LD      HL,$57FF      ; address of the last byte of the graphics
LP_PSL1: OR      A             ; reset the carry flag CF
         LD      B,$20         ; 32 bytes in one line
LP_PSL2: RL      (HL)          ; CF<-[shifted byte]<-CF (to the left)
         DEC     HL            ; move to the previous byte of the line
         DJNZ    LP_PSL2       ; shift loop for one line
         BIT     6,H           ; are we still on the screen?
         JR      NZ,LP_PSL1    ; if yes, shift the next line
         RET                   ; exit the procedure
