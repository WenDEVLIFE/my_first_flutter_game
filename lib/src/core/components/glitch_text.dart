import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Duration effectDuration;

  const GlitchText({
    super.key,
    required this.text,
    this.fontSize = 24.0,
    this.color = Colors.white,
    this.effectDuration = const Duration(milliseconds: 200),
  });

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText> {
  Offset _glitchOffset1 = Offset.zero;
  Offset _glitchOffset2 = Offset.zero;
  Timer? _effectTimer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startGlitchTimer();
  }

  void _startGlitchTimer() {
    _effectTimer = Timer.periodic(widget.effectDuration, (_) {
      if (!mounted) return;
      setState(() {
        _glitchOffset1 = Offset(
          _random.nextDouble() * 4 - 2,
          _random.nextDouble() * 4 - 2,
        );
        _glitchOffset2 = Offset(
          _random.nextDouble() * 4 - 2,
          _random.nextDouble() * 4 - 2,
        );
      });
    });
  }

  @override
  void dispose() {
    _effectTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var baseStyle = GoogleFonts.pixelifySans(
      fontSize: widget.fontSize,
      color: widget.color,
    );

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center, // Make sure Stack respects center alignment if possible
      children: [
        Positioned(
          left: _glitchOffset1.dx,
          top: _glitchOffset1.dy,
          child: Text(widget.text,
              style: baseStyle.copyWith(color: Colors.red.withOpacity(0.6))),
        ),
        Positioned(
          left: _glitchOffset2.dx,
          top: _glitchOffset2.dy,
          child: Text(widget.text,
              style: baseStyle.copyWith(color: Colors.blue.withOpacity(0.6))),
        ),
        Text(widget.text, style: baseStyle),
      ],
    );
  }
}
