@echo off

echo Hello. This script will create a new registry value disabling the touchpad when a mouse is connected.
echo This can be reversed by deleting the following registry key value:
echo HKEY_LOCAL_MACHINE\SOFTWARE\Synaptics\SynTPEnh\DisableIntPDFeature
echo.

reg add "HKLM\SOFTWARE\Synaptics\SynTPEnh"  /f /v "DisableIntPDFeature" /t REG_DWORD /d "51"
echo.
reg query "HKLM\SOFTWARE\Synaptics\SynTPEnh" /v "DisableIntPDFeature"

PAUSE