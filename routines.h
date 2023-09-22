#ifndef ROUTINES_H
#define ROUTINES_H

void forcedPause (unsigned int time)
{
    //int time = 5000;
    int loop;

    for (loop = 0; loop < time; loop ++)
    {    }
}

void pressKey (void)
{
    printf ("Press a Key");

    in_wait_key();
}


void waitForKey (void)
{
    //printf("\x16\x14\x01");
    //printf("                                 \n");
    //printf("                                 \n");
    //printf("\x16\x01\x14");
    printf("\x16\x01\xA4");
	printf("time MS =  %ld\n", timeDiff);
    forcedPause(15000);
    pressKey ();
}


void beforeDrawing (void)
{
    in_wait_nokey();
    zx_cls(PAPER_WHITE | INK_BLUE);
    timerStart();
    return;
}



void printBinary (unsigned char number)
{
    printf("binary= "BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(number));
    printf ("\n");
}



#endif
//leave blank line after
