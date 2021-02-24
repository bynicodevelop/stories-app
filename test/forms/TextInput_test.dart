import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets("Control l'affichage des elements", (WidgetTester tester) async {
    // ARRANGE
    final String label = 'username';
    final Icon icon = Icon(Icons.ac_unit);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextInput(
            label: label,
            prefixIcon: icon,
          ),
        ),
      ),
    );

    // ACT
    final Finder labelFinder = find.text(label);
    final Finder prefixIconFinder = find.byIcon(Icons.ac_unit);

    // ASSERT
    expect(labelFinder, findsOneWidget);
    expect(prefixIconFinder, findsOneWidget);
  });

  testWidgets("Ne doit pas afficher d'icon", (WidgetTester tester) async {
    // ARRANGE
    final String label = 'username';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextInput(
            label: label,
          ),
        ),
      ),
    );

    // ACT
    final Finder labelFinder = find.text(label);
    final Finder prefixIconFinder = find.byIcon(Icons.ac_unit);

    // ASSERT
    expect(labelFinder, findsOneWidget);
    expect(prefixIconFinder, findsNothing);
  });

  testWidgets("Doit tester que la méthode onChanged est bien appelée",
      (WidgetTester tester) async {
    // ARRANGE
    final String label = 'username';
    String changed = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextInput(
            label: label,
            onChanged: (_) => changed = _,
          ),
        ),
      ),
    );

    expect(changed, '');

    // ACT
    final Finder inputFinder = find.byType(TextFormField);

    await tester.enterText(inputFinder, 'text');
    await tester.pumpAndSettle();

    // // ASSERT
    expect(changed, 'text');
  });
}
