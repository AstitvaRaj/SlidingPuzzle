import 'package:flutter/material.dart';
import 'package:rubikscube/model/game.dart';
import 'package:rubikscube/widgets/small_cube.dart';
import '../model/cubelets.dart';

class BigCube extends StatefulWidget {
  BigCube({
    Key? key,
    required this.game,
    required this.anglex,
    required this.angley,
  }) : super(key: key);
  Game game;
  double anglex, angley;

  @override
  State<BigCube> createState() => _BigCubeState();
}

class _BigCubeState extends State<BigCube> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        widget.game.rotateGame(widget.anglex, widget.angley);
        List<Cubelets> cubes = widget.game.getNewCubeletList();
        List<Widget> children = List.generate(
          cubes.length,
          (index) => cubes[index].id == 27
              ? Container()
              : Positioned(
                  top: cubes[index].cordinates[1] - widget.game.cubeSize / 2,
                  left: cubes[index].cordinates[0] - widget.game.cubeSize / 2,
                  child: GestureDetector(
                    onTap: () {
                      widget.game.clickedOnTile(cubes[index].id);
                      setState(() {});
                    },
                    child: SmallCube(
                      game: widget.game,
                      cubelets: cubes[index],
                      anglex: widget.anglex,
                      angley: widget.angley,
                    ),
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
