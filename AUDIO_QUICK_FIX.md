# Audio Troubleshooting - Quick Reference

## The Problem
Music isn't playing on emulator, but code is correct ✅

## Top 3 Fixes (Try in Order)

### Fix #1: Emulator Volume (Most Likely)
**Android Emulator:**
- Click **Extended Controls** (⋯ button on emulator side)
- Go to **Audio** tab
- Move slider to 50% or higher
- Make sure NOT in silent mode

**iOS Simulator:**
- Check Mac volume (top right)
- Make sure NOT muted

### Fix #2: Maximum Volume Parameter
Edit `lib/src/ui/menu_screen.dart`:
```dart
musicVolume: 1.0,  // Changed from 0.5 for testing
```

### Fix #3: Restart Everything
```bash
flutter clean
flutter pub get
flutter run
```

## Verify It's Working
Watch for these messages in console:
```
🎮 BackgroundGame onLoad() started
🎵 Initializing AudioManager...
✓ AudioManager initialized successfully
🎵 Playing background music: sound/bg.mp3
🎮 BackgroundGame onLoad() completed
```

If you see these → problem is emulator, not code!

## Test Audio Works
Add to a button's onPressed:
```dart
await AudioManager().playSoundEffect('sound/bg.mp3', volume: 1.0);
```
If button sound plays → system works → background should too

## Files Changed
- ✏️ `pubspec.yaml` - Added flame_audio
- ✏️ `lib/src/core/background_game.dart` - Added music playback + debug logs
- ✨ `lib/src/core/services/audio_manager.dart` - Full audio service
- ✏️ `lib/src/ui/menu_screen.dart` - Music parameters
- ✨ `AUDIO_TROUBLESHOOTING.md` - Full troubleshooting guide
- ✨ `AUDIO_NOT_WORKING_SOLUTIONS.md` - Specific solutions

## Next Steps
1. Check emulator volume first
2. Run `flutter run -v` and watch for 🎵 messages
3. If no messages, post console output
4. If you hear sound on physical device, it's just emulator audio
