@echo off

setlocal ENABLEEXTENSIONS
set KEY_NAME="HKLM\SOFTWARE\Synaptics\SynTPEnh"
set VALUE_NAME="DisableIntPDFeature"
set VALUE_DATA=0x33
set VALUE_TYPE=REG_DWORD

@echo Adding registry value %KEY_NAME% \ %VALUE_NAME%
reg add %KEY_NAME%  /f /v %VALUE_NAME% /t %VALUE_TYPE% /d %VALUE_DATA%

reg query %KEY_NAME% /v %VALUE_NAME%
FOR /F "usebackq skip=2 tokens=1-3" %%A IN (`REG QUERY %KEY_NAME% /v %VALUE_NAME% 2^>nul`) DO (
    set ValueName=%%A
    set ValueType=%%B
    set ValueValue=%%C
)

if defined ValueName (
    @echo Value Name = %ValueName%
    @echo Value Type = %ValueType%
    @echo Value Value = %ValueValue%
    @echo ----------------------------
    if "%ValueValue%" == "%VALUE_DATA%" (
        @echo Registry value set correctly
    ) else (
        @echo Registry value not correctly
        @echo  ----------------------------
        @echo Please attempt to set this value manually. Open your registry
        @echo  editor and modify the following:
        @echo        Key: %KEY_NAME%
        @echo        Value Name: %VALUE_NAME%
        @echo        Value Data: %VALUE_DATA%
        @echo        Value Type: DWORD %VALUE_TYPE%
    )
) else (
    @echo %KEY_NAME%\%VALUE_NAME% not found.
)
PAUSE