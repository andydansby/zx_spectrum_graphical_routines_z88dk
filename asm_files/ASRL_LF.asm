
PUBLIC _ASRL_LF
_ASRL_LF:
;;-------------------------------------------
; Shift attributes left (22<=23)
;;-------------------------------------------
;ASRL_LF:
        LD DE,  $5800           ; DE=address of the first attribute byte
LP_ASLF:
        LD      H,D             ; copied DE to HL
        LD      L,E             ; and increased HL by one:
        INC     HL              ; HL=address of the second attribute byte
        LD      BC,$001F        ; <attribute line length> - 1
        LDIR                    ; shift the attribute line to the left
        LD      A,(_a_color)    ; fill color after shift
        LD      (DE),A          ; set a new attribute
        INC     DE              ; move to the next line from below
        LD      A,D             ; if the attributes have already run out,
        CP      $5B             ; if we come across the printer buffer,
        JR C,   LP_ASLF         ; then STOP, otherwise shift further
    RET                         ; exit the procedure
