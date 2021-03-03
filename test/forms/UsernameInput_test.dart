import 'package:app/blocs/bloc.dart';
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

  testWidgets("Doit retourer de valeur meme invalide (vide) mais sans message",
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
            errorMessage: 'error message',
            onChanged: (value) => result = value,
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
