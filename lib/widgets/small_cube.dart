import 'package:flutter/material.dart';
import 'package:rubikscube/math/formula.dart';
import 'package:rubikscube/widgets/game.dart';
import 'cubelets.dart';

class SmallCube extends StatefulWidget {
  SmallCube(
      {Key? key,
      required this.cubelets,
      required this.anglex,
      required this.angley})
      : super(key: key);
  Cubelets cubelets;
  double anglex, angley;
  @override
  State<SmallCube> createState() => _SmallCubeState();
}

class _SmallCubeState extends State<SmallCube> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        List<List<double>> r = rotationMatrix(0, widget.anglex, widget.angley);
        widget.cubelets.rotate(r, widget.cubelets.cordinates);
        List<Faces> faces = widget.cubelets.getNewFaces();
        List<Widget> children = List.generate(
          6,
          (index) => Positioned(
            // top: faces[index].cordinates2d[1],
            // left: faces[index].cordinates2d[0],
            child: Transform(
              origin: const Offset(75, 75),
              transform: Matrix4.identity()
                ..translate(faces[index].translate[0],
                    faces[index].translate[1], faces[index].translate[2])
                ..rotateX(faces[index].rotationA[0])
                ..rotateY(faces[index].rotationA[1])
                ..rotateZ(faces[index].rotationA[2]),
              child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 150,
                  width: 150,
                  color: Colors.white,
                  child: faces[index].imagepath == ''
                      ? null
                      : Image.asset(faces[index].imagepath!)),
            ),
          ),
        );
        return Transform(
          transform: Matrix4.identity()
            ..rotateY(widget.anglex)..rotateX(widget.angley),
            // ..rotateX(widget.angley),
          origin: Offset(75, 75),
          child: Stack(
            children: children,
          ),
        );
      },
    );
  }
}
