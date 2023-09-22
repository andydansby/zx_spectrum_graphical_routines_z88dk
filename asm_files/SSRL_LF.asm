
PUBLIC _SSRL_LF
_SSRL_LF:
;;-------------------------------------------
;;Shift left one character (20<=21)
;;-------------------------------------------
;SSRL_LF:
         LD DE,     $4000       ; start of graphics area
LP_SSLF: LD         H,D         ; address of the first
         LD         L,E         ; byte line
         INC        HL          ; address of the second byte of the line
         LD         BC,$001F    ; how many bytes to shift
         LDIR                   ; shift line left by 1 byte
         XOR        A           ; clear the flags
         LD         (DE),A      ; to the last (right) byte of the line
         INC        DE          ; go to next line (bottom)
         LD         A,D         ; if attributes
         CP         $58         ; "not seen yet"
         JR         C,LP_SSLF   ; then we repeat the cycle for the next one. lines
         RET                    ; exit procedure-----------------------------------------
