import 'package:app/widgets/topography/Headline.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Headline(
            text: 'Vous êtes connecté',
          ),
        ),
      ),
    );
  }
}
