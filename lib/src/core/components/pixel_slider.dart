import 'package:flutter/material.dart';

class PixelSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final Color activeColor;
  final Color inactiveColor;

  const PixelSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor = const Color(0xFFE53935),
    this.inactiveColor = const Color(0xFF424242),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const height = 24.0;
        const barHeight = 8.0;
        const thumbSize = 20.0;

        return GestureDetector(
          onPanUpdate: (details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final localOffset = box.globalToLocal(details.globalPosition);
            _updateValue(localOffset.dx, width);
          },
          onTapDown: (details) {
            _updateValue(details.localPosition.dx, width);
          },
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Inactive bar (Pixelated background)
                Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: inactiveColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                // Active bar (Pixelated fill)
                Container(
                  height: barHeight,
                  width: (value - min) / (max - min) * width,
                  color: activeColor,
                ),
                // Thumb (Pixel block)
                Positioned(
                  left: ((value - min) / (max - min) * width) - (thumbSize / 2),
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateValue(double dx, double width) {
    double newValue = (dx / width) * (max - min) + min;
    newValue = newValue.clamp(min, max);
    onChanged(newValue);
  }
}
