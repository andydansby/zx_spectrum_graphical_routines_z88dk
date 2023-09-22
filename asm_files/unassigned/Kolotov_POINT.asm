
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;https://zxpress.ru/article.php?id=5429

;$AD72
PUBLIC _Kolotov_POINT
_Kolotov_POINT:

Kolotov_default_pixel_flag:
    ;make sure the _pixel_on_off variable is turned off
    ld hl, _pixel_on_off    ;10T
    xor a                   ;4T
    ld (hl), a              ;7T
    ;make sure the _pixel_on_off variable is turned off
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;xx = 128 = $80;
;yy = 96  = $60;
;de = $6080
Kolotov_Pixel_Address:  ;$AD8F

    ld de, (_gfx_xy)        ;20T

    LD      B, $07          ;7T frequently used mask (#07)
    LD      A,D             ;4T take Y-coordinate
    RRA                     ;4T divide it by 8
    SCF                     ;4T and start forming
    RRA                     ;4T high byte
    RRA                     ;4T pixel addresses
    AND     $5F             ;7T in the screen (register H):
    LD      H,A             ;4T %010yyyyy
    XOR     E               ;4T next we form
    AND     B               ;4T low byte
    XOR     E               ;4T addresses
    RRCA                    ;4T pixel
    RRCA                    ;4T on the screen
    RRCA                    ;4T (register L):
    LD      L,A             ;4T %yyyxxxxx
    LD      A,D             ;4T finish
    XOR     H               ;4T formation
    AND     B               ;4T high byte
    XOR     H               ;4T pixel addresses
    LD      H,A             ;4T in the screen (register H)
    ;;address is in HL
;127 T states
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ANS = $4890
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; screen address is now in HL
; 139 t STATES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; screen address is now in HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Kolotov_POINTLP:
    LD      A,E             ;4T begin to form
    AND     B               ;4T pixel mask in byte
    LD      B,A             ;4T images (corresponding
    LD      A,$80           ;7T bit is on). Turn on the 7th bit
    JR      Z,Kolotov_GO_PNT    ;12T if this is just what you need,

Kolotov_LP_PNT:
  	RRCA                    ;4T then we jump over the shift
    DJNZ Kolotov_LP_PNT     ;8T bit on right

Kolotov_GO_PNT:
    LD      C,A             ;4T save the mask on. bit in reg. C
    AND     (HL)            ;7T check the pixel on the screen

Kolotov_endPoint:
    jp z, Kolotov_noPixel   ;10T
    jp nz, Kolotov_yesPixel ;10T
    RET                   ; exit procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if Z flag is OFF, Pixel is at that location 1 4
; if Z flag is ON, there is not a pixel at that location 2 3

Kolotov_yesPixel:
    ld a, 1                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T

Kolotov_noPixel:
    ld a, 0                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T

;;220-223 T




PUBLIC _pixel_on_off
_pixel_on_off:
defb 0

