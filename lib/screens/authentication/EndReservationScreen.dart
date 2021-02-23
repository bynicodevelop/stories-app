import 'package:app/widgets/topography/BodyText.dart';
import 'package:app/widgets/topography/Headline.dart';
import 'package:flutter/material.dart';

class EndReservationScreen extends StatelessWidget {
  const EndReservationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Headline(
              text: 'Félicitations !',
            ),
            BodyText(
              text: "Vous avez reserver votre nom d'utilisateur.",
            ),
            BodyText(
              text: "Vous allez recevoir des nouvelles de nous très bientôt.",
            )
          ],
        ),
      ),
    );
  }
}
