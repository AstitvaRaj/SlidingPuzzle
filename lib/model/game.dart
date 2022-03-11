import 'dart:math';
import 'package:flutter/foundation.dart';
import 'cubelets.dart';
import 'package:rubikscube/math/utils.dart';

class Game extends ChangeNotifier {
  late List<List<List<int>>> state;
  late List<List<List<int>>> currentState;
  late double cubeSize;
  late int moves;
  late int seconds;
  late bool isFinished;
  late bool isStarted;
  late DateTime dateTime;
  List<Cubelets> cubelets = [];
  double centerX, centerY;
  Game({required this.cubeSize, required this.centerX, required this.centerY}) {
    isStarted = false;
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
    currentState = [
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
    double y = centerY - cubeSize;
    for (int i = 0; i < 3; i++) {
      double z = -cubeSize;
      for (int j = 0; j < 3; j++) {
        double x = centerX - cubeSize;
        for (int k = 0; k < 3; k++) {
          cubelets.add(
            Cubelets(
              id: (k + 1) + (j * 3) + (i * 9),
              cordinates: [x, y, z],
              cubeSize: cubeSize / 2,
              i: k,
              j: i,
              k: j,
            ),
          );
          x += cubeSize;
        }
        z += cubeSize;
      }
      y += cubeSize;
    }
    topFace = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    bottomFace = [25, 26, 27, 22, 23, 24, 19, 20, 21];
    leftFace = [1, 4, 7, 10, 13, 16, 19, 22, 25];
    rightFace = [9, 6, 3, 18, 15, 12, 27, 24, 21];
    frontFace = [7, 8, 9, 16, 17, 18, 25, 26, 27];
    backFace = [3, 2, 1, 12, 11, 10, 21, 20, 19];
    cubelets[25].faces[1].imagepath = 'assets/tiles/yellow/7.jpg';
    cubelets[23].faces[4].imagepath = 'assets/tiles/blue/9.jpg';
    cubelets[17].faces[2].imagepath = 'assets/tiles/red/3.jpg';
    int k = 1;
    for (var i in leftFace) {
      cubelets[i.toInt() - 1].faces[0].imagepath = 'assets/tiles/purple/$k.jpg';
      k++;
    }
    k = 1;
    for (var i in rightFace) {
      cubelets[i.toInt() - 1].faces[1].imagepath = 'assets/tiles/yellow/$k.jpg';
      k++;
    }
    k = 1;
    for (var i in bottomFace) {
      cubelets[i.toInt() - 1].faces[2].imagepath = 'assets/tiles/red/$k.jpg';
      k++;
    }
    k = 1;
    for (var i in topFace) {
      cubelets[i.toInt() - 1].faces[3].imagepath = 'assets/tiles/green/$k.jpg';
      k++;
    }

    k = 1;
    for (var i in frontFace) {
      cubelets[i.toInt() - 1].faces[4].imagepath = 'assets/tiles/blue/$k.jpg';
      k++;
    }
    k = 1;
    for (var i in backFace) {
      cubelets[i.toInt() - 1].faces[5].imagepath = 'assets/tiles/white/$k.jpg';
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
    isStarted = true;
    isFinished = false;
    dateTime = DateTime.now();
    shuffleCubes();
  }

  void shuffleCubes() {}
  int getSameCordinates(int id) {
    int sameCordinates = 0;
    sameCordinates += cubelets[id - 1].i == cubelets[26].i ? 1 : 0;
    sameCordinates += cubelets[id - 1].j == cubelets[26].j ? 1 : 0;
    sameCordinates += cubelets[id - 1].k == cubelets[26].k ? 1 : 0;
    return sameCordinates;
  }

  void clickedOnTile(int id) {
    if (isStarted) {
      if (getSameCordinates(id) == 2) {
        moves++;
        int temp = 0;
        temp = max(cubelets[id - 1].i == cubelets[26].i ? 0 : 1, temp);
        temp = max(cubelets[id - 1].j == cubelets[26].j ? 0 : 2, temp);
        temp = max(cubelets[id - 1].k == cubelets[26].k ? 0 : 3, temp);
        switch (temp) {
          case 1:
            if (cubelets[id - 1].i > cubelets[26].i) {
              int k = cubelets[26].i;
              for (; k < cubelets[id - 1].i; k++) {
                int temps = currentState[cubelets[26].j][cubelets[26].k][k];
                currentState[cubelets[26].j][cubelets[26].k][k] =
                    currentState[cubelets[26].j][cubelets[26].k][k + 1];
                currentState[cubelets[26].j][cubelets[26].k][k + 1] = temps;

                Cubelets a = cubelets[
                    currentState[cubelets[26].j][cubelets[26].k][k + 1] - 1];
                Cubelets b = cubelets[
                    currentState[cubelets[26].j][cubelets[26].k][k] - 1];
                swapCubelets(a, b);
              }
            } else {
              int k = cubelets[26].i;
              for (; k > cubelets[id - 1].i; k--) {
                int tme = currentState[cubelets[26].j][cubelets[26].k][k];
                currentState[cubelets[26].j][cubelets[26].k][k] =
                    currentState[cubelets[26].j][cubelets[26].k][k - 1];
                currentState[cubelets[26].j][cubelets[26].k][k - 1] = tme;
                Cubelets a = cubelets[
                    currentState[cubelets[26].j][cubelets[26].k][k - 1] - 1];
                Cubelets b = cubelets[
                    currentState[cubelets[26].j][cubelets[26].k][k] - 1];
                swapCubelets(a, b);
              }
            }

            break;
          case 2:
            if (cubelets[id - 1].j > cubelets[26].j) {
              int k = cubelets[26].j;
              for (; k < cubelets[id - 1].j; k++) {
                int temps = currentState[k][cubelets[26].k][cubelets[26].i];
                currentState[k][cubelets[26].k][cubelets[26].i] =
                    currentState[k + 1][cubelets[26].k][cubelets[26].i];
                currentState[k + 1][cubelets[26].k][cubelets[26].i] = temps;

                Cubelets a = cubelets[
                    currentState[k + 1][cubelets[26].k][cubelets[26].i] - 1];
                Cubelets b = cubelets[
                    currentState[k][cubelets[26].k][cubelets[26].i] - 1];
                swapCubelets(a, b);
              }
            } else {
              int k = cubelets[26].j;
              for (; k > cubelets[id - 1].j; k--) {
                int temps = currentState[k][cubelets[26].k][cubelets[26].i];
                currentState[k][cubelets[26].k][cubelets[26].i] =
                    currentState[k - 1][cubelets[26].k][cubelets[26].i];
                currentState[k - 1][cubelets[26].k][cubelets[26].i] = temps;

                Cubelets a = cubelets[
                    currentState[k - 1][cubelets[26].k][cubelets[26].i] - 1];
                Cubelets b = cubelets[
                    currentState[k][cubelets[26].k][cubelets[26].i] - 1];
                swapCubelets(a, b);
              }
            }
            break;
          case 3:
            if (cubelets[id - 1].k > cubelets[26].k) {
              int k = cubelets[26].k;
              for (; k < cubelets[id - 1].k; k++) {
                int temps = currentState[cubelets[26].j][k][cubelets[26].i];
                currentState[cubelets[26].j][k][cubelets[26].i] =
                    currentState[cubelets[26].j][k + 1][cubelets[26].i];
                currentState[cubelets[26].j][k + 1][cubelets[26].i] = temps;

                Cubelets a = cubelets[
                    currentState[cubelets[26].j][k + 1][cubelets[26].i] - 1];
                Cubelets b = cubelets[
                    currentState[cubelets[26].j][k][cubelets[26].i] - 1];
                swapCubelets(a, b);
              }
            } else {
              int k = cubelets[26].k;
              for (; k > cubelets[id - 1].k; k--) {
                int temps = currentState[cubelets[26].j][k][cubelets[26].i];
                currentState[cubelets[26].j][k][cubelets[26].i] =
                    currentState[cubelets[26].j][k - 1][cubelets[26].i];
                currentState[cubelets[26].j][k - 1][cubelets[26].i] = temps;

                Cubelets a = cubelets[
                    currentState[cubelets[26].j][k - 1][cubelets[26].i] - 1];
                Cubelets b = cubelets[
                    currentState[cubelets[26].j][k][cubelets[26].i] - 1];
                swapCubelets(a, b);
              }
            }
            break;
          default:
            break;
        }
      }
    }
  }

  void swapCubelets(Cubelets a, Cubelets b) {
    List<double> tempCordinates = b.initialCordinates;
    b.initialCordinates = a.initialCordinates;
    a.initialCordinates = tempCordinates;
    int temp = b.i;
    b.i = a.i;
    a.i = temp;
    temp = b.j;
    b.j = a.j;
    a.j = temp;
    temp = b.k;
    b.k = a.k;
    a.k = temp;
  }

  bool isPuzzleSolved() {
    return listEquals(currentState[0][0], state[0][0]) &&
        listEquals(currentState[0][1], state[0][1]) &&
        listEquals(currentState[0][2], state[0][2]) &&
        listEquals(currentState[1][0], state[1][0]) &&
        listEquals(currentState[1][1], state[1][1]) &&
        listEquals(currentState[1][2], state[1][2]) &&
        listEquals(currentState[2][0], state[2][0]) &&
        listEquals(currentState[2][1], state[2][1]) &&
        listEquals(currentState[2][2], state[2][2]);
  }

  void rotateGame(double angleX, double angleY) {
    var rotationmatrix = rotationMatrix(0, angleX, angleY);
    int i = 0;
    for (i = 0; i < 27; i++) {
      cubelets[i].rotate(rotationmatrix, [centerX, centerY, 0]);
    }
  }

  List<Cubelets> getNewCubeletList() {
    List<Cubelets> newCubelets = List.generate(27, (index) => cubelets[index]);
    newCubelets.sort((a, b) => a.cordinates[2].compareTo(b.cordinates[2]));
    return newCubelets;
  }
}
