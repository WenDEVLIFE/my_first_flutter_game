# Background Audio Implementation in Flame - Complete Guide

## Overview
This guide explains how to implement background audio in your Flame game using the `flame_audio` package.

## Architecture

Your implementation uses a **singleton AudioManager** pattern to manage all audio playback:

```
AudioManager (Singleton)
    ├── Background Music (using FlameAudio.bgm)
    └── Sound Effects (using FlameAudio.play)

BackgroundGame (extends FlameGame)
    └── Uses AudioManager to play/stop music
    
MenuScreen (Flutter Widget)
    └── Creates BackgroundGame with music parameters
```

## What Was Added

### 1. **dependencies in pubspec.yaml**
   - Added `flame_audio: ^2.1.1` package for audio playback

### 2. **AudioManager Service** (`lib/src/core/services/audio_manager.dart`)
   - Singleton pattern for centralized audio management
   - Methods for:
     - `playBackgroundMusic()` - Play looping background music
     - `stopBackgroundMusic()` - Stop current music
     - `pauseBackgroundMusic()` - Pause music (can resume)
     - `resumeBackgroundMusic()` - Resume paused music
     - `setBackgroundMusicVolume()` - Adjust volume
     - `playSoundEffect()` - Play non-looping sound effects
     - Properties to check music status

### 3. **BackgroundGame Updates**
   - Added parameters: `backgroundMusicPath` and `musicVolume`
   - Music playback starts in `onLoad()`
   - Music stops in `onRemove()` for cleanup

### 4. **MenuScreen Updates**
   - Now passes music parameters to BackgroundGame

## Usage Examples

### Play Background Music
```dart
final game = BackgroundGame(
  assetPath: 'bg/menu.png',
  backgroundMusicPath: 'sound/menu_music.mp3',
  musicVolume: 0.5,  // 0.0 to 1.0
);
```

### Control Music in Your Game/Screen
```dart
final audioManager = AudioManager();

// Play music
await audioManager.playBackgroundMusic('sound/gameplay.mp3', volume: 0.7);

// Pause
await audioManager.pauseBackgroundMusic();

// Resume
await audioManager.resumeBackgroundMusic();

// Stop
await audioManager.stopBackgroundMusic();

// Set volume
await audioManager.setBackgroundMusicVolume(0.3);

// Play sound effect
await audioManager.playSoundEffect('sound/click.mp3', volume: 1.0);

// Check status
if (audioManager.isBackgroundMusicPlaying) {
  print('Music is playing: ${audioManager.currentBackgroundMusic}');
}
```

## File Structure

```
lib/src/core/
├── background_game.dart          (Updated with audio support)
├── services/
│   └── audio_manager.dart        (New - Audio service)
│
ui/
├── menu_screen.dart              (Updated with music parameters)
```

## Asset Structure Required

Your audio files should be in:
```
assets/
└── sound/
    ├── menu_music.mp3
    ├── gameplay_music.mp3
    ├── click.mp3
    └── ... (other audio files)
```

**Make sure these files are declared in pubspec.yaml** (already configured):
```yaml
flutter:
  assets:
    - assets/images/bg/
    - assets/sound/
```

## Key Features

✅ **Singleton Pattern** - Only one audio manager across the app
✅ **Automatic Looping** - Background music loops by default
✅ **Clean Lifecycle** - Music stops when game is removed
✅ **Volume Control** - Easy volume adjustment
✅ **Sound Effects** - Support for non-looping sound effects
✅ **Error Handling** - Try-catch blocks for robustness

## Next Steps

1. **Get audio files**: Add your `.mp3` or `.wav` files to `assets/sound/`
2. **Run flutter pub get**: `flutter pub get` to install dependencies
3. **Test**: Run your app and verify music plays
4. **Customize**: Adjust volumes, add more screens with different music

## Common Issues & Solutions

### Issue: "AudioException" or audio not playing
**Solution**: 
- Verify audio files exist in `assets/sound/`
- Check filename matches exactly (case-sensitive)
- Run `flutter clean && flutter pub get`

### Issue: Music too loud/quiet
**Solution**: Adjust `musicVolume` parameter:
```dart
musicVolume: 0.3,  // 30% volume
```

### Issue: Glitchy audio or cutoffs
**Solution**: Use `.mp3` format (better compatibility) and ensure files are properly encoded

## Advanced: Playing Different Music for Different Screens

```dart
// Menu Screen
final menuGame = BackgroundGame(
  assetPath: 'bg/menu.png',
  backgroundMusicPath: 'sound/menu_music.mp3',
  musicVolume: 0.5,
);

// Game Screen - switch music
await AudioManager().playBackgroundMusic('sound/gameplay_music.mp3', volume: 0.6);

// Result Screen
await AudioManager().playBackgroundMusic('sound/result_music.mp3', volume: 0.4);
```

The AudioManager automatically stops the previous track and plays the new one!

## Flame Audio Package Docs
https://pub.dev/packages/flame_audio

## Flutter Audio Resources
https://flutter.dev/docs/development/packages-and-plugins/using-packages#audio
