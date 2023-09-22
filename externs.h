//variables
extern unsigned char gfx_x;
extern unsigned char gfx_y;
extern unsigned int gfx_xy;
extern unsigned int gfx_yx;

extern unsigned char pixel_on_off;


//Fastcall only supports one parameter in DEHL
//L = 8 bit
//HL = 16 bit
//DEHL = 32 bit

//All need adjustment to push de/hl
//z88dkPlotFill is built into Z88dk in the zx.h library

extern void __FASTCALL__ Get_Pixel_Address(void);//uses BC/hl

extern void __FASTCALL__ dejavuPLOT(void);//uses BC/de/hl


extern void __CALLEE__ calculate_screen_address(void);

extern void __CALLEE__ copyScreen(void);



extern unsigned int CONSTS;
extern unsigned int bufferScreen;
extern unsigned char a_color;

extern void __FASTCALL__ copyScreen (void);

extern void __FASTCALL__ ASRL_LF (void);
extern void __FASTCALL__ ASRL_RG (void);
extern void __FASTCALL__ ASRL_UP (void);
extern void __FASTCALL__ ASRL_DN (void);
extern void __FASTCALL__ SSRL_LF (void);
extern void __FASTCALL__ SSRL_RG (void);
extern void __FASTCALL__ SSRL_UP (void);
extern void __FASTCALL__ SSRL_DN (void);
extern void __FASTCALL__ SSRL_DN3 (void);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
extern void __FASTCALL__ PSRL_LF (void);
extern void __FASTCALL__ PSRL_RG (void);
extern void __FASTCALL__ PSRL_UP (void);
extern void __FASTCALL__ PSRL_DN (void);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
extern void __FASTCALL__ SCR_MRG (void);
extern void __FASTCALL__ SCR_INV (void);
extern void __FASTCALL__ SINV_UD (void);







