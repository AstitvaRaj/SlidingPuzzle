import 'dart:math';

import 'package:flutter/material.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.orange,
    Colors.red,
    Colors.green
  ];
  late int index;
  int count = 0;
  @override
  void initState() {
    super.initState();
    animation = AnimationController(
        value: 0,
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 0,
        upperBound: 1)

      // ..animateTo(1)
      ..forward();
    animation.addStatusListener((status) {
      if (animation.isAnimating) {
        // setState(() {});
      } else if (animation.isCompleted) {
      }
    });
    index = Random().nextInt(3);
  }

  @override
  void dispose() {
    super.dispose();
    animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 1),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (_, __, ___) => Opacity(
            opacity: __ as double,
            child: Container(
                color: colors[index], child: Text('Mobile Layout $__')),
          ),
        ),
      ),
    );
  }
}
