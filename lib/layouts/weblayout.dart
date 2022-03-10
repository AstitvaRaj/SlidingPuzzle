import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rubikscube/widgets/big_cube.dart';
import 'package:rubikscube/widgets/cubelets.dart';
import 'package:rubikscube/widgets/game.dart';
import 'package:rubikscube/widgets/small_cube.dart';
import '../math/formula.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height, width;
  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> with TickerProviderStateMixin {
  late AnimationController animationController;
  late bool isMobile;
  late SmallCube smallCube, secondCube;
  late Game game;
  late double cubeSize;
  late double centerX;
  late double centerY;
  double anglex = 0, angley = 0, anglez = 0;
  double cursorX = 0, cursorY = 0;
  late double height;
  late double width;

  @override
  void initState() {
    super.initState();
    height = widget.height;
    width = widget.width;
    if (width < height) {
      isMobile = true;
    } else {
      isMobile = false;
    }
    cubeSize = min(height, width) / (isMobile ? 6 : 5);
    centerX = isMobile ? (width / 2) : (width / 2) * 1.25;
    centerY = height / 2;
    game = Game(
      cubeSize: cubeSize,
      centerX: centerX,
      centerY: centerY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                cursorX = details.localPosition.dx;
                cursorY = details.localPosition.dy;
              });
            },
            onPanUpdate: (details) => setState(
              () {
                angley =
                    (angley + ((details.localPosition.dy - cursorY) / 5000)) %
                        degreeToRadian(degree: 360);
                anglex =
                    (anglex + ((details.localPosition.dx - cursorX) / 5000)) %
                        degreeToRadian(degree: 360);
                        game.rotateGame(anglex, angley);
              },
            ),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(1, 1, 110, 1),
                    Colors.blue.shade700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          isMobile
              ? Positioned(
                  top: height * 0.05,
                  child: Center(
                    child: Text(
                      'Sliding Puzzle 3D',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontFamily: 'Titan',
                      ),
                    ),
                  ),
                )
              : Positioned(
                  top: height * 0.05,
                  left: 100,
                  child: const Text(
                    'Sliding\nPuzzle\n3D',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'Titan',
                    ),
                  ),
                ),
          Positioned(
            bottom: isMobile ? height * 0.05 : height * 0.1,
            left: 100,
            child: GestureDetector(
              onTap: () => game.startGame(),
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
                child: const Center(
                  child: Text(
                    'Start Game ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: height / 2,
            left: width / 9,
            child: const Text('Moves'),
          ),
          BigCube(
            game: game,
            anglex: anglex,
            angley: angley,
          )
          
        ],
      ),
    );
  }
}
