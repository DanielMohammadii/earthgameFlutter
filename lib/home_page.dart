import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RotatingMars extends StatefulWidget {
  const RotatingMars({super.key});

  @override
  State<RotatingMars> createState() => _RotatingMarsState();
}

class _RotatingMarsState extends State<RotatingMars>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: sky(),
        ),
        child: colorchange(),
      ),
    );
  }

  DecorationImage sky() {
    return DecorationImage(
      image: AssetImage("assets/images/sky.jpg"),
      fit: BoxFit.cover,
    );
  }

  TweenAnimationBuilder<Color?> colorchange() {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(begin: Colors.orange, end: Colors.blue),
      duration: const Duration(milliseconds: 10000),
      builder: (context, Color? color, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            color ?? Colors.transparent,
            BlendMode.modulate,
          ),
          child: rotatetrans(),
        );
      },
    );
  }

  RotationTransition rotatetrans() {
    return RotationTransition(
        turns: _controller,
        child: GestureDetector(
            onTap: () {
              if (_controller.isAnimating) {
                _controller.stop();
              } else {
                _controller.repeat();
              }
            },
            child: Image.asset('assets/images/sun.png')));
  }
}
