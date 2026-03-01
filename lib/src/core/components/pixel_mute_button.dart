import 'package:flutter/material.dart';

class PixelMuteButton extends StatelessWidget {
  final bool isMuted;
  final VoidCallback onTap;
  final Color activeColor;

  const PixelMuteButton({
    super.key,
    required this.isMuted,
    required this.onTap,
    this.activeColor = const Color(0xFFE53935),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isMuted ? Colors.grey[800] : activeColor,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Center(
          child: _buildSpeakerIcon(),
        ),
      ),
    );
  }

  Widget _buildSpeakerIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Speaker body
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 6, height: 6, color: Colors.white),
            const SizedBox(width: 2),
            Container(width: 8, height: 14, color: Colors.white),
          ],
        ),
        // Mute 'X'
        if (isMuted)
          Transform.rotate(
            angle: 0.785, // 45 degrees
            child: Container(
              width: 18,
              height: 3,
              color: Colors.red[900],
            ),
          ),
      ],
    );
  }
}
