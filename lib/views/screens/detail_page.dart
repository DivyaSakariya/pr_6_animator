import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController positionController;

  late Animation opacity;
  late Animation positionName;
  late Animation positionType;
  late Animation opacityDescp;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    positionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..forward();

    opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeInOut,
        ),
      ),
    );

    positionName = Tween(begin: 235.0, end: 0.0).animate(
      CurvedAnimation(
        parent: positionController,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    positionType = Tween(begin: -235.0, end: 0.0).animate(
      CurvedAnimation(
        parent: positionController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.easeInOut,
        ),
      ),
    );
    opacityDescp = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: positionController,
        curve: const Interval(
          0.8,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    // dynamic data = Provider.of<PlanetController>(context).allPlanets[2];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['name'],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Hero(
                          tag: data['name'],
                          child: Container(
                            height: 500,
                            width: 500,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(data['image']),
                              ),
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                            animation: positionController,
                            builder: (context, child) {
                              return Opacity(
                                opacity: opacity.value,
                                child: Card(
                                  color:
                                      const Color(0xff30315D).withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Transform.translate(
                                          offset: Offset(positionName.value, 0),
                                          child: Text(
                                            data['name'],
                                            style: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Transform.translate(
                                          offset: Offset(positionType.value, 0),
                                          child: Text(
                                            data['type'],
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        Opacity(
                                          opacity: opacityDescp.value,
                                          child: Column(
                                            children: [
                                              Text(
                                                data['description'],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Years:-",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  Text(
                                                    " ${data['year']}",
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Radius:-",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  Text(
                                                    " ${data['radius']}",
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Velocity:-",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  Text(
                                                    " ${data['velocity']}",
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Distance:-",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  Text(
                                                    " ${data['distance']} Light Years",
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
