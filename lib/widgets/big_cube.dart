import 'package:flutter/material.dart';
import 'package:rubikscube/widgets/game.dart';
import 'package:rubikscube/widgets/small_cube.dart';

import 'cubelets.dart';

class BigCube extends StatefulWidget {
  BigCube(
      {Key? key,
      required this.game,
      required this.anglex,
      required this.angley})
      : super(key: key);
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
          (index) => Positioned(
            top:cubes[index].cordinates[1],
            left: cubes[index].cordinates[0],
            child: SmallCube(
              cubelets: cubes[index],
              anglex: widget.anglex,
              angley: widget.angley,
            ),
          ),
        );
        // print(cubes[0].cordinates+cubes[1].cordinates);
        return Transform(
          transform: Matrix4.identity()
            ..rotateY(widget.anglex)
            ..rotateX(widget.angley),
            // ..setEntry(3, 2, -0.001),
          origin: Offset(widget.game.width/2,widget.game.height/2),
          child: Stack(
            children: children,
          ),
        );
      },
    );
  }
}