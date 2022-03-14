import 'package:flutter/material.dart';

class GameResetButton extends StatelessWidget {
  const GameResetButton({Key? key, this.refresh, required this.isMobile})
      : super(key: key);
  final Function()? refresh;
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        refresh!();
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 20,
          bottom: 20,
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 7, 124, 219),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Text(
            'Reset Game',
            style: TextStyle(
              fontSize: isMobile ? 20 : 25,
            ),
          ),
        ),
      ),
    );
  }
}
