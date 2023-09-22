
;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;

;http://www.zxpress.ru/article.php?id=7876
;uses DE/HL
;xx = 128 = $80;
;yy = 96  = $60;
;de = $6080
PUBLIC _dejavuPLOT
_dejavuPLOT:      ; plot e = x-axis, d = y-axis

    LD DE,(_gfx_xy) ;;$5F 4B
    LD B,0x07   ; Frequently used mask (#07)
    LD A,D      ; grab Y-coordinate
    RRA         ; divide it by 8
    SCF         ; and begin forming
    RRA         ; the High byte of the
    RRA         ; Pixel Addresses
    AND 0x5F    ; in the screen (register H):
    LD H,A      ;         %010yyyyy
    XOR E       ; Next, we form
    AND B       ; Low byte address
    XOR E       ; of the
    RRCA        ; Pixel
    RRCA        ; in the screen
    RRCA        ; (register L):
    LD L,A      ;         %yyyxxxxx
    LD A,D      ; Finish
    XOR H       ; formation
    AND B       ; high byte
    XOR H       ; pixel addresses
    LD H,A      ; on screen (register H)
    ;;now we have the full address







    LD A,E
    AND 7
    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)
    XOR (HL)
    LD (HL),A

    or (hl) ; OR with screen contents
    ld (hl),a   ; write to screen

RET

;dejavuPOINT_bits: defb 128,64,32,16,8,4,2,1














