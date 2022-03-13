import 'package:flutter/material.dart';
import 'package:rubikscube/model/game.dart';
import '../model/cubelets.dart';
import '../model/faces.dart';

class SmallCube extends StatelessWidget {
  const SmallCube(
      {Key? key,
      required this.cubelets,
      required this.anglex,
      required this.angley,
      required this.game,
      required this.refreshHomeScreen})
      : super(key: key);
  final Game game;
  final Cubelets cubelets;
  final double anglex, angley;
  final Function() refreshHomeScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        List<Faces> faces = cubelets.getNewFaces();
        List<Widget> children = List.generate(
          3,
          (index) => Transform(
            origin: Offset(cubelets.cubeSize, cubelets.cubeSize),
            transform: Matrix4.identity()
              ..translate(faces[index].translate[0], faces[index].translate[1],
                  faces[index].translate[2])
              ..rotateX(faces[index].rotationA[0])
              ..rotateY(faces[index].rotationA[1])
              ..rotateZ(faces[index].rotationA[2]),
            child: faces[index].imagepath == ''
                ? Container(
                  padding: const EdgeInsets.all(5),
                  height: cubelets.cubeSize * 2,
                  width: cubelets.cubeSize * 2,
                  color: Colors.white,
                )
                : Container(
                    padding: const EdgeInsets.all(5),
                    height: cubelets.cubeSize * 2,
                    width: cubelets.cubeSize * 2,
                    color: Colors.white,
                    child: Image.asset(faces[index].imagepath!),
                  ),
          ),
        );
        return Transform(
          transform: Matrix4.identity()
            ..rotateY(anglex)
            ..rotateX(angley),
          origin: Offset(cubelets.cubeSize, cubelets.cubeSize),
          child: Stack(
            clipBehavior: Clip.none,
            children: children,
          ),
        );
      },
    );
  }
}
