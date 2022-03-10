import 'dart:math';

double degreeToRadian({required double degree}) => degree * (pi / 180);

List<List<double>> rotationMatrix(double zaxis, double yaxis, double xaxis) {
  List<double> sine = [sin(zaxis), sin(yaxis), sin(xaxis)];
  List<double> cosine = [cos(zaxis), cos(yaxis), cos(xaxis)];
  List<List<double>> r = [
    [
      (cosine[1] * cosine[0]),
      (cosine[0] * sine[1] * sine[2]) - (sine[0] * cosine[2]),
      (cosine[0] * sine[1] * cosine[2]) + (sine[0] * sine[2])
    ],
    [
      (cosine[1] * sine[0]),
      (sine[0] * sine[1] * sine[2]) + (cosine[0] * cosine[2]),
      (sine[0] * sine[1] * cosine[2]) - (cosine[0] * sine[2])
    ],
    [(sine[1]) * (-1), (cosine[1] * sine[2]), (cosine[1] * cosine[2])]
  ];
  return r;
}

List<double> rotation(List<List<double>> rotationmatrix, List<double> around,
    List<double> points) {
  List<double> newPositions = [0, 0, 0];

  List<double> pointsAroundOrigin = [
    points[0] - around[0],
    points[1] - around[1],
    points[2] - around[2],
  ];
  int i = 0;
  for (i = 0; i < 3; i++) {
    newPositions[0] += rotationmatrix[0][i] * pointsAroundOrigin[i];
  }
  for (i = 0; i < 3; i++) {
    newPositions[1] += rotationmatrix[1][i] * pointsAroundOrigin[i];
  }
  for (i = 0; i < 3; i++) {
    newPositions[2] += rotationmatrix[2][i] * pointsAroundOrigin[i];
  }
  for (i = 0; i < 3; i++) {
    newPositions[i] += around[i];
  }
  return newPositions;
}


// List<double> update2DCordinates(List<double> points, List<double> camera) {
//   camera = [768, 376.79998779296875,-200];
//   List<double> cordinates = [
//     ((points[0] - camera[0]) *
//             ((points[2] - camera[2]) / points[2] == 0 ? 1 : points[2])) +
//         camera[0],
//     ((points[1] - camera[1]) *
//             ((points[2] - camera[2]) / points[2] == 0 ? 1 : points[2])) +
//         camera[1]
//   ];
//   return cordinates;
// }

// List<double> update2DCordinates(List<double> points, List<double> camera) {
//   List <double> origin = [768, 376.79998779296875, 0];
//   List<double> temp = List.generate(3, (index) => points[index]-origin[index]);

//   List<double> cordinates = [
//     temp[0]*(-20)/temp[2],
//     temp[1]*(-20)/temp[2]
//   ];
//   cordinates[0]+=temp[0];
//   cordinates[1]+=temp[1];
//   return cordinates;
// }
