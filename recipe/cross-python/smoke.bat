@echo off
rem FORK-ONLY smoke test: install the cross-python_win-arm64 files by hand,
rem since that package is not published yet, then run its activation.
if not exist "%BUILD_PREFIX%\etc\conda\cross-python" mkdir "%BUILD_PREFIX%\etc\conda\cross-python"
copy /y "%RECIPE_DIR%\cross-python\sitecustomize.py" "%BUILD_PREFIX%\etc\conda\cross-python\sitecustomize.py"
if errorlevel 1 exit /b 1
"%BUILD_PREFIX%\python.exe" "%RECIPE_DIR%\cross-python\render.py" "%RECIPE_DIR%\cross-python\activate-cross-python.bat" "%BUILD_PREFIX%\etc\conda\cross-python\activate.bat"
if errorlevel 1 exit /b 1
type "%BUILD_PREFIX%\etc\conda\cross-python\activate.bat"
call "%BUILD_PREFIX%\etc\conda\cross-python\activate.bat"
"%PYTHON%" -c "import sysconfig; print('cross-python smoke:', sysconfig.get_platform(), sysconfig.get_config_var('EXT_SUFFIX'))"
if errorlevel 1 exit /b 1
type "%BUILD_PREFIX%\etc\conda\cross-python\distutils.cfg"
exit /b 0
