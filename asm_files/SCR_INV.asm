

PUBLIC _SCR_INV
_SCR_INV:
;;-------------------------------------------
;;Invert screen (12<=18)
;;-------------------------------------------
;SCR_INV:
        LD      HL, $57FF      ; last byte of the screen area
LP_SCRI: LD      A,(HL)        ; take image byte from screen
         CPL                   ; invert it
         LD      (HL),A        ; and put it back
         DEC     HL            ; moving to the beginning of the area
         BIT     6,H           ; if "crosses" the beginning,,
         JR      NZ,LP_SCRI    ; then STOP, otherwise loop
         RET                   ; exit the procedure
