;Fastcall only supports one parameter in DEHL
;L = 8 bit
;HL = 16 bit
;DEHL = 32 bit
;;;;;;;;;;;;;;;;;;
;uses DE/HL/BC
PUBLIC _hella_POINT
_hella_POINT:          ; plot d = x-axis, e = y-axis

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

    ;$48 $90
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;address is now in HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;110 T states
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ANS = $4890
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; screen address is now in HL
; 110 t STATES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; screen address is now in HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hella_POINTLP:
    LD      A,E             ;4T begin to form
    AND     B               ;4T pixel mask in byte
    LD      B,A             ;4T images (corresponding
    LD      A,$80           ;7T bit is on). Turn on the 7th bit
    JR      Z,hella_GO_PNT    ;12T if this is just what you need,

hella_LP_PNT:
  	RRCA                    ;4T then we jump over the shift
    DJNZ hella_LP_PNT     ;8T bit on right

hella_GO_PNT:
    LD      C,A             ;4T save the mask on. bit in reg. C
    AND     (HL)            ;7T check the pixel on the screen

hella_endPoint:
    jp z, hella_noPixel   ;10T
    jp nz, hella_yesPixel ;10T
    RET                   ; exit procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if Z flag is OFF, Pixel is at that location 1 4
; if Z flag is ON, there is not a pixel at that location 2 3

hella_yesPixel:
    ld a, 1                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T

hella_noPixel:
    ld a, 0                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T


