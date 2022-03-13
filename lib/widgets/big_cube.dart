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
                  child: TextButton(
                    onPressed: () {
                      if (cubes[index].id != 14) {
                        List<int> temp =
                            game.clickedOnTile(cubes[index].id);
                        // print(temp);

                        for (var i in temp) {
                          game.swapCubelets(game.cubelets[i - 1],
                              game.cubelets[26]);
                          game.swapCurrentState(
                              game.cubelets[i - 1].i,
                              game.cubelets[i - 1].j,
                              game.cubelets[i - 1].k,
                              game.cubelets[26].i,
                              game.cubelets[26].j,
                              game.cubelets[26].k);

                          r!();
                        }
                        game.moves += temp.isEmpty ? 0 : 1;
                        r!();
                      }
                    },
                    child: SmallCube(
                      refreshHomeScreen: r!,
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
