
PUBLIC _SSRL_RG
_SSRL_RG:
;;-------------------------------------------
;;Shift right one character (19<=22)
;;-------------------------------------------
;SSRL_RG:
         LD DE, $57FF          ;;last byte of the graphics area
LP_SSRG: LD      H,D           ; last byte address
         LD      L,E           ; current line
         DEC     HL            ; address of the next to the last byte
         LD      BC,$001F      ; shift: 31 bytes
         LDDR                  ; shift graphics line to the right
         XOR     A             ; clear the flags
         LD      (DE),A        ; first (left) byte of the current line
         DEC     DE            ; go to next line above
         BIT     6,D           ; if we have not yet “came across” the ROM,
         JR      NZ,LP_SSRG    ; then we continue to spin the cycle
         RET                   ; exit procedure
