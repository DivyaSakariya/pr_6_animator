import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/planet_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late AnimationController animationController;

  late Animation rotate;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    rotate = Tween(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Map sunMap = {
    "position": "1",
    "name": "Sun",
    "image": "assets/images/sun.gif",
    "year": "60,990 Earth Day",
    "type": "Gas Glant",
    "radius": "696,340.0 KM",
    "velocity": "220",
    "distance": "0",
    "description":
        "The Sun (or Sol), is the star at the centre of our solar system and is responsible for the Earth’s climate and weather. The Sun is an almost perfect sphere with a difference of just 10km in diameter between the poles and the equator. The average radius of the Sun is 695,508 km (109.2 x that of the Earth) of which 20–25% is the core."
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dynamic pf = Provider.of<PlanetController>(context, listen: false);
    dynamic pt = Provider.of<PlanetController>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.75),
                  BlendMode.darken,
                ),
                image: const AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0, -1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                "Solar System",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(1, -1),
            child: SizedBox(
              height: 150,
              child: Image.asset(
                sunMap['image'],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.5, 0.8),
            child: AnimatedDefaultTextStyle(
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              duration: const Duration(milliseconds: 350),
              child: Text(
                pf.allPlanets[currentIndex]['name'],
              ),
            ),
          ),

          // Stack(
          //   children: [
          //     Positioned(
          //       top: 250,
          //       right: 250,
          //       child: RotationTransition(
          //         turns: Tween<double>(begin: 0.0, end: (pi * 2).toDouble())
          //             .animate(animationController),
          //         child: Container(
          //           height: 250,
          //           width: 250,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             image: DecorationImage(
          //               image: AssetImage(
          //                 pt.allPlanets[0]['image'],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          ListWheelScrollView.useDelegate(
            itemExtent: 280,
            physics: const FixedExtentScrollPhysics(),
            offAxisFraction: 1.4,
            onSelectedItemChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            squeeze: 0.7,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: pt.allPlanets.length,
              builder: (context, index) => AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pushNamed('detail_page',
                              arguments: pt.allPlanets[index]);
                        });
                      },
                      child: Transform.rotate(
                        angle: rotate.value,
                        child: Hero(
                          tag: pt.allPlanets[index]['name'],
                          child: Container(
                            height: currentIndex == index
                                ? currentIndex == 6
                                    ? size.height * 0.95
                                    : size.height * 0.35
                                : size.height * 0.35,
                            width: currentIndex == index
                                ? currentIndex == 6
                                    ? size.height * 0.95
                                    : size.height * 0.35
                                : size.width * 0.35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  pt.allPlanets[index]['image'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
