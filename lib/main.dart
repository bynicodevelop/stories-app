import 'package:app/Home.dart';
import 'package:app/configs/ColorsThemeData.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Services(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Run new stories...',
      theme: ColorsThemeData.lightThemeData,
      home: Home(),
    );
  }
}
