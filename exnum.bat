@echo off
setlocal EnableDelayedExpansion

:: ===================
:: Configuration
:: ===================
set "APK_PATH=.\exnum.apk"
set "OUTPUT_PATH=contactsinfo.txt"

echo Disabling ADB verification to avoid Play Protect block...
echo.
adb shell settings put global verifier_verify_adb_installs 0

echo.
echo Starting ADB operations...
echo.

:: ===================
:: 1. Install the APK
:: ===================
echo Installing APK...
adb install "%APK_PATH%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: APK installation failed
    pause
    exit /b 1
)

:: ===================
:: 2. Start the application
:: ===================
echo Starting the app...
adb shell am start -n com.example.debugcontacts/.MainActivity
echo.

:: ===================
:: 3. Wait for user to grant contacts permission
:: ===================
echo.
echo ┌────────────────────────────────────────────────────────────┐
echo │   On the phone:                                            │
echo │   • Allow access to contacts when the app asks             │
echo │   • Confirm any permission dialogs                         │
echo │                                                            │
echo │   After you grant permission → press ENTER here            │
echo └────────────────────────────────────────────────────────────┘
echo.
pause >nul

:: ===================
:: 4. The tricky part: run-as + cat in one command
:: ===================
echo Extracting contacts.txt from app's private storage...

adb exec-out "run-as com.example.debugcontacts cat files/contacts.txt" > "%OUTPUT_PATH%"

:: Check if we got something
if exist "%OUTPUT_PATH%" (
    for %%F in ("%OUTPUT_PATH%") do set size=%%~zF
    if !size! GTR 0 (
        echo.
        echo Extraction appears successful.
        echo File saved as: %OUTPUT_PATH%
        echo Size: !size! bytes
    ) else (
        echo.
        echo WARNING: File was created but is empty (0 bytes)
        echo Possible causes:
        echo   • contacts.txt was not created by the app
        echo   • permission was not granted
        echo   • file is in different location
    )
) else (
    echo.
    echo ERROR: Could not extract the file
    echo Possible causes:
    echo   • run-as failed (app not debuggable?)
    echo   • contacts.txt does not exist
    echo   • permission denied
    echo   • adb connection lost
)

echo.
echo Operation finished.
echo.

pause
endlocal