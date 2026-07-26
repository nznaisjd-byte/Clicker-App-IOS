# TapCounter — build a real .ipa with no Mac

This repo builds itself. Push it to GitHub, GitHub spins up a real macOS
machine for free, compiles the app, and hands you back a `.ipa` file.

## 1. Push to GitHub

1. Go to github.com → New repository (name it whatever, e.g. `tapcounter`)
2. Upload everything in this folder to that repo (drag-and-drop on the
   GitHub website works fine, or `git push` if you're comfortable with git)
3. Make sure the folder structure stays intact:
   ```
   TapCounter/
     project.yml
     .github/workflows/build.yml
     TapCounter/
       TapCounterApp.swift
       ContentView.swift
       SettingsView.swift
   ```

## 2. Run the build

1. In your GitHub repo, click the **Actions** tab
2. Click **Build IPA** on the left, then **Run workflow** → **Run workflow**
3. Wait ~2-3 minutes (it's building on an actual Mac in the cloud)
4. When it's green, click into the finished run → scroll to **Artifacts**
   → download `TapCounter-ipa` (a zip containing `TapCounter.ipa`)

Every time you push new code, it rebuilds automatically too.

## 3. Get the IPA onto your iPhone

The IPA from this workflow is **unsigned** (Apple requires every app to be
signed, and only Xcode can sign for free — GitHub's Mac can build but has no
Apple ID to sign with). To install it, use a free sideloading tool that
signs it for you with your own Apple ID:

**Sideloadly** (Windows or Mac, easiest): sideloadly.io
1. Install Sideloadly, plug in your iPhone with a cable
2. Drag `TapCounter.ipa` into Sideloadly
3. Enter your Apple ID (free account is fine) when prompted
4. It signs and installs the app on your phone directly

Note: apps signed with a free Apple ID expire after 7 days — just re-run
Sideloadly to reinstall. **AltStore** (also free) can auto-refresh this for
you in the background if you don't want to redo it weekly.

## What's in the app
- Big counter, `+` and `−` buttons, pure black & white UI
- Settings (gear icon, top right) with 3 lines:
  - **Step Size** — how much each tap changes the count by (1–100)
  - **Multiplier** — multiplies the step (1x–20x)
  - **Haptic Feedback** — on/off toggle for tap vibration
- Reset Counter button in settings
- Everything persists automatically between launches
