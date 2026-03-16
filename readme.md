# Exnum – Extract Contacts from Android (No Root, Broken Screen)

**Exnum** is a lightweight, open-source tool that helps recover your **contacts** from an Android phone — even when the screen is broken or unresponsive — **without requiring root access**.

Many people face this exact situation: a phone with a shattered/unresponsive display, no cloud/Google backup of contacts, and no desire (or possibility) to root the device (which often wipes data anyway). Exnum offers a practical workaround using **Android Debug Bridge (ADB)** and a small, specially crafted debuggable app.

### How It Works (High-Level Overview)

1. A tiny Android app (`exnum.apk`) is installed via ADB.
2. The app requests **READ_CONTACTS** permission (you confirm this manually — even blindly if the screen is broken).
3. The app reads your contacts and saves them into its private app-specific storage (`/data/data/com.example.debugcontacts/files/contacts.txt`).
4. Using ADB's `run-as` command (only works for **debuggable** apps), we extract that file to your computer.

This method relies on:
- USB debugging having been previously enabled
- The ability to authorize USB debugging and grant permissions (possibly blindly)

### Important Requirements & Limitations

**Your phone MUST meet ALL of these conditions:**

- **USB debugging** was enabled **before** the screen broke  
  (Settings → Developer options → USB debugging)
- You previously allowed **USB debugging authorization** from this computer  
  (the RSA key popup was accepted at least once)
- The device can still boot and connect via USB (not completely dead)
- Android version: tested on Android 9–14; Android 15+ may have tightened restrictions
- The phone must allow **blind interaction** for:
  - Selecting "File Transfer" / MTP mode when connecting USB
  - Granting "Allow access to contacts" when the app launches

### Step-by-Step Usage

1. **Prepare your computer**
   - Install latest [Android platform-tools (ADB)](https://developer.android.com/tools/releases/platform-tools)
   - Make sure `adb` is in your PATH or run from the platform-tools folder

2. **Connect the phone**
   - Plug the USB cable into the broken phone and your computer
   - If the phone vibrates or makes a sound → it's alive
   - When the USB options appear (usually "Charging only" / "File Transfer" / "MTP"), **blindly select File Transfer**:
     - Many devices: tap near the **bottom half** of the screen 2–3 times
     - Or try: volume keys to navigate + power to select (device-dependent)

3. **Run the extraction script**
   - Place `exnum.apk`, `exnum.sh` (Linux/macOS) or `exnum.bat` (Windows) in one folder
   - Open terminal / command prompt in that folder
     
   - Linux/macOS:  
     ```bash
     chmod +x exnum.sh
     ./exnum.sh
     
   - Windows:
     double-click exnum.bat or run in cmd
