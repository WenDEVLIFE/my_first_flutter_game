#!/bin/bash

# Audio Troubleshooting Diagnostic Script
# This script helps identify why audio isn't working in your Flame game

echo "=========================================="
echo "Audio Troubleshooting Diagnostic"
echo "=========================================="
echo ""

# Check 1: Audio file exists
echo "✓ Check 1: Audio File"
if [ -f "assets/sound/bg.mp3" ]; then
    SIZE=$(ls -lh assets/sound/bg.mp3 | awk '{print $5}')
    echo "  ✓ File exists: assets/sound/bg.mp3 ($SIZE)"
    file assets/sound/bg.mp3 | sed 's/^/  /'
else
    echo "  ✗ MISSING: assets/sound/bg.mp3"
fi
echo ""

# Check 2: pubspec.yaml config
echo "✓ Check 2: pubspec.yaml Configuration"
if grep -q "- assets/sound/" pubspec.yaml; then
    echo "  ✓ Asset declared in pubspec.yaml"
else
    echo "  ✗ MISSING: asset declaration in pubspec.yaml"
fi

if grep -q "flame_audio" pubspec.yaml; then
    VERSION=$(grep "flame_audio" pubspec.yaml | head -1)
    echo "  ✓ Package configured: $VERSION"
else
    echo "  ✗ MISSING: flame_audio in dependencies"
fi
echo ""

# Check 3: Code implementation
echo "✓ Check 3: Code Implementation"
if grep -q "AudioManager" lib/src/core/background_game.dart; then
    echo "  ✓ BackgroundGame imports AudioManager"
else
    echo "  ✗ BackgroundGame missing AudioManager import"
fi

if grep -q "playBackgroundMusic" lib/src/core/background_game.dart; then
    echo "  ✓ BackgroundGame calls playBackgroundMusic"
else
    echo "  ✗ BackgroundGame not calling playBackgroundMusic"
fi

if [ -f "lib/src/core/services/audio_manager.dart" ]; then
    echo "  ✓ AudioManager service exists"
else
    echo "  ✗ MISSING: lib/src/core/services/audio_manager.dart"
fi
echo ""

# Check 4: Dependencies installed
echo "✓ Check 4: Dependencies"
if grep -q "flame_audio" pubspec.lock; then
    INSTALLED=$(grep -A 1 "name: flame_audio" pubspec.lock | tail -1 | awk '{print $2}')
    echo "  ✓ flame_audio installed: $INSTALLED"
else
    echo "  ✗ flame_audio NOT installed (run: flutter pub get)"
fi
echo ""

# Check 5: Menu screen config
echo "✓ Check 5: MenuScreen Audio Configuration"
if grep -q "backgroundMusicPath" lib/src/ui/menu_screen.dart; then
    MUSIC=$(grep "backgroundMusicPath" lib/src/ui/menu_screen.dart | head -1)
    echo "  ✓ MenuScreen configures music: $MUSIC"
else
    echo "  ✗ MenuScreen not configured with music"
fi
echo ""

echo "=========================================="
echo "Diagnostic Complete!"
echo "=========================================="
echo ""
echo "If all checks pass, run:"
echo "  flutter run -v"
echo ""
echo "Then watch console for debug messages starting with 🎵 or 🎮"
echo ""
