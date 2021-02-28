import 'package:app/blocs/usernameinput/bloc.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:app/widgets/forms/UsernameInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets("Doit retourner une valeur valide", (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '123456';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<UsernameInputBloc>(
          create: (context) => UsernameInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: UsernameInput(
            label: 'password',
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

  testWidgets("Ne doit pas retourer de valeur si invalide (vide)",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<UsernameInputBloc>(
          create: (context) => UsernameInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: UsernameInput(
            label: 'slug',
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
