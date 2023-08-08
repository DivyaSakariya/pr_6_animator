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

  late Animation index;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    index = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
  }

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
                "MilkyWay Galaxy",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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

          Stack(
            children: [
              Positioned(
                top: 250,
                right: 250,
                child: RotationTransition(
                  turns: Tween<double>(begin: 0.0, end: (pi * 2).toDouble())
                      .animate(animationController),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          pt.allPlanets[0]['image'],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ListWheelScrollView.useDelegate(
          //   itemExtent: 280,
          //   physics: const FixedExtentScrollPhysics(),
          //   offAxisFraction: 1.4,
          //   onSelectedItemChanged: (index) {
          //     setState(() {
          //       currentIndex = index;
          //     });
          //   },
          //   squeeze: 0.7,
          //   childDelegate: ListWheelChildBuilderDelegate(
          //     childCount: pt.allPlanets.length,
          //     builder: (context, index) => TweenAnimationBuilder(
          //         tween: Tween(begin: 0.0, end: pi * 2),
          //         duration: const Duration(seconds: 5),
          //         builder: (context, val, _) {
          //           return GestureDetector(
          //             onTap: () {
          //               Navigator.of(context).pushNamed('planet_detail_page',
          //                   arguments: pt.allPlanets[index]);
          //             },
          //             child: Hero(
          //               tag: pt.allPlanets[index]['name'],
          //               child: Container(
          //                 height: currentIndex == index
          //                     ? size.height * 0.65
          //                     : size.height * 0.35,
          //                 width: currentIndex == index
          //                     ? size.width * 0.65
          //                     : size.width * 0.35,
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   image: DecorationImage(
          //                     image: AssetImage(
          //                       pt.allPlanets[index]['image'],
          //                     ),
          //                     fit: BoxFit.cover,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
