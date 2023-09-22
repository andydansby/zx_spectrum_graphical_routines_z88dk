
PUBLIC _ASRL_DN
_ASRL_DN:
;;-------------------------------------------
;;Shift attributes down (20<=21)
;;-------------------------------------------
;ASRL_DN:
         LD     HL,$5ADF        ; address of the end of the second line from the bottom
         LD     DE,$5AFF        ; address of the end of the lowest line
         LD BC, $02E0           ; move: 23 lines of 32 bytes
         LDDR                   ; move the top 23 lines down
         LD     A,(_a_color)    ; color to fill the top line
LP_ASDN: LD     (DE),A          ; set a new attribute
         DEC    E               ; if we reached the very first byte
         JR NZ, LP_ASDN         ; attribute area (E=0), then STOP
         LD     (DE),A          ; and set this byte
         RET                    ; exit procedure
