# Exnum Instructions

Exnum provides a solution for retrieving contacts from an Android phone without root access. The Android security model is built to prevent unauthorized data access. If you've found yourself with a broken phone screen and without a recent backup of your contacts, it might seem like you're out of luck. Rooting the phone isn't an option either, as this would erase all your data.

  **Important :** *Your phone must have previously been set to developer mode with USB debugging enabled.
    Even if the screen is broken, you should be able to interact with it blindly. This is necessary for steps like selecting "File Transfer" as the USB mode and authorizing app access to your contacts.*

## Steps to Run Exnum:

  1. Connect your phone to your computer.
  2. When prompted with "Use USB for," select "File Transfer."
  3. Navigate (cd) to the directory containing the exnum.sh script.
  4 .Execute the script using: `./exnum.sh`
  5. Blindly authorize the app to access your contacts when prompted on your phone.
  6. Upon successful completion, you will find a file named contactinfo.txt in your /home directory.

Remember, before running any script or tool, especially ones that interact with device data or settings, always ensure you understand its operation and implications.
