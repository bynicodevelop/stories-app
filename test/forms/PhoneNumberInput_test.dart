import 'package:app/blocs/bloc.dart';
import 'package:app/widgets/forms/PhoneNumberInput.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets("Doit retourner une valeur valide", (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '+33601010101';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<PhoneNumberInputBloc>(
          create: (context) => PhoneNumberInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: PhoneNumberInput(
            label: 'Phone Number',
            errorMessage: '',
            onChanged: (value) => result = value,
          ),
        ),
      ),
    ));

    // ACT
    final Finder textInput = find.byType(TextInput);
    await tester.enterText(textInput, enteredText);

    // ASSERT
    expect(result, enteredText);
  });

  testWidgets(
      "Doit retourer de valeur même invalide (avec un message d'erreur)",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '12345';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<PhoneNumberInputBloc>(
          create: (context) => PhoneNumberInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: PhoneNumberInput(
            label: 'password',
            errorMessage: 'error message',
            onChanged: (value) => result = value,
          ),
        ),
      ),
    ));

    // ACT
    final Finder textInput = find.byType(TextInput);
    await tester.enterText(textInput, enteredText);
    await tester.pumpAndSettle();

    // ASSERT
    expect(find.text('error message'), findsOneWidget);
    expect(result, '12345');
  });
}
