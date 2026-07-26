# iOS Installation Guide (Free — No Apple Developer Account)

This guide covers sideloading the Goods Scanner IPA onto family members' iPhones using **AltStore** — entirely free, no \$99/year Apple Developer account needed.

---

## How It Works

```
You (Windows PC)
    │
    ├── GitHub Actions builds unsigned IPA in the cloud (free macOS runner)
    │
    ├── Download .ipa from GitHub Actions tab
    │
    ├── AltServer on Windows → signs .ipa with your free Apple ID
    │
    └── AltStore on each iPhone → installs and manages the app
```

The app expires after **7 days** and must be refreshed. AltStore handles this automatically when your iPhone and Windows PC are on the same WiFi.

---

## Step 1 — Get the IPA

1. Go to your GitHub repo → **Actions** tab
2. Click the latest successful `Build iOS IPA` workflow run
3. Scroll to **Artifacts** → download `GoodsScanner-iOS.zip`
4. Extract the zip → you get `GoodsScanner.ipa`

---

## Step 2 — Install AltServer on Windows

1. Go to [altstore.io](https://altstore.io) and download AltServer for Windows
2. Run the installer
3. AltServer runs in your system tray (look for the diamond icon near the clock)

---

## Step 3 — Install AltStore on Each iPhone

Do this once per phone:

1. Connect the iPhone to your Windows PC via USB
2. **Trust the computer** when prompted on the iPhone (Settings will show a prompt)
3. Right-click the AltServer tray icon → **Install AltStore** → select your iPhone
4. Enter your **free Apple ID** email and password when prompted
    - AltServer sends this directly to Apple for signing; it is not stored
    - If you get an error about "Apple ID not allowed", you may need to create a new Apple ID for this purpose (AltStore works best with a dedicated Apple ID)
5. AltStore app appears on the iPhone's home screen

---

## Step 4 — Install Goods Scanner on Each iPhone

1. Open **AltStore** on the iPhone
2. Go to the **My Apps** tab
3. Tap the **+** button in the top-left
4. Browse to the `GoodsScanner.ipa` file you downloaded
    - You can host it on a cloud drive (iCloud, Google Drive, Dropbox) and download + open it from there
    - Or use iTunes File Sharing / a local web server to transfer the .ipa
5. Enter your Apple ID credentials again when prompted
6. Wait for the installation to complete

**Alternative: Use Sideloadly**

If AltStore gives you trouble:

1. Download [Sideloadly](https://sideloadly.io) on your Windows PC
2. Connect the iPhone via USB
3. Drag `GoodsScanner.ipa` into Sideloadly
4. Enter your Apple ID, click Start
5. The app installs directly

---

## Step 5 — Trust the Developer Certificate

First time opening any sideloaded app:

1. Go to **Settings → General → VPN & Device Management**
2. Tap your Apple ID email under **Developer App**
3. Tap **Trust "[your email]"**
4. Confirm

Now open Goods Scanner from the home screen — it will work for 7 days.

---

## Refreshing Every 7 Days

**Automatic refresh** (recommended):

1. AltServer must be **running** on your Windows PC
2. Your iPhone must be on the **same WiFi network**
3. AltStore background-refreshes all apps silently before they expire
4. You can check the countdown in AltStore → **My Apps**

**Manual refresh** (if automatic fails):

1. Open AltStore on the iPhone
2. Tap **Refresh All**
3. Enter your Apple ID password
4. Apps are refreshed for another 7 days

If your PC is off or on a different network, just open AltStore and tap **Refresh All** while your phone has internet — it will refresh remotely (though less reliably).

---

## Troubleshooting

| Problem | Fix |
|---|---|
| "Could not find AltServer" | Make sure AltServer is running on Windows and both devices are on the same WiFi |
| Apple ID rejected | Create a new free Apple ID (Settings → Sign in to iPhone → Don't have an Apple ID?) |
| "Maximum number of free apps" | Free Apple IDs support up to 3 sideloaded apps at a time. Remove old apps in AltStore → My Apps |
| App crashes on launch | Re-download the latest IPA from Actions and reinstall |
| AltStore says "Unable to verify" | Re-trust the certificate (Step 5) or refresh the app |
