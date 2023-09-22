
PUBLIC _SCR_MRG
_SCR_MRG:
;;-------------------------------------------
;;Merge images (17<=21)
;;-------------------------------------------
;SCR_MRG:
         ;LD      HL,(_CONSTS)   ; take the image address from the address

         LD hl, _bufferScreen

         LD      DE,$4000      ; screen area address
LP_SCRM: LD      A,(DE)        ; screen image byte
         OR      (HL)          ; "merged" with the picture byte in memory
         LD      (DE),A        ; and placed back on the screen
         INC     HL            ; next byte of the image in memory
         INC     DE            ; next byte of screen area
         LD      A,D           ; end check
         CP      $58           ; screen area
         JR      C,LP_SCRM     ; if not finished, then repeat
         RET                   ; exit the procedure

