import 'package:flutter/material.dart';
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
        List<Faces> faces = widget.cubelets.getNewFaces();
        List<Widget> children = List.generate(
          3,
          (index) => Transform(
            origin:  Offset(widget.cubelets.cubeSize, widget.cubelets.cubeSize),
            transform: Matrix4.identity()
              ..translate(faces[index].translate[0], faces[index].translate[1],
                  faces[index].translate[2])
              ..rotateX(faces[index].rotationA[0])
              ..rotateY(faces[index].rotationA[1])
              ..rotateZ(faces[index].rotationA[2]),
            child: Container(
              padding: const EdgeInsets.all(5),
              height: widget.cubelets.cubeSize*2,
              width: widget.cubelets.cubeSize*2,
              color: Colors.white,
              child: faces[index].imagepath == ''
                  ? null
                  : Image.asset(faces[index].imagepath!),
            ),
          ),
        );
        return Transform(
          transform: Matrix4.identity()
            ..rotateY(widget.anglex)
            ..rotateX(widget.angley),
          origin: Offset(widget.cubelets.cubeSize, widget.cubelets.cubeSize),
          child: Stack(
            children: children,
          ),
        );
      },
    );
  }
}
