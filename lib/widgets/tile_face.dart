import 'package:flutter/material.dart';

class TileFace extends StatelessWidget {
  const TileFace(
      {Key? key,
      required this.face,
      required this.origin,
      required this.angles,
      required this.cordinates})
      : super(key: key);
  final List<double> cordinates;
  final List<double> angles;
  final Offset origin;
  final String face;
  @override
  Widget build(BuildContext context) {
    return Transform(
      origin: origin,
      transform: Matrix4.identity()
        ..translate(cordinates[0], cordinates[1], cordinates[2])
        ..rotateX(angles[0])
        ..rotateY(angles[1])
        ..rotateZ(angles[2]),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 150,
        width: 150,
        decoration: const BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: face == '' ? null : Image.asset(face),
      ),
    );
  }
}
