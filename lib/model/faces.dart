import 'package:rubikscube/math/utils.dart';

class Faces {
  Faces({
    this.imagepath,
    required this.cordinates,
    required this.translate,
    required this.rotationA,
  }) {
    initialCordinates =
        List.generate(cordinates.length, (index) => cordinates[index]);
  }
  String? imagepath = '';
  List<double> angle = [];
  List<double> translate = [];
  List<double> cordinates = [];
  List<double> cordinates2d = [];
  List<double> rotationA = [];
  List<double> initialCordinates = [];
  void rotateFace(List<List<double>> rotationmatrix, List<double> around) {
    cordinates = rotation(rotationmatrix, around, initialCordinates);
  }
}