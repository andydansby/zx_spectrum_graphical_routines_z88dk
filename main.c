//  zcc +zx -vn -SO3 -m -lm -clib=new main.c -o main -create-app

// using sccz80 1.99c

//https://github.com/z88dk/z88dk/wiki/Classic-GenericConsole

#define ABS(N) ((N<0)?(-N):(N))
#define abs(N) ((N<0)?(-N):(N))
#define min(a,b) (((a)<(b))?(a):(b))
#define max(a,b) (((a)>(b))?(a):(b))

#define z80_bpoke(a,b)  (*(unsigned char *)(a) = b)

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')
//this is lifted from
//https://stackoverflow.com/questions/111928/is-there-a-printf-converter-to-print-in-binary-format

#pragma printf "%f %ld %d %c"
#pragma scanf  "%f %ld %d %c"

#define CHARACTER_WIDTH 31

#define SHR3 (jz=jsr, jsr^=(jsr<<7), jsr^=(jsr>>5), jsr^=(jsr<<3),jz+jsr)

// printf control characters
#define zxp_at          22
#define zxp_paper       17
#define zxp_ink         16
#define zxp_bright      19
#define zxp_flash       18
#define zxp_over        21
#define zxp_inverse     20
#define zxp_tab         23


#include <arch/zx.h>
#include <math.h>
#include <float.h>
#include <stdio.h>
#include <input.h>
#include <intrinsic.h>//temp to place labels
//powerful troubleshooting tool
        //intrinsic_label(border_start);
        //intrinsic_label(border_end);

#include "externs.h"

#include "variables.h"
#include "plot.h"

#include "timer.h"
#include "routines.h"



//#include "attributes.h"

void printOptions (void);

void silly (void)
{
    //_pixel_on_off
    if (pixel_on_off == 0)
    {
        zx_border (1);//blue
    }
    if (pixel_on_off == 1)
    {
        zx_border (2);//red
    }
    for (temp2 = 0; temp2 < 20000; temp2 ++)    {}
}

void options1 (void)
{
    //key presses
    while (1)
    {

		if (in_key_pressed( IN_KEY_SCANCODE_q ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            randomAttributes();

            timerStart();
            for (temp = 0; temp < 32; temp ++)
            {
                a_color = 7;
                ASRL_LF();
            }
            timerEnd();
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_w ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            randomAttributes();

            timerStart();
            for (temp = 0; temp < 32; temp ++)
            {
                a_color = 7;
                ASRL_RG();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_e ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            randomAttributes();

            timerStart();
            for (temp = 0; temp < 24; temp ++)
            {
                a_color = 7;
                ASRL_UP();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_r ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            randomAttributes();

            timerStart();
            for (temp = 0; temp < 24; temp ++)
            {
                a_color = 7;
                ASRL_DN();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_t ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 32; temp ++)
            {
                SSRL_LF();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_y ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 32; temp ++)
            {
                SSRL_RG();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_u ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 23; temp ++)
            {
                SSRL_UP();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_i ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters2();

            timerStart();
            for (temp = 0; temp < 23; temp ++)
            {
                //SSRL_DN();
                SSRL_DN3();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_o ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 255; temp ++)
            {
                PSRL_LF();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_p ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 255; temp ++)
            {
                PSRL_RG();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_a ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 191; temp ++)
            {
                PSRL_UP();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_s ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 191; temp ++)
            {
                PSRL_DN();
            }
            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_d ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();
            copyScreen();
            zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters0 ();

            CONSTS = bufferScreen;

            timerStart();

            SCR_MRG();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_f ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            SCR_INV ();
            timerEnd();
            waitForKey ();
            break;
		}

        if (in_key_pressed( IN_KEY_SCANCODE_g ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();

            SINV_UD();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_h ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
            printCharacters();

            timerStart();
            for (temp = 0; temp < 191; temp ++)
            {
                //PSRL_DN();
            }
            timerEnd();
            waitForKey ();
            break;
		}





////////////////////////////////
		// Currently testing



		if (in_key_pressed( IN_KEY_SCANCODE_0 ))
		{   //random pixels
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");
		    timerStart();

            randomPixels();

            timerEnd();
            waitForKey ();
            break;
		}

		if (in_key_pressed( IN_KEY_SCANCODE_1 ))
		{
		    zx_cls(PAPER_WHITE | INK_BLACK);
		    printf("\x16\x01\x02");

            printf ("press a key for test\n");


            waitForKey ();
            break;
		}



		////////////////////////////////














    }//end while
}//end options1



void printOptions (void)
{
    {
        zx_cls(PAPER_WHITE | INK_BLUE);
        zx_border (7);
        printf("\x16\x01\x02");

        printf ("Welcome to the Plot tester V0.2\n");
        printf ("press a key for test\n");
        printf ("\n");

        printf ("q - ASRL_LF Shift attributes left\n");
        printf ("w - ASRL_RG Shift attributes right\n");
        printf ("e - ASRL_UP Shift attributes up\n");
        printf ("r - ASRL_DN Shift attributes down\n");
        printf ("t - SSRL_LF Shift left one character\n");
        printf ("y - SSRL_RG Shift right one character\n");
        printf ("u - SSRL_UP Shift up one character\n");
        printf ("i - SSRL_DN Shift down one character\n");
        printf ("o - PSRL_LF Shift left by one pixel\n");
        printf ("p - PSRL_LF Shift right by one pixel\n");
        printf ("a - PSRL_UP Shift up by one pixel\n");
        printf ("s - PSRL_DN Shift down by one pixel\n");

        printf ("d - SCR_MRG Merge images\n");
        printf ("f - SCR_INV Invert screen\n");
        printf ("g - SINV_UD Invert character vertically\n");
        printf ("h - SINV_LR Invert character horizontally\n");

    }

    options1();
}


void main()
{
	__asm
	ei
	__endasm

	zx_cls(PAPER_WHITE | INK_BLUE);


    while (1)
    {
        printOptions();
    }

}

//leave blank line after


