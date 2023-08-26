#!/bin/bash

# Define the paths
APK_PATH="AndroidStudioProjects/DebugContacts/app/build/outputs/apk/debug/exnum.apk"
OUTPUT_PATH="contactsinfo.txt"

# Install the app
adb install "$APK_PATH"

# Start the app
adb shell am start -n com.example.debugcontacts/.MainActivity

# Wait for manual confirmation
echo "Please confirm access to contact on the phone screen and then press enter."
read

# Enter adb shell
adb shell << SHELL_END

# Switch to app directory with proper permissions
run-as com.example.debugcontacts

# Navigate to the app's files directory
cd files

# Exit run-as
exit

# Exit adb shell
exit
SHELL_END

# Extract the contacts file
adb exec-out run-as com.example.debugcontacts cat files/contacts.txt > "$OUTPUT_PATH"

# Done
echo "Operation completed!"
