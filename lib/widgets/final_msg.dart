import 'package:flutter/material.dart';
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
                color : Colors.white,
                fontSize: isMobile ? 22 : 26,
              ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [ 
            Image.asset('assets/simpledash.png'),            
            
            Text(
              'You have solved puzzle\nin $moves Moves!!',
              style: TextStyle(
                fontSize: isMobile ? 18 : 20,                
                color : const Color.fromARGB(255, 2, 63, 143),
              ),
            ),
            
          ],
        ),
      ],
    );
  }
}
