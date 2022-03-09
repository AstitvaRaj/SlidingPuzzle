import 'game.dart';
import '../math/formula.dart';

class Cubelets {
  Cubelets(
      {required this.id,
      required this.cordinates,
      required this.height,
      required this.width}) {
    cordinates2d = update2DCordinates(cordinates,[768, 376.79998779296875, 1220]
);
    // print(cordinates2d);
    faces.add(
      Faces(
          imagepath: 'tiles/red/5.jpg',
          cordinates: [cordinates[0] - 75, cordinates[1], cordinates[2]],
          translate: [-75, 0, 0],
          rotationA: [0, degreeToRadian(degree: 270), 0],
          height: height,
          width: width),
    );
    faces.add(
      Faces(
          imagepath: 'tiles/green/5.jpg',
          cordinates: [cordinates[0] + 75, cordinates[1], cordinates[2]],
          translate: [75, 0, 0],
          rotationA: [0, degreeToRadian(degree: 90), 0],
          height: height,
          width: width),
    );
    faces.add(
      Faces(
          imagepath: 'tiles/yellow/5.jpg',
          cordinates: [cordinates[0], cordinates[1] + 75, cordinates[2]],
          translate: [0, 75, 0],
          rotationA: [degreeToRadian(degree: 270), 0, 0],
          height: height,
          width: width),
    );
    faces.add(
      Faces(
          imagepath: 'tiles/white/5.jpg',
          cordinates: [cordinates[0], cordinates[1] - 75, cordinates[2]],
          translate: [0, -75, 0],
          rotationA: [degreeToRadian(degree: 90), 0, 0],
          height: height,
          width: width),
    );
    faces.add(
      Faces(
          imagepath: 'tiles/blue/5.jpg',
          cordinates: [cordinates[0], cordinates[1], cordinates[2] + 75],
          translate: [0, 0, 75],
          rotationA: [0, 0, 0],
          height: height,
          width: width),
    );
    faces.add(
      Faces(
          imagepath: 'tiles/purple/5.jpg',
          cordinates: [cordinates[0], cordinates[1], cordinates[2] - 75],
          translate: [0, 0, -75],
          rotationA: [0, degreeToRadian(degree: 180), 0],
          height: height,
          width: width),
    );
  }
  double height, width;
  List<Faces> faces = [];
  List<double> cordinates;
  List<double> cordinates2d = [];
  int id;
  void rotate(List<List<double>> rotationmatrix, List<double> around) {
    cordinates = rotation(rotationmatrix, around, cordinates);
    cordinates2d = update2DCordinates(cordinates, [768, 376.79998779296875, 1220]);
    for (int i = 0; i < 6; i++) {
      faces[i].rotateFace(rotationmatrix, cordinates);
    }
  }

  List<Faces> getNewFaces() {
    List<Faces> newFaces = List.generate(6, (index) => faces[index]);
    newFaces.sort((a, b) => a.cordinates[2].compareTo(b.cordinates[2]));
    return newFaces;
  }
}
