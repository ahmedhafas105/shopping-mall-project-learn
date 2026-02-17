import 'package:flutter/material.dart';
import 'package:shaas_grocery_app/features/home/ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Easing.emphasizedAccelerate,
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}
