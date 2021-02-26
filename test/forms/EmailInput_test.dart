import 'package:app/blocs/emailinput/bloc.dart';
import 'package:app/widgets/forms/EmailInput.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets("Doit retourner une valeur valide", (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = 'john.doe@domain.tld';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<EmailInputBloc>(
          create: (context) => EmailInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: EmailInput(
            label: 'email',
            errorMessage: '',
            onValidatedValue: (value) => result = value,
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

  testWidgets("Ne doit pas retourer de valeur si invalide",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '12345';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<EmailInputBloc>(
          create: (context) => EmailInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: EmailInput(
            label: 'email',
            errorMessage: '',
            onValidatedValue: (value) => result = value,
          ),
        ),
      ),
    ));

    // ACT
    final Finder textInput = find.byType(TextInput);
    await tester.enterText(textInput, enteredText);

    // ASSERT
    expect(result, '');
  });
}