import 'package:flutter/material.dart';
import 'package:rubikscube/layouts/weblayout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// class _HomePageState extends State<HomePage> {
//   late double cubeSize;
//   double anglex = 0, angley = 0, anglez = 0;
//   double cursorX = 0, cursorY = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     cubeSize = min(height - 30, width - 30) / 2;
//     return Scaffold(
//       body: Stack(
//         children: [
//           GestureDetector(
//             onPanStart: (details) {
//               setState(() {
//                 cursorX = details.localPosition.dx;
//                 cursorY = details.localPosition.dy;
//               });
//             },
//             onPanUpdate: (details) => setState(() {
//               angley =
//                   (angley + ((details.localPosition.dy - cursorY) / 5000)) %
//                       degreeToRadian(degree: 360);
//               anglex =
//                   (anglex + ((details.localPosition.dx - cursorX) / 5000)) %
//                       degreeToRadian(degree: 360);
//               anglez = (anglex + angley) % degreeToRadian(degree: 720);
//             }),
//             child: Container(
//               color: Colors.blue.shade100,
//               height: height,
//               width: width,
//             ),
//           ),
//           Center(
//             child: Transform(
//               origin: const Offset(100, 100),
//               transform: Matrix4.identity()
//                 ..rotateX(-angley)
//                 ..rotateY(anglex),
//               // ..rotateZ(0.1),
//               child: Cubelet(
//                 cubeSize: 300,
//                 angleX: anglex,
//                 angleY: angley,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 20,
//             right: 20,
//             child: IconButton(
//               icon: const Icon(
//                 Icons.reset_tv,
//               ),
//               onPressed: () => setState(() {
//                 anglex = 0;
//                 angley = 0;
//                 anglez = 0;
//               }),
//             ),
//           ),
//           Positioned(
//             top: 50,
//             right: 20,
//             child: Text(
//                 'anglex : $anglex\nangley: $angley\nanglez:${degreeToRadian(degree: 90)}'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    // return MediaQuery.of(context).size.aspectRatio < 0.8
    //     ? const MobileLayout()
    //     : const WebLayout();
    return const WebLayout();
  }
}
