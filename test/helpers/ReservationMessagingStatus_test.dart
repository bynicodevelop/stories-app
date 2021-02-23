import 'package:app/helpers/ReservationMessagingStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:services/blocs/reservation/reservation_state.dart';

main() {
  testWidgets("Doit afficher un message d'erreur si le Slug existe",
      (WidgetTester tester) async {
    // ARRANGE
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    ReservationMessagingStatus reservationMessagingStatus =
        ReservationMessagingStatus({
      ReservationStatus.slugAlreadyExists:
          "L'identifiant que vous avez saisi existe déjà...",
      ReservationStatus.phoneAlreadyExists:
          "Une réservation existe déjà avec ce numéro de téléphone.",
    });

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        key: scaffoldState,
        body: RaisedButton(
          onPressed: () => reservationMessagingStatus.message(
              scaffoldState.currentState, ReservationStatus.slugAlreadyExists),
        ),
      ),
    ));

    final Finder button = find.byType(RaisedButton);

    // ACT
    await tester.tap(button);
    await tester.pumpAndSettle();

    final Finder message =
        find.text("L'identifiant que vous avez saisi existe déjà...");

    // ASSERT
    expect(message, findsOneWidget);
  });

  testWidgets(
      "Doit afficher un message d'erreur si le numero de téléphone existe",
      (WidgetTester tester) async {
    // ARRANGE
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    ReservationMessagingStatus reservationMessagingStatus =
        ReservationMessagingStatus({
      ReservationStatus.slugAlreadyExists:
          "L'identifiant que vous avez saisi existe déjà...",
      ReservationStatus.phoneAlreadyExists:
          "Une réservation existe déjà avec ce numéro de téléphone.",
    });

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        key: scaffoldState,
        body: RaisedButton(
          onPressed: () => reservationMessagingStatus.message(
              scaffoldState.currentState, ReservationStatus.phoneAlreadyExists),
        ),
      ),
    ));

    final Finder button = find.byType(RaisedButton);

    // ACT
    await tester.tap(button);
    await tester.pumpAndSettle();

    final Finder message =
        find.text("Une réservation existe déjà avec ce numéro de téléphone.");

    // ASSERT
    expect(message, findsOneWidget);
  });
}
