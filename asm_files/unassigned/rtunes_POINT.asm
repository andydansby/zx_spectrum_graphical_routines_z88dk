PUBLIC _rtunes_POINT
_rtunes_POINT:

    ld DE, (_gfx_xy)	;20 T

    LD A,D				;4 T
    AND A				;4 T
    RRA					;4 T
    SCF					;4 T
    RRA					;4 T
    AND A				;4 T
    RRA					;4 T
    XOR D				;4 T
    AND %11111000		;7 T


    XOR D				;4 T
    LD H,A				;4 T
    LD A,E				;4 T
    RLCA				;4 T
    RLCA				;4 T
    RLCA				;4 T
    XOR D				;4 T
    AND %11000111		;7 T
    XOR D				;4 T
    RLCA				;4 T
    RLCA				;4 T
    LD L,A				;4 T
    ;HL now has the address
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
rtunes_POINTLP:
    LD      A,E             ;4T begin to form
    AND     B               ;4T pixel mask in byte
    LD      B,A             ;4T images (corresponding
    LD      A,$80           ;7T bit is on). Turn on the 7th bit
    JR      Z,rtunes_GO_PNT    ;12T if this is just what you need,

rtunes_LP_PNT:
  	RRCA                    ;4T then we jump over the shift
    DJNZ rtunes_LP_PNT     ;8T bit on right

rtunes_GO_PNT:
    LD      C,A             ;4T save the mask on. bit in reg. C
    AND     (HL)            ;7T check the pixel on the screen

rtunes_endPoint:
    jp z, rtunes_noPixel   ;10T
    jp nz, rtunes_yesPixel ;10T
    RET                   ; exit procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if Z flag is OFF, Pixel is at that location 1 4
; if Z flag is ON, there is not a pixel at that location 2 3

rtunes_yesPixel:
    ld a, 1                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T

rtunes_noPixel:
    ld a, 0                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T
