@echo off
setlocal enableextensions enabledelayedexpansion
rem example token : ************************.******.***************************

set "Outfile=Keys.txt"
if exist Keys.txt goto :error

:start
set "compte=0"
for %%a in (a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 . -) do (
    set "a_!size!=%%a"
    set /a "size+=1"
    )
mode con lines=24 cols=70
echo      [40;36m    How many keys do you want to Generate? (0 = inifinity)
set /p keys=
mode con lines=10 cols=40
if %keys% == 0 (goto:infinity) else (goto:generate)

:infinity
    for /l %%k in (1 100 100) do (
        set "key="
        for /l %%a in (1 1 30) do (
            set /a "r=!random! %% size"
            for %%b in (!r!) do set "key=!key!!a_%%b!"
            set "fin=!key:~0,26!"
            set "midd=!key:~0,6!"
        )
        echo(!key:~0,5!!key:~5,5!!key:~10,5!!key:~15,5!!key:~20,5!.%midd%.%fin% >> %Outfile%
        goto :addinf
        )
:addinf
set /a "compte+=1"
echo              [40;32m%compte% keys add...
if %compte% == 270000 (goto :infend) else (goto :infinity)

:generate
    for /l %%k in (1 100 %keys%) do (
        set "key="
        for /l %%a in (1 1 30) do (
            set /a "r=!random! %% size"
            for %%b in (!r!) do set "key=!key!!a_%%b!"
            set "fin=!key:~0,26!"
            set "midd=!key:~0,6!"
        )
        echo(!key:~0,5!!key:~5,5!!key:~10,5!!key:~15,5!!key:~20,5!.%midd%.%fin% >> %Outfile%
        goto :addcompte
    ) 

:addcompte
set /a "compte+=1"
echo              [40;32m%compte% keys add...
if %compte% == %keys% (goto :end) else (goto :generate)

:end 
cls
echo                  [40;32mDone.
echo.
if %keys% == 1 (echo        Your %keys% key are created.) else (echo        Yours %keys% keys are created.)
goto :choice 

:infend
cls
echo                  [40;32mDone.
echo.
echo         Yours keys are created.
goto :choice

:choice
echo.
set /p c=       [40;31mDo you want to exit {Y/N} : 
if /I "%c%" EQU "y" goto :q
if /I "%c%" EQU "n" goto :w
goto :choice
:q
for /F "skip=1 delims=" %%i in (Keys.txt) do echo %%i >>temp1.txt
del Keys.txt
ren temp1.txt Keys.txt
echo(!key:~0,5!!key:~5,5!!key:~10,5!!key:~15,5!!key:~20,5!.%midd%.%fin% >> keys.txt
echo        [40;32mGoodBye !
timeout /t 2 >nul
exit
:w
cls
goto :start

:error
mode con lines=6 cols=55
cls
echo.
echo.
echo            [40;31m Error. The file is already exist.
timeout /t 2 >nul
cls 
set /p rename=  [40;31mDo you want to rename it ? {Y/N} 
if /I "%rename%" EQU "y" goto :Y
if /I "%rename%" EQU "n" goto :N
:Y 
cls 
echo.
set /p newname= [40;31mChoose a new name: 
ren %Outfile% %newname%
echo        [40;32mFile name is changed 
timeout /t 2 >nul
goto :start
:N 
mode con lines=6 cols=40
cls
echo.
echo                 [40;32mGoodBye !
timeout /t 2 >nul
exit

:exit_
exit
endlocal
