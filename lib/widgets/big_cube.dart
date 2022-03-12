import 'package:flutter/material.dart';
import 'package:rubikscube/model/game.dart';
import 'package:rubikscube/widgets/small_cube.dart';
import '../model/cubelets.dart';

class BigCube extends StatelessWidget {
  BigCube(
      {Key? key,
      required this.game,
      required this.anglex,
      required this.angley,
      this.r})
      : super(key: key);
  Game game;
  double anglex, angley;
  final Function()? r;
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
                  child: SmallCube(
                    refreshHomeScreen: r!,
                    game: game,
                    cubelets: cubes[index],
                    anglex: anglex,
                    angley: angley,
                  ),
                ),
        );
        return Stack(
          children: children,
        );
      },
    );
  }
}
