PUBLIC _joffa_POINT
_joffa_POINT:

    LD DE, (_gfx_xy)
    LD A, D

    RRCA
    RRCA
    RRCA


    AND %00011000   ;24 = 0x18
    OR  %01000000   ;64 = 0x40

    LD H, A
    LD A, D
    AND 7
    OR H
    LD H, A

    LD A, D
    ADD A, A
    ADD A, A
    AND %11100000
    LD L, A

    LD A, E

    RRCA
	RRCA
	RRCA
	AND %00011111

    OR L
    LD L,A					; hl = screen address.
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
joffa_POINTLP:
    LD      A,E             ;4T begin to form
    AND     B               ;4T pixel mask in byte
    LD      B,A             ;4T images (corresponding
    LD      A,$80           ;7T bit is on). Turn on the 7th bit
    JR      Z,joffa_GO_PNT    ;12T if this is just what you need,

joffa_LP_PNT:
  	RRCA                    ;4T then we jump over the shift
    DJNZ joffa_LP_PNT     ;8T bit on right

joffa_GO_PNT:
    LD      C,A             ;4T save the mask on. bit in reg. C
    AND     (HL)            ;7T check the pixel on the screen

joffa_endPoint:
    jp z, joffa_noPixel   ;10T
    jp nz, joffa_yesPixel ;10T
    RET                   ; exit procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if Z flag is OFF, Pixel is at that location 1 4
; if Z flag is ON, there is not a pixel at that location 2 3

joffa_yesPixel:
    ld a, 1                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T

joffa_noPixel:
    ld a, 0                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T
