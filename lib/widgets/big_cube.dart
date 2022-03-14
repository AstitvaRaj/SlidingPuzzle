import 'package:flutter/material.dart';
import 'package:rubikscube/model/game.dart';
import 'package:rubikscube/widgets/small_cube.dart';
import '../model/cubelets.dart';

class BigCube extends StatelessWidget {
  const BigCube({
    Key? key,
    required this.game,
    required this.anglex,
    required this.angley,
    required this.triggerAnimation,
  }) : super(key: key);
  final Game game;
  final double anglex, angley;
  final Function(List<int>) triggerAnimation;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        game.rotateGame(anglex, angley);
        List<Cubelets> cubes = game.getNewCubeletList();
        List<Widget> children = List.generate(
          cubes.length,
          (index) => cubes[index].id == 27
              ? Container()
              : Positioned(
                  top: cubes[index].cordinates[1] - game.cubeSize / 2,
                  left: cubes[index].cordinates[0] - game.cubeSize / 2,
                  child: TextButton(
                    onPressed: () {
                      if (cubes[index].id != 14) {
                        List<int> temp = game.clickedOnTile(cubes[index].id);
                        triggerAnimation(temp);
                      }
                    },
                    child: SmallCube(
                      game: game,
                      cubelets: cubes[index],
                      anglex: anglex,
                      angley: angley,
                    ),
                  ),
                ),
        );
        return Stack(
          clipBehavior: Clip.none,
          children: children,
        );
      },
    );
  }
}
