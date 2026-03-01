# Audio Not Working on Emulator - Troubleshooting Guide

## Quick Checklist

- [ ] Audio file exists: `assets/sound/bg.mp3`
- [ ] pubspec.yaml has `- assets/sound/` declared
- [ ] Emulator has volume turned **ON** (not muted)
- [ ] Audio file is valid MP3 format
- [ ] Permission issues (Android only)
- [ ] Run `flutter clean && flutter pub get`

---

## Step-by-Step Solutions

### 1. **Check Emulator Audio Settings**

**Android Emulator:**
- Open emulator settings
- Go to **Extended controls** (three dots)
- Look for **Volume** or **Audio** settings
- Make sure audio is **NOT MUTED**
- Increase volume to 50%+

**iOS Simulator:**
- Check Mac system volume (not muted)
- In Xcode settings, verify audio is enabled

### 2. **Verify Audio File**

```bash
# Navigate to your project
cd /home/wendevlife/StudioProjects/angry_sigma

# Check if file exists
ls -lh assets/sound/bg.mp3

# Check file format and size
file assets/sound/bg.mp3
```

**Expected output:**
```
-rw-r--r-- 1 user group 1.2M Mar  1 10:30 assets/sound/bg.mp3
assets/sound/bg.mp3: Audio file with ID3 version 2.3.0
```

If file is very small (<50KB) or corrupted, replace it with a valid MP3.

### 3. **Clean Build**

```bash
cd /home/wendevlife/StudioProjects/angry_sigma

# Clean everything
flutter clean

# Get dependencies
flutter pub get

# Build fresh
flutter run
```

### 4. **Check Console for Debug Messages**

When running on emulator, watch the console for these messages:

```
✓ AudioManager initialized successfully
🎵 Attempting to play: sound/bg.mp3 (volume: 0.5)
✓ Music playing successfully: sound/bg.mp3
```

**If you see error messages**, they will tell you the exact problem.

### 5. **Android-Specific: Check Manifest**

The `flame_audio` package requires these Android permissions. They should be auto-added, but verify in `android/app/src/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### 6. **Test with Simple Sound Effect**

Add this to test if audio system works at all:

```dart
// In menu_screen.dart, add this to a button:
onPressed: () async {
  await AudioManager().playSoundEffect('sound/bg.mp3', volume: 1.0);
},
```

If sound effect plays, background music should work too.

### 7. **Increase Volume Parameter**

Try maximum volume:

```dart
musicVolume: 1.0,  // Instead of 0.5
```

### 8. **Use Different Audio Format**

If MP3 doesn't work, try WAV:

1. Convert audio to WAV: https://online-convert.com/
2. Place in `assets/sound/bg.wav`
3. Update code:
   ```dart
   backgroundMusicPath: 'sound/bg.wav',
   ```

### 9. **Force Android 11+ Audio Settings**

For Android 11+, add to `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        targetSdkVersion 34
        // ... other config
    }
}
```

### 10. **Check flame_audio Version Compatibility**

Verify package is correctly installed:

```bash
flutter pub list | grep flame
```

Should show:
```
flame                          1.6.0
flame_audio                    2.1.1
```

---

## Expected Behavior

1. App launches
2. MenuScreen appears
3. Background music starts playing immediately
4. Music loops continuously
5. When you navigate away, music stops
6. When you return, music starts again

---

## Console Debug Output Example

When working correctly, you should see:

```
🎮 BackgroundGame onLoad() started
🎮 Background image loaded: bg/menu.png
🎵 Initializing AudioManager...
✓ AudioManager initialized successfully
🎵 Playing background music: sound/bg.mp3
🎵 Attempting to play: sound/bg.mp3 (volume: 0.5)
✓ Music playing successfully: sound/bg.mp3
🎮 BackgroundGame onLoad() completed
```

---

## Still Not Working?

1. **Run this to see all debug output:**
   ```bash
   flutter run -v 2>&1 | grep -E "🎵|🎮|✓|✗|Error"
   ```

2. **Check emulator audio directly:**
   ```bash
   # Android emulator - test audio system
   adb shell "am start -a android.intent.action.VIEW -d https://www.youtube.com/"
   # Try playing a YouTube video - should have sound
   ```

3. **Try on physical device** - Sometimes emulator audio is unreliable

4. **Contact support** with console output from step 1

---

## Known Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| "AudioException" | File doesn't exist or wrong path | Check assets/sound/, use exact path |
| No sound but no errors | Volume too low or muted | Increase `musicVolume` to 1.0, check emulator volume |
| Crackling/distorted audio | Bad file quality or format | Convert to MP3 or WAV with good bitrate |
| Audio plays then stops | File too short or corrupted | Replace with longer valid audio file |
| Works on device but not emulator | Emulator audio disabled | Enable emulator audio, restart emulator |

---

## Quick Test Audio Setup

I can provide you with a minimal test setup. Try this:

1. **Simplest test** - Temporarily lower the volume threshold:
   ```dart
   // In menu_screen.dart
   musicVolume: 1.0,  // Maximum volume
   ```

2. **Check logs while running:**
   ```bash
   flutter run -v 2>&1 | grep -i "audio\|flame\|bgm"
   ```

3. **Replace bg.mp3** with a known-good MP3 file

---

## Still Need Help?

Run this command and share the output:

```bash
cd /home/wendevlife/StudioProjects/angry_sigma
flutter run -v 2>&1 | head -100
```

This will show initialization details and any error messages.
