import 'package:flutter/material.dart';
import 'package:rubikscube/widgets/big_cube.dart';
import 'package:rubikscube/widgets/cubelets.dart';
import 'package:rubikscube/widgets/game.dart';
import 'package:rubikscube/widgets/small_cube.dart';
import '../math/formula.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({Key? key}) : super(key: key);

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> with TickerProviderStateMixin {
  late AnimationController animationController;
  late bool isMobile;
  late SmallCube smallCube, secondCube;
  late Game game;
  double anglex = 0, angley = 0, anglez = 0;
  double cursorX = 0, cursorY = 0;
  @override
  void initState() {
    super.initState();
    isMobile = false;
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: degreeToRadian(degree: 360),
      duration: const Duration(seconds: 4),
    )..addListener(() {
        if (animationController.isAnimating) {
          setState(() {
            // angley = animationController.value;
            // anglex = animationController.value;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    game = Game(cubeSize: 150, height: height, width: width);
    Cubelets cube = Cubelets(
      id: 1,
      cordinates: [(width / 2) - 300, height / 2, 0],
      height: height,
      width: width,
    );

    if (width < 600) {
      isMobile = true;
      setState(() {});
    } else {
      isMobile = false;
      setState(() {});
    }

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
                anglez = (anglex + angley) % degreeToRadian(degree: 720);
                // game.rotateGame(anglex, angley);
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
          Positioned(
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
                        color: Colors.white, fontSize: 25, fontFamily: 'Titan'),
                  ),
                ),
              ),
            ),
          ),
          // BigCube(
          //       game: game,
          //       anglex: anglex,
          //       angley: angley,

          // )
          LayoutBuilder(builder: (_, __) {
            var rotationmatrix = rotationMatrix(0, anglex, 0);
            cube.rotate(rotationmatrix, [width / 2, height / 2, 0]);
            return Stack(
              children: [
                Positioned(
                  top: cube.cordinates2d[1],
                  left: cube.cordinates2d[0],
                  child: SmallCube(
                    cubelets: cube,
                    anglex: anglex,
                    angley: 0,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
