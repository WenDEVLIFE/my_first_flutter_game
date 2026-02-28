import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:angry_sigma/src/ui/menu_screen.dart';

void main() {
  testWidgets('MenuScreen test', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('FLUTTER ERROR: ${details.exception}');
    };
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MenuScreen()
        )
      )
    );
    await tester.pump();
    expect(find.byType(MenuScreen), findsWidgets);
  });
}
