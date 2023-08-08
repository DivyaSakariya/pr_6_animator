import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late bool animate;
  late MyAnimation animatePosition;
  late AnimationController _animationController;

  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamed('/');
    });

    changePosition();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  changePosition() async {
    animate = false;
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        animate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.easeInOut,
              top: -150.0,
              left: animate!
                  ? -650.0
                  : -1000.0,
              bottom: -150.0,
              child: Image.asset(
                'assets/images/earth_home.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: Positioned(
                  left: 22,
                  right: 22,
                  bottom: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Discover Your",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        "Solar System",
                        style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF0090CE),
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAnimation {
  final double? topAfter, leftAfter, bottomAfter, rightAfter;
  final double? topBefore, leftBefore, bottomBefore, rightBefore;

  MyAnimation({
    this.topAfter,
    this.leftAfter,
    this.bottomAfter,
    this.rightAfter,
    this.topBefore,
    this.leftBefore,
    this.bottomBefore,
    this.rightBefore,
  });
}
