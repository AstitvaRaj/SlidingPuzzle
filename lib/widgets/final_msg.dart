import 'package:flutter/material.dart';
import 'package:rubikscube/widgets/reset_button.dart';

class FinalMessage extends StatelessWidget {
  const FinalMessage({Key? key, required this.moves, required this.isMobile})
      : super(key: key);
  final String moves;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Good Job!', style: TextStyle(
                fontSize: isMobile ? 22 : 26,
              ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You have solved puzzle\nin $moves Moves!!',
              style: TextStyle(
                fontSize: isMobile ? 18 : 20,
              ),
            ),
            Image.asset('assets/simpledash.png'),
          ],
        ),
      ],
    );
  }
}
