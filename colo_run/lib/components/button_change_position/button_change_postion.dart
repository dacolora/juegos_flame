import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../colo_run_game.dart';

class ButtonChangePosition extends StatelessWidget {
  final ColoRunGame game;

  const ButtonChangePosition({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    game.draggMario.x -= 40;
                  },
                  child: const Text('Mover L')),
              ElevatedButton(
                  onPressed: () {
                    game.draggMario.x += 40;
                  },
                  child: const Text('Mover R'))
            ],
          )
        ],
      ),
    );
  }
}
