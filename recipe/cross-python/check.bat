@echo off
rem FORK-ONLY smoke test: show what the cross build produced.
dir /s /b "%PREFIX%\*.pyd"
for /r "%PREFIX%" %%f in (*.pyd) do dumpbin /headers "%%f" | findstr /i /c:"machine"
dir /b "%PREFIX%\Lib\site-packages"
exit /b 0
