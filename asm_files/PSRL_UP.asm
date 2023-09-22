
PUBLIC _PSRL_UP
_PSRL_UP:
;;-------------------------------------------
;;Shift up one pixel (38<=91)
;;-------------------------------------------
;PSRL_UP:
         LD      DE,$4000      ; address of the first byte of the graphics
LP_PSU1: LD      H,D           ; copied start address
         LD      L,E           ; of the graphics line to HL
         LD      BC,$0020      ; single line size
         INC     H             ; ---------------------------------;
         LD      A,H           ; DOWN_HL
         AND     $07           ; standard sequence
         JR      NZ,GO_PSUP    ; of commands to jump to the line
         LD      A,L           ; below in the screen area
         ADD     A,C           ; (for register HL)
         LD      L,A           ; (here ADD A,C instead of ADD A,#08)
         JR      C,GO_PSUP     ; input: HL - line address
         LD      A,H           ; output: HL - line address below
         SUB     $08           ; accumulator is used
         LD      H,A           ; ---------------------------------;
GO_PSUP: PUSH    HL            ; save the bottom line address
         LDIR                  ; image transfer from bottom to top
         POP     DE            ; DE - bottom line address
         LD      A,H           ; we are still in the graphics area
         CP      $58           ; or have we encountered attributes?
         JR      C,LP_PSU1     ; if still graphics, repeat
         XOR     A             ; clear the accumulator and use it to
LP_PSU2: LD      (DE),A        ; clear the
         INC     E             ; bottom line of the image
         JR      NZ,LP_PSU2    ; after moving the screen up
         RET                   ; exit the procedure
