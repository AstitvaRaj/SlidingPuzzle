import 'package:flutter/material.dart';
import 'package:rubikscube/model/game.dart';
import 'package:rubikscube/widgets/moves.dart';
import 'package:rubikscube/widgets/timer.dart';
import 'package:timer_builder/timer_builder.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({Key? key, required this.game}) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Moves(moves: game.moves.toString()),
        const SizedBox(
          width: 25,
        ),
        TimerBuilder.periodic(
          const Duration(seconds: 1),
          builder: (context) {
            int seconds = DateTime.now().difference(game.dateTime).inSeconds;
            double minutes = seconds/60;
            seconds = seconds%60;
            return Timer(
              time:'${minutes<10?'0':''}${minutes.toInt()}:${seconds<10?'0':''}$seconds'
            );
          },
        ),
      ],
    );
  }
}
