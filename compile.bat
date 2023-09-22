SET PATH=c:\z88dk199c;c:\z88dk199c\bin;c:\z88dk199c\lib\;c:\z88dk199c\lib\clibs;c:\z88dk199c\lib\config

del "1_graphics.tap"
cls

@rem -pragma-include:zpragma.inc
@rem zcc +zx -vn -SO3 -m -lm -clib=new -o 1_plot @plot.lst -pragma-include:zpragma.inc -startup=9 -create-app


@rem zcc +zx -vn -SO3 -m -lm -clib=new -o 1_graphics @graphics.lst -startup=9 -create-app
zcc +zx -vn -SO3 -m -lm -clib=new -o 1_graphics @graphics.lst -startup=9 -create-app






del "1_graphics_CODE.bin"
del "1_graphics_UNASSIGNED.bin"

rem rename main.tap sine.tap

call beep.bat
