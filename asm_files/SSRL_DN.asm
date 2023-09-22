
;$B651
PUBLIC _SSRL_DN0
_SSRL_DN0:
;;-------------------------------------------
;;Shift down one character (55<=73)
;;-------------------------------------------
ld hl, $57FF
ld de, $57DF

saveSSRL_DN:		;save
push hl
push de
ld c, $17

nextLineSSRL_DN:	;nextLine
ld b, $20

copyByteSSRL_DN:	;copyByte
ld a, (de)
ld (hl), a
ld a, c
and 7
cp 1		;??? is this an error??  cp L
jr nz, nextByteSSRL_DN
sub a
ld (de), a

nextByteSSRL_DN:    ;nextByte
dec hl
dec de
djnz copyByteSSRL_DN
dec c
jr z, restoreSSRL_DN
ld a, c
and 7
cp 0	;??? is this an error??  cp O
jr z, nextBlockSSRL_DN
cp 7
jr nz, nextLineSSRL_DN
push de
ld de, $700
and a
sbc hl, de
pop de
jr nextLineSSRL_DN

restoreSSRL_DN:		;restore
pop de
pop hl
dec d
dec h
ld a, h
cp 79
ret z
jr saveSSRL_DN

nextBlockSSRL_DN:			;nextBlock
push hl
ld hl, $700
ex de, hl
and a
sbc hl, de
ex de, hl		;??? is this an error??  ex hl, de
pop hl
jr nextLineSSRL_DN

endSSRL_DN:
ret

















PUBLIC _SSRL_DN3
_SSRL_DN3:

        LD      DE, $57FF
LP_SSD1: PUSH    DE
        LD      BC, $0020
        LD      A,E
        SUB     C
        LD      L,A
        LD      A,D
        JR      NC,GO_SSDN
        SUB     $08
GO_SSDN: LD      H,A
        LDDR
        POP     DE
        BIT     6,H
        JR      Z,LP_SSD2
        LD      A,D
        DEC     D
        AND     $07
        JR      NZ,LP_SSD1
        LD      A,E
        SUB     $20
        LD      E,A
        JR      C,LP_SSD1
        LD      A,D
        ADD     A,#08
        LD      D,A
        JR      LP_SSD1
LP_SSD2: XOR     A
LP_SSD3: LD      (DE),A
        DEC     E
        JR      NZ,LP_SSD3
        LD      (DE),A
        LD      E,$1F
        DEC     D
        BIT     6,D
        JR      NZ,LP_SSD2
        RET


















PUBLIC _SSRL_DN
_SSRL_DN:
;;-------------------------------------------
;;Shift down one character (55<=73)
;;-------------------------------------------
;SSRL_DN:
         LD      DE,$57FF      ; address of last graphics byte
_LP_SSD1: PUSH    DE            ; stored line end address
         LD      BC,$0020      ; length of one image line
         LD      A,E           ; in register HL
         SUB     C             ; we get the address
         LD      L,A           ; end of the line
         LD      A,D           ; lying above
         JR      NC,GO_SSDN    ; initial step
         SUB     $08           ; in 8 pixels (lines):
_GO_SSDN: LD      H,A           ; HL=copy from; DE=where
         LDDR                  ; transfer one line of graphics
         POP     DE            ; restore the end-of-line address
         BIT     6,H           ; if we are no longer on the screen,
         JR      Z,LP_SSD2     ; then we move on to cleaning
         LD      A,D           ; ---------------------------------;
         DEC     D             ; UP_DE
         AND     $07           ; standard sequence
         JR      NZ,LP_SSD1    ; commands to go to the line
         LD      A,E           ; up in the screen area
         SUB     $20           ; (for DE register)
         LD      E,A
         JR      C,LP_SSD1     ; at the input: DE - line address
         LD      A,D           ; output: DE - line address above
         ADD     A,$08         ; accumulator is used
         LD      D,A
         JR      LP_SSD1       ; ---------------------------------;
_LP_SSD2: XOR     A             ; clear accumulator
_LP_SSD3: LD      (DE),A        ; clear one line of the image:
         DEC     E             ; decrement E
         JR NZ,LP_SSD3         ; jump to LP_SSD3 if not zero (31 bytes)
         LD      (DE),A        ; clear the first byte of the line
         LD      E,$1F         ; move to the next (upper) line
         DEC     D             ; decrement D
         BIT     6,D           ; have we reached the ROM?
         JR      NZ,LP_SSD2    ; if not, continue clearing
         RET                   ; return from the procedure
