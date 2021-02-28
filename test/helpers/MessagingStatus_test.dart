import 'package:app/helpers/MessagingStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets("Doit affichez un message", (WidgetTester tester) async {
    // ARRANGE
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    MessagingStatus reservationMessagingStatus =
        MessagingStatus({'test': 'coucou'});

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        key: scaffoldState,
        body: RaisedButton(
          onPressed: () => reservationMessagingStatus.message(
              scaffoldState.currentState, 'test'),
        ),
      ),
    ));

    final Finder button = find.byType(RaisedButton);

    // ACT
    await tester.tap(button);
    await tester.pumpAndSettle();

    final Finder message = find.text("coucou");

    // ASSERT
    expect(message, findsOneWidget);
  });

  testWidgets("Ne doit pas affichez de message", (WidgetTester tester) async {
    // ARRANGE
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    MessagingStatus reservationMessagingStatus = MessagingStatus({});

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        key: scaffoldState,
        body: RaisedButton(
          onPressed: () => reservationMessagingStatus.message(
              scaffoldState.currentState, 'test'),
        ),
      ),
    ));

    final Finder button = find.byType(RaisedButton);

    // ACT
    await tester.tap(button);
    await tester.pumpAndSettle();

    final Finder message = find.text("coucou");

    // ASSERT
    expect(message, findsNothing);
  });
}
