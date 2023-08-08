import 'package:flutter/material.dart';
import 'package:pr_6_animator/controllers/planet_controller.dart';
import 'package:pr_6_animator/views/screens/detail_page.dart';
import 'package:pr_6_animator/views/screens/home_page.dart';
import 'package:pr_6_animator/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PlanetController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const HomePage(),
        'splash_screen': (context) => const SplashScreen(),
        'detail_page': (context) => const DetailPage(),
      },
    );
  }
}
