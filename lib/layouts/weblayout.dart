import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rubikscube/widgets/big_cube.dart';
import 'package:rubikscube/model/game.dart';
import 'package:rubikscube/widgets/choose_difficulty.dart';
import 'package:rubikscube/widgets/info_container.dart';
import 'package:rubikscube/widgets/reset_button.dart';
import 'package:rubikscube/widgets/small_cube.dart';
import '../math/utils.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height, width;
  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> with TickerProviderStateMixin {
  late AnimationController preStartAnimation;
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
    preStartAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      lowerBound: 0,
      upperBound: degreeToRadian(degree: 360),
    )
      ..addListener(() {
        if (preStartAnimation.isAnimating) {
          setState(() {
            anglex = preStartAnimation.value;
            angley = degreeToRadian(degree: 10);
          });
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    preStartAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    if (width < height) {
      isMobile = true;
    } else {
      isMobile = false;
    }
    game.cubeSize = min(height, width) / (isMobile ? 6 : 5);
    setState(() {});
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
                game.rotateGame(anglex, -angley);
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: isMobile ? height * 0.05 : height * 0.1,
            left: 100,
            child: game.isStarted
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: GameResetButton(
                        game: game,
                        refresh: () {
                          game = Game(
                              cubeSize: cubeSize,
                              centerX: centerX,
                              centerY: centerY);
                          setState(() {});
                        }),
                  )
                : GestureDetector(
                    onTap: () {
                      preStartAnimation.stop();
                      game.startGame();
                      setState(() {});
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
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
                          'Start Game',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned(
            bottom: height * 0.3,
            left: 50,
            child: game.isStarted
                ? Center(
                    child: InfoContainer(
                      game: game,
                    ),
                  )
                : ChooseDifficultyLevel(
                    refershHomeScreen: () {
                      setState(() {});
                    },
                    game: game,
                  ),
          ),
          BigCube(
            game: game,
            anglex: anglex,
            angley: -angley,
            r: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
