
PUBLIC _ASRL_UP
_ASRL_UP:
;;-------------------------------------------
; Shift attributes up (19<=21)
;;-------------------------------------------
;ASRL_UP:
         LD HL, $5820           ; address of the second attribute line
         LD     DE, $5800       ; address of the first attribute line
         LD BC, $02E0           ; move: 23 lines of 32 bytes
         LDIR                   ; move the bottom 23 lines up
         LD      A,(_a_color)   ; color to fill the bottom line
LP_ASUP: LD      (DE),A         ; set a new attribute
         INC     E              ; if you filled in the entire last line
         JR      NZ,LP_ASUP     ; (E=0), then we interrupt the cycle
         RET                    ; exit procedure
