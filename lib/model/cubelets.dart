import 'package:rubikscube/model/faces.dart';
import '../math/utils.dart';

class Cubelets {
  Cubelets(
      {required this.id,
      required this.cordinates,
      required this.cubeSize,
      required this.i,
      required this.j,
      required this.k}) {
    initialCordinates =
        List.generate(cordinates.length, (index) => cordinates[index]);
    initializeNewFaces();
  }
  late int i, j, k;
  double cubeSize;
  List<Faces> faces = [];
  List<double> cordinates;
  List<double> cordinates2d = [];
  List<double> initialCordinates = [];
  int id;
  void rotate(List<List<double>> rotationmatrix, List<double> around) {
    cordinates = rotation(rotationmatrix, around, initialCordinates);
    for (int i = 0; i < 6; i++) {
      faces[i].rotateFace(rotationmatrix, around);
    }
  }

  void initializeNewFaces() {
    faces.add(
      Faces(
        imagepath: '',
        cordinates: [cordinates[0] - cubeSize, cordinates[1], cordinates[2]],
        translate: [-cubeSize, 0, 0],
        rotationA: [0, degreeToRadian(degree: 270), 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: '',
        cordinates: [cordinates[0] + cubeSize, cordinates[1], cordinates[2]],
        translate: [cubeSize, 0, 0],
        rotationA: [0, degreeToRadian(degree: 90), 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: '',
        cordinates: [cordinates[0], cordinates[1] + cubeSize, cordinates[2]],
        translate: [0, cubeSize, 0],
        rotationA: [degreeToRadian(degree: 270), 0, 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: '',
        cordinates: [cordinates[0], cordinates[1] - cubeSize, cordinates[2]],
        translate: [0, -cubeSize, 0],
        rotationA: [degreeToRadian(degree: 90), 0, 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: '',
        cordinates: [cordinates[0], cordinates[1], cordinates[2] + cubeSize],
        translate: [0, 0, cubeSize],
        rotationA: [0, 0, 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: '',
        cordinates: [cordinates[0], cordinates[1], cordinates[2] - cubeSize],
        translate: [0, 0, -cubeSize],
        rotationA: [0, degreeToRadian(degree: 180), 0],
      ),
    );
  }

  void initializeNewFacesFromPastFaces(List<Faces> faces) {
    faces.add(
      Faces(
        imagepath: faces[0].imagepath,
        cordinates: [cordinates[0] - cubeSize, cordinates[1], cordinates[2]],
        translate: [-cubeSize, 0, 0],
        rotationA: [0, degreeToRadian(degree: 270), 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: faces[1].imagepath,
        cordinates: [cordinates[0] + cubeSize, cordinates[1], cordinates[2]],
        translate: [cubeSize, 0, 0],
        rotationA: [0, degreeToRadian(degree: 90), 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: faces[2].imagepath,
        cordinates: [cordinates[0], cordinates[1] + cubeSize, cordinates[2]],
        translate: [0, cubeSize, 0],
        rotationA: [degreeToRadian(degree: 270), 0, 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: faces[3].imagepath,
        cordinates: [cordinates[0], cordinates[1] - cubeSize, cordinates[2]],
        translate: [0, -cubeSize, 0],
        rotationA: [degreeToRadian(degree: 90), 0, 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: faces[4].imagepath,
        cordinates: [cordinates[0], cordinates[1], cordinates[2] + cubeSize],
        translate: [0, 0, cubeSize],
        rotationA: [0, 0, 0],
      ),
    );
    faces.add(
      Faces(
        imagepath: faces[5].imagepath,
        cordinates: [cordinates[0], cordinates[1], cordinates[2] - cubeSize],
        translate: [0, 0, -cubeSize],
        rotationA: [0, degreeToRadian(degree: 180), 0],
      ),
    );
  }

  List<Faces> getNewFaces() {
    List<Faces> newFaces = List.generate(6, (index) => faces[index]);
    newFaces.sort(
      (a, b) {
        return a.cordinates[2].compareTo(b.cordinates[2]);
      },
    );
    return newFaces.sublist(3);
  }
}
