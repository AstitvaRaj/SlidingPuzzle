import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rubikscube/widgets/big_cube.dart';
import 'package:rubikscube/model/game.dart';
import 'package:rubikscube/widgets/choose_difficulty.dart';
import 'package:rubikscube/widgets/glassmorphism.dart';
import 'package:rubikscube/widgets/info_container.dart';
import 'package:rubikscube/widgets/reset_button.dart';
import 'package:rubikscube/widgets/small_cube.dart';
import '../math/utils.dart';

class WebLayout extends StatefulWidget {
  const WebLayout(
      {Key? key, required this.height, required this.width, required this.game})
      : super(key: key);
  final double height, width;
  final Game game;
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
  late AnimationController onCompletePuzzle;
  late Animation<double> angleXReset, angleYReset;

  @override
  void initState() {
    super.initState();
    game = widget.game;

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
    onCompletePuzzle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    super.dispose();
    preStartAnimation.dispose();
    onCompletePuzzle.dispose();
  }

  void triggerSwapAnimation(List<int> ids) {
    AnimationController swapAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    List<Animation<double>> animations = [];
    if (ids.isNotEmpty) {
      ids.insert(0, 27);
      int temp = 0;
      temp = game.cubelets[26].initialCordinates[0] ==
              game.cubelets[ids[1] - 1].initialCordinates[0]
          ? temp
          : 1;
      temp = game.cubelets[26].initialCordinates[1] ==
              game.cubelets[ids[1] - 1].initialCordinates[1]
          ? temp
          : 2;
      temp = game.cubelets[26].initialCordinates[2] ==
              game.cubelets[ids[1] - 1].initialCordinates[2]
          ? temp
          : 3;
      game.moves++;
      switch (temp) {
        case 1:
          for (int i = 0; i < ids.length; i++) {
            animations.add(
              Tween<double>(
                begin: game.cubelets[ids[i] - 1].initialCordinates[0],
                end: game
                    .cubelets[ids[(i - 1) == -1 ? ids.length - 1 : i - 1] - 1]
                    .initialCordinates[0],
              ).animate(CurvedAnimation(
                  parent: swapAnimation, curve: Curves.bounceOut)),
            );
            game.swapCurrentState(
                game.cubelets[ids[i] - 1].i,
                game.cubelets[ids[i] - 1].j,
                game.cubelets[ids[i] - 1].k,
                game.cubelets[26].i,
                game.cubelets[26].j,
                game.cubelets[26].k);
            game.swapCubeletsIndex(
                game.cubelets[ids[i] - 1], game.cubelets[26]);
          }

          swapAnimation
            ..addListener(() {
              for (int i = 0; i < ids.length; i++) {
                game.cubelets[ids[i] - 1].initialCordinates[0] =
                    animations[i].value;
              }
              setState(() {});
            })
            ..forward();
          break;
        case 2:
          for (int i = 0; i < ids.length; i++) {
            animations.add(
              Tween<double>(
                begin: game.cubelets[ids[i] - 1].initialCordinates[1],
                end: game
                    .cubelets[ids[(i - 1) == -1 ? ids.length - 1 : i - 1] - 1]
                    .initialCordinates[1],
              ).animate(CurvedAnimation(
                  parent: swapAnimation, curve: Curves.bounceOut)),
            );
            game.swapCurrentState(
                game.cubelets[ids[i] - 1].i,
                game.cubelets[ids[i] - 1].j,
                game.cubelets[ids[i] - 1].k,
                game.cubelets[26].i,
                game.cubelets[26].j,
                game.cubelets[26].k);
            game.swapCubeletsIndex(
                game.cubelets[ids[i] - 1], game.cubelets[26]);
          }

          swapAnimation
            ..addListener(() {
              for (int i = 0; i < ids.length; i++) {
                game.cubelets[ids[i] - 1].initialCordinates[1] =
                    animations[i].value;
              }
              setState(() {});
            })
            ..forward();
          break;
        case 3:
          for (int i = 0; i < ids.length; i++) {
            animations.add(
              Tween<double>(
                begin: game.cubelets[ids[i] - 1].initialCordinates[2],
                end: game
                    .cubelets[ids[(i - 1) == -1 ? ids.length - 1 : i - 1] - 1]
                    .initialCordinates[2],
              ).animate(CurvedAnimation(
                  parent: swapAnimation, curve: Curves.bounceOut)),
            );
            game.swapCurrentState(
                game.cubelets[ids[i] - 1].i,
                game.cubelets[ids[i] - 1].j,
                game.cubelets[ids[i] - 1].k,
                game.cubelets[26].i,
                game.cubelets[26].j,
                game.cubelets[26].k);
            game.swapCubeletsIndex(
                game.cubelets[ids[i] - 1], game.cubelets[26]);
          }

          swapAnimation
            ..addListener(() {
              for (int i = 0; i < ids.length; i++) {
                game.cubelets[ids[i] - 1].initialCordinates[2] =
                    animations[i].value;
              }
              setState(() {});
            })
            ..forward();
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (game.isStarted && game.isPuzzleSolved()) {
      angleXReset = Tween<double>(begin: anglex, end: degreeToRadian(degree: 0))
          .animate(
              CurvedAnimation(parent: onCompletePuzzle, curve: Curves.easeOut));
      angleYReset =
          Tween<double>(begin: angley, end: degreeToRadian(degree: 10)).animate(
              CurvedAnimation(parent: onCompletePuzzle, curve: Curves.easeOut));
      onCompletePuzzle
        ..addListener(() {
          anglex = angleXReset.value;
          angley = angleYReset.value;
          if (onCompletePuzzle.isCompleted) {
            onCompletePuzzle.reset();
            preStartAnimation.repeat();
            Future.delayed(const Duration(seconds: 10),(){
              game.isStarted = false;              
              setState((){});
            });
            
          }
          setState(() {});
        })
        ..forward();
    }
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    bool isMobile;
    if (width < height) {
      isMobile = true;
    } else {
      isMobile = false;
    }
    cubeSize = min(height, width) / (isMobile ? 6 : 5);
    centerX = isMobile ? (width / 2) : (width / 2) * 1.25;
    centerY = isMobile ? height / 2.5 : height / 2;

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
            onPanUpdate: (details) {
              angley =
                  (angley + ((details.localPosition.dy - cursorY) / 5000)) %
                      degreeToRadian(degree: 360);
              anglex =
                  (anglex + ((details.localPosition.dx - cursorX) / 5000)) %
                      degreeToRadian(degree: 360);
              setState(
                () {},
              );
            },
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
          isMobile == false
              ? BigCube(
                  game: game,
                  anglex: anglex,
                  angley: -angley,
                  triggerAnimation: triggerSwapAnimation,
                )
              : BigCube(
                triggerAnimation: triggerSwapAnimation,
                game: game,
                anglex: anglex,
                angley: -angley,
              ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            bottom: isMobile
                ? game.isStarted
                    ? 40
                    : height * 0.3
                : height * 0.35,
            left : isMobile ? (width*0.175) : 100,
            child: Center(
              child: SizedBox(
                width : isMobile? 250:null,
                child: GlassMorphism(
                    child: Column(
                      mainAxisSize : MainAxisSize.min,
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
                                isMobile: isMobile,
                                  refershHomeScreen: () {
                                    setState(() {});
                                  },
                                  game: game,
                                ),
                        ),
                        const SizedBox(height: 30),
                        game.isStarted
                            ? GameResetButton(
                              isMobile: isMobile,
                                refresh: () {
                                  if (width < height) {
                                    isMobile = true;
                                  } else {
                                    isMobile = false;
                                  }
                                  cubeSize =
                                      min(height, width) / (isMobile ? 6 : 5);
                                  centerX =
                                      isMobile ? (width / 2) : (width / 2) * 1.25;
                                  centerY = isMobile ? height / 2.5 : height / 2;
                                  game = Game(
                                    cubeSize: cubeSize,
                                    centerX: centerX,
                                    centerY: centerY,
                                  );
                                  preStartAnimation.repeat();
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
                                  preStartAnimation.reset();
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Start Game',
                                      style: TextStyle(
                                        fontSize: isMobile?20:25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    start: 0,
                    end: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
