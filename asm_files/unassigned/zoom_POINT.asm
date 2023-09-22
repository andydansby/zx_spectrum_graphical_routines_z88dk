;https://wiki.darkbyte.sk/doku.php?id=plot
PUBLIC _Z00M_POINT
_Z00M_POINT:

zOOm_default_pixel_flag:
    ;make sure the _pixel_on_off variable is turned off
    ld hl, _pixel_on_off    ;10 T
    xor a                   ;4  T
    ld (hl), a              ;7  T
    ;make sure the _pixel_on_off variable is turned off
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;xx = 128 = $80;
;yy = 96  = $60;
;de = $6080

    ld de, (_gfx_xy)        ;20 T

    ld a,d                  ;4t
    and a                   ;4t
    rra                     ;4t
    scf                     ;4t
    rra                     ;4t
    and a                   ;4t
    rra                     ;4t
    xor d                   ;4t
    and $F8                 ;7t
    xor d                   ;4t
    ld h,a                  ;4t
    ld a,e                  ;4t
    rlca                    ;4t
    rlca                    ;4t
    rlca                    ;4t
    xor d                   ;4t
    and %11000111           ;7t
    xor d                   ;4t
    rlca                    ;4t
    rlca                    ;4t
    ld l,a                  ;4t
    ;HL now has the address
;131 T states
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


zoom_POINTLP:
    LD      A,E             ;4T begin to form
    AND     B               ;4T pixel mask in byte
    LD      B,A             ;4T images (corresponding
    LD      A,$80           ;7T bit is on). Turn on the 7th bit
    JR      Z,zoom_GO_PNT    ;12T if this is just what you need,

zoom_LP_PNT:
  	RRCA                    ;4T then we jump over the shift
    DJNZ zoom_LP_PNT     ;8T bit on right

zoom_GO_PNT:
    LD      C,A             ;4T save the mask on. bit in reg. C
    AND     (HL)            ;7T check the pixel on the screen

zoom_endPoint:
    jp z, zoom_noPixel   ;10T
    jp nz, zoom_yesPixel ;10T
    RET                   ; exit procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if Z flag is OFF, Pixel is at that location 1 4
; if Z flag is ON, there is not a pixel at that location 2 3

zoom_yesPixel:
    ld a, 1                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T

zoom_noPixel:
    ld a, 0                 ;7T
    ld hl, _pixel_on_off    ;10T
    ld (hl), a              ;7T
    ret                     ;10T

 ;;220-223 T
