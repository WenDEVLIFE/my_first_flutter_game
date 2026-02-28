import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PixelButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final Size? minimumSize;

  const PixelButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF4CAF50),
    this.textColor = Colors.white,
    this.fontSize = 20.0,
    this.minimumSize,
  });

  @override
  State<PixelButton> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Transform.translate(
        offset: _isPressed ? const Offset(0, 4) : Offset.zero,
        child: Container(
          constraints: widget.minimumSize != null 
              ? BoxConstraints(minWidth: widget.minimumSize!.width, minHeight: widget.minimumSize!.height)
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            // 8-bit style solid shadow and borders
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: _isPressed
                ? []
                : [
                    const BoxShadow(
                      color: Colors.black,
                      offset: Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: GoogleFonts.pixelifySans(
              color: widget.textColor,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
