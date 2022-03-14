import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rubikscube/layouts/weblayout.dart';
import 'package:rubikscube/model/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late Game game;
  late double cubeSize;
  late double centerX;
  late double centerY;
  
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    bool isMobile;
    if (width < height) {
      isMobile = true;
    } else {
      isMobile = false;
    }
    cubeSize = min(height, width) / (isMobile ? 6 : 5);
    centerX = isMobile ? (width / 2) : (width / 2) * 1.35;
    centerY = isMobile ? height / 2.5 : height / 2;
    game = Game(
      cubeSize: cubeSize,
      centerX: centerX,
      centerY: centerY,
    );
    return WebLayout(height:height,width:width,game:game);
  }
}
