import 'package:angry_sigma/src/core/states/game_state.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/ui/menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set fullscreen and landscape orientation
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Angry Sigma',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'PixelFont',
        ),
        home: const MenuScreen(),
      ));
  }
}