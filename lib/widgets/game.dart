import 'cubelets.dart';
import 'package:rubikscube/math/formula.dart';

class Faces {
  Faces(
      {this.imagepath,
      required this.cordinates,
      required this.translate,
      required this.rotationA,
      required this.height,
      required this.width});
  double height, width;
  String? imagepath = '';
  List<double> angle = [];
  List<double> translate = [];
  List<double> cordinates = [];
  List<double> cordinates2d = [];
  List<double> rotationA = [];
  void rotateFace(List<List<double>> rotationmatrix, List<double> around) {
    cordinates = rotation(rotationmatrix, around, cordinates);
    // cordinates2d = update2DCordinates(cordinates,[768, 376.79998779296875, 1220]);
  }
}

class Game {
  late List<List<List<int>>> state;
  late double cubeSize;
  late int moves;
  late int seconds;
  late bool isFinished;
  late DateTime dateTime;
  List<Cubelets> cubelets = [];
  double height, width;
  Game({required this.cubeSize, required this.height, required this.width}) {
    isFinished = true;
    moves = 0;
    state = [
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
      ],
      [
        [10, 11, 12],
        [13, 14, 15],
        [16, 17, 18],
      ],
      [
        [19, 20, 21],
        [22, 23, 24],
        [25, 26, 27],
      ]
    ];
    double y = (height/2)-cubeSize;
    for (int i = 0; i < 3; i++) {
      double z = -150;
      for (int j = 0; j < 3; j++) {
        double x = (width/2)-cubeSize;
        for (int k = 0; k < 3; k++) {
          // print('${(k + 1) + (j * 3) + (i * 9)} : ${(width / 2) + x}, ${(height / 2) + y}, ${z}');
          cubelets.add(
            Cubelets(
              id: (k + 1) + (j * 3) + (i * 9),
              cordinates: [x,  y, z],
              height: height,
              width: width,
            ),
          );
          x += cubeSize;
        }
        z += cubeSize;
      }
      y += cubeSize;
    }
    topFace = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    bottomFace = [25, 26, 27, 22, 23, 24, 19, 20, 21,];
    leftFace = [1, 4, 7, 10, 13, 16, 19, 22, 25];
    rightFace = [9, 6, 3, 18, 15, 12, 27, 24, 21];
    frontFace = [7, 8, 9, 16, 17, 18, 25, 26, 27];
    backFace = [3, 2, 1, 12, 11, 10, 21, 20, 19];
    int k = 1;
    for (var i in leftFace) {
      cubelets[i.toInt() - 1].faces[0].imagepath = 'tiles/purple/${k}.jpg';
      k++;
    }
    k = 1;
    for (var i in rightFace) {
      cubelets[i.toInt() - 1].faces[1].imagepath = 'tiles/yellow/${k}.jpg';
      k++;
    }
    k = 1;
    for (var i in bottomFace) {
      cubelets[i.toInt() - 1].faces[2].imagepath = 'tiles/red/${k}.jpg';
      k++;
    }
    k = 1;
    for (var i in topFace) {
      cubelets[i.toInt() - 1].faces[3].imagepath = 'tiles/green/${k}.jpg';
      k++;
    }
    
    k = 1;
    for (var i in frontFace) {
      cubelets[i.toInt() - 1].faces[4].imagepath = 'tiles/blue/${k}.jpg';
      k++;
    }
    k = 1;
    for (var i in backFace) {
      cubelets[i.toInt() - 1].faces[5].imagepath = 'tiles/white/${k}.jpg';
      k++;
    }
  }
  late List<double> topFace,
      bottomFace,
      leftFace,
      rightFace,
      frontFace,
      backFace;
  void startGame() {
    isFinished = false;
  }

  void shuffleCubes() {}
  void clickedOnTile(int id) {
    moves++;
  }

  void rotateGame(double angleX, double angleY) {
    var rotationmatrix = rotationMatrix(0, angleX, angleY);
    int i = 0;
    for (i = 0; i < 27; i++) {
      cubelets[i].rotate(rotationmatrix, [width/2, height/2,0]);
      // print(cubelets[i].cordinates);
    }
  }

  List<Cubelets> getNewCubeletList() {
    List<Cubelets> newCubelets = List.generate(27, (index) => cubelets[index]);
    newCubelets.sort((a, b) => a.cordinates[2].compareTo(b.cordinates[2]));
    return newCubelets.sublist(2);
  }
}
