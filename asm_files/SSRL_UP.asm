
PUBLIC _SSRL_UP
_SSRL_UP:
;;-------------------------------------------
;;Shift up one character (55<=68)
;;-------------------------------------------
;SSRL_UP:
         LD      DE,$4000      ; beginning of screen area
LP_SSU1: PUSH    DE            ; save the line address on the stack
         LD      BC,$0020      ; in line - 32 bytes
         LD      A,E           ; The DE register contains the address
         ADD     A,C           ; top line. In the register
         LD      L,A           ; HL needs to get the address
         LD      A,D           ; lines, lying below with a step of 8.
         JR      NC,GO_SSUP    ; To do this, add to the register E
         ADD     A,$08         ; We add 32 and enter it in L. If if there is
GO_SSUP: LD      H,A           ; overflow, then H=D+8
         LDIR                  ; carry one line (32 bytes)
         POP     DE            ; restore the address of the beginning of the line
         LD      A,H           ; check if it's time for us to scroll
         CP      $58           ; (moved all 23 rows)
         JR      NC,LP_SSU2    ; if yes, go to clear
         INC     D             ; ---------------------------------;
         LD      A,D           ; DOWN_DE
         AND     $07           ; standard sequence
         JR      NZ,LP_SSU1    ; of commands to move to the next line
         LD      A,E           ; in the screen area
         ADD     A,$20         ; (for register DE)
         LD      E,A
         JR      C,LP_SSU1     ; input: DE - line address
         LD      A,D           ; output: DE - line address below
         SUB     $08           ; accumulator is used
         LD      D,A
         JR      LP_SSU1       ; ---------------------------------;
LP_SSU2: XOR     A             ; clearing the accumulator
LP_SSU3: LD      (DE),A        ; and using it -
         INC     E             ; clearing one line of the image
         JR      NZ,LP_SSU3    ; total: 32 bytes
         LD      E,$E0         ; jump to the next
         INC     D             ; (lower) line of the image
         BIT     3,D           ; filled the entire last row?
         JR      Z,LP_SSU2     ; if not, continue filling
         RET                   ; exit the procedure
