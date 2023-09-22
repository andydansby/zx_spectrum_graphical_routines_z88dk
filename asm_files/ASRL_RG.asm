
PUBLIC _ASRL_RG
_ASRL_RG:
;;-------------------------------------------
;;Shift attributes to the right (21<=23)
;;-------------------------------------------
;ASRL_RG:
         LD     DE,$5AFF       ; address of the last attribute byte
LP_ASRG: LD     H,D            ; copied DE to HL -
         LD     L,E            ; last byte of the attribute line
         DEC    HL             ; last byte of the attribute line
         LD     BC,$001F       ; <attribute line length> - 1
         LDDR                  ; shift the attribute line to the right
         LD     A,(_a_color)   ; fill color after shift
         LD     (DE),A         ; set a new attribute
         DEC    DE             ; go to next line from top
         BIT    3,D            ; if we are still in attributes,
         JR NZ, LP_ASRG        ; then we repeat the cycle for the next one. lines
         RET                   ; exit procedure
