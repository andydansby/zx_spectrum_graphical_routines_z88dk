
PUBLIC _PSRL_DN
_PSRL_DN:
;;-------------------------------------------
;;Shift down one pixel (38<=90)
;;-------------------------------------------
;PSRL_DN:
         LD      DE,$57FF      ; address of the last byte of the graphics
LP_PSD1: LD      H,D           ; copied the address of the last
         LD      L,E           ; byte of the line into HL
         LD      BC,$0020      ; width of one image line
         LD      A,H           ; ---------------------------------;
         DEC     H             ; UP_HL
         AND     $07           ; standard sequence
         JR      NZ,GO_PSDN    ; commands to go to the line
         LD      A,L           ; up in the screen area
         SUB     C             ; (for HL register)
         LD      L,A           ; (here SUB C instead of SUB #08)
         JR      C,GO_PSDN     ; at the input: HL - line address
         LD      A,H           ; output: HL - line address above
         ADD     A,$08         ; accumulator is used
         LD      H,A           ; ---------------------------------;
GO_PSDN: PUSH    HL            ; save the top line address
         LDDR                  ; copy 1 line from top to bottom
         POP     DE            ; top line address has become current
         BIT     6,H           ; until we reach the ROM
         JR      NZ,LP_PSD1    ; continue the loop through the lines
         XOR     A             ; clear the accumulator
LP_PSD2: LD      (DE),A        ; clear the top line
         DEC     E             ; of the image after shifting
         JR      NZ,LP_PSD2    ; the entire screen down
         LD      (DE),A        ; clear the very first byte
         RET                   ; exit the procedure
