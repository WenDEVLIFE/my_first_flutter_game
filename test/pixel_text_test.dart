import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixelify_flutter/pixelify_flutter.dart';

void main() {
  testWidgets('PixelText glitch test', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('FLUTTER ERROR: ${details.exception}');
    };
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: PixelText(
              text: 'GLITCH TEXT',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                fontSize: 24,
                color: Colors.red,
              ),
              effect: PixelTextEffect.glitch,
              effectDuration: Duration(milliseconds: 200),
            )
          )
        )
      )
    );
    await tester.pump();
    expect(find.text('GLITCH TEXT'), findsWidgets);
  });
}
