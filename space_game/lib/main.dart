import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_game/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Space Game',
      home: MyGame(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyGame extends StatefulWidget {
  const MyGame({super.key, required this.title});
  final String title;

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  SpaceGame game = SpaceGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
        ],
      ),
    );
  }
}
