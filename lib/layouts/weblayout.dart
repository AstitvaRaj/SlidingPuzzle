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
  late AnimationController position;

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
    centerY = isMobile ? height / 2.5 : height / 2;
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
    if (game.isStarted && game.isPuzzleSolved()) {
      preStartAnimation.repeat();
    }
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
                  top: 0,
                  child: SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(height: 40),
                        Text(
                          'Sliding Puzzle 3D',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: 'Titan',
                          ),
                        ),
                      ],
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
            curve: Curves.decelerate,
            bottom: isMobile
                ? game.isStarted
                    ? 50
                    : height * 0.35
                : height * 0.35,
            left: isMobile? width * 0.225:100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                game.isStarted && game.isPuzzleSolved()
                    ? const Text(
                        'Congratulations!!!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : Container(),
                const SizedBox(height: 30),
                Center(
                  child: game.isStarted
                      ? InfoContainer(game: game)
                      : ChooseDifficultyLevel(
                          refershHomeScreen: () {
                            setState(() {});
                          },
                          game: game,
                        ),
                ),
                const SizedBox(height: 30),
                game.isStarted
                    ? GameResetButton(
                        refresh: () {
                          if (width < height) {
                            isMobile = true;
                          } else {
                            isMobile = false;
                          }
                          cubeSize = min(height, width) / (isMobile ? 6 : 5);
                          centerX = isMobile ? (width / 2) : (width / 2) * 1.25;
                          centerY = isMobile ? height / 2.5 : height / 2;
                          game = Game(
                            cubeSize: cubeSize,
                            centerX: centerX,
                            centerY: centerY,
                          );
                          setState(() {});
                        },
                      )
                    : GestureDetector(
                        onTap: () {
                          game = Game(
                            centerX: game.centerX,
                            centerY: game.centerY,
                            cubeSize: game.cubeSize,
                          );
                          preStartAnimation.stop();
                          game.startGame();
                          setState(() {});
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
              ],
            ),
          ),
          isMobile == false
              ? BigCube(
                  game: game,
                  anglex: anglex,
                  angley: -angley,
                  r: () {
                    setState(() {});
                  },
                )
              : game.isStarted
                  ? AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      child: BigCube(
                        game: game,
                        anglex: anglex,
                        angley: angley,
                        r: () {
                          setState(() {});
                        },
                      ),
                    )
                  : Container(),
        ],
      ),
    );
  }
}
