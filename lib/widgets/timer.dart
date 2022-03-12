import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class Timer extends StatelessWidget {
  const Timer({Key? key, required this.time}) : super(key: key);
  final String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Time',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
       
      ],
    );
  }
}
