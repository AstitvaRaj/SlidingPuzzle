import 'package:flutter/material.dart';

class Moves extends StatelessWidget {
  Moves({Key? key, required this.moves}) : super(key: key);
  String moves;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Moves',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          moves,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
