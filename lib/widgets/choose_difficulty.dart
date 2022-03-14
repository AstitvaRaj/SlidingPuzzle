import 'package:flutter/material.dart';
import 'package:rubikscube/model/game.dart';

class ChooseDifficultyLevel extends StatelessWidget {
  const ChooseDifficultyLevel(
      {Key? key,
      required this.game,
      required this.refershHomeScreen,
      required this.isMobile})
      : super(key: key);
  final Game game;
  final Function() refershHomeScreen;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Choose Difficulty',
          style: TextStyle(
            fontSize: isMobile ? 18 : 20,
          ),
        ),
        const SizedBox(height: 20),
        isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      game.setGameDifficulty(10);
                      refershHomeScreen();
                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: game.gameDifficulty == 10
                            ? Colors.white
                            : const Color.fromARGB(255, 7, 124, 219),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: Text(
                          'Easy',
                          style: TextStyle(
                            fontSize: 15,
                            color: game.gameDifficulty == 10
                                ? const Color.fromARGB(255, 7, 124, 219)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      game.setGameDifficulty(20);
                      refershHomeScreen();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: game.gameDifficulty == 20
                            ? Colors.white
                            : const Color.fromARGB(255, 7, 124, 219),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(
                        child: Text(
                          'Medium',
                          style: TextStyle(
                            fontSize: 15,
                            color: game.gameDifficulty == 20
                                ? const Color.fromARGB(255, 7, 124, 219)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      game.setGameDifficulty(100);
                      refershHomeScreen();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: game.gameDifficulty == 100
                            ? Colors.white
                            : const Color.fromARGB(255, 7, 124, 219),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(
                        child: Text(
                          'Hard',
                          style: TextStyle(
                            fontSize: 15,
                            color: game.gameDifficulty == 100
                                ? const Color.fromARGB(255, 7, 124, 219)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      game.setGameDifficulty(10);
                      refershHomeScreen();
                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: game.gameDifficulty == 10
                            ? Colors.white
                            : const Color.fromARGB(255, 7, 124, 219),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: Text(
                          'Easy',
                          style: TextStyle(
                            fontSize: 20,
                            color: game.gameDifficulty == 10
                                ? const Color.fromARGB(255, 7, 124, 219)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      game.setGameDifficulty(20);
                      refershHomeScreen();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: game.gameDifficulty == 20
                            ? Colors.white
                            : const Color.fromARGB(255, 7, 124, 219),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(
                        child: Text(
                          'Medium',
                          style: TextStyle(
                            fontSize: 20,
                            color: game.gameDifficulty == 20
                                ? const Color.fromARGB(255, 7, 124, 219)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      game.setGameDifficulty(100);
                      refershHomeScreen();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: game.gameDifficulty == 100
                            ? Colors.white
                            : const Color.fromARGB(255, 7, 124, 219),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(
                        child: Text(
                          'Hard',
                          style: TextStyle(
                            fontSize: 20,
                            color: game.gameDifficulty == 100
                                ? const Color.fromARGB(255, 7, 124, 219)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
