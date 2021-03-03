import 'package:app/blocs/bloc.dart';
import 'package:app/widgets/forms/SlugInput.dart';
import 'package:app/widgets/forms/TextInput.dart';
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
        BlocProvider<SlugInputBloc>(
          create: (context) => SlugInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: SlugInput(
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

  testWidgets("Doit retourner une valeur valide (john-doe)",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = 'john-doe';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<SlugInputBloc>(
          create: (context) => SlugInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: SlugInput(
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

  testWidgets(
      "Doit retourer de valeur meme invalide (john-DOE) avec un message d'erreur",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = 'john-DOE';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<SlugInputBloc>(
          create: (context) => SlugInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: SlugInput(
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
    await tester.pumpAndSettle();

    // ASSERT
    expect(find.text('error message'), findsOneWidget);
    expect(result, 'john-DOE');
  });

  testWidgets(
      "Doit retourer de valeur si invalide (john doe) avec un message d'erreur",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = 'john doe';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<SlugInputBloc>(
          create: (context) => SlugInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: SlugInput(
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
    await tester.pumpAndSettle();

    // ASSERT
    expect(find.text('error message'), findsOneWidget);
    expect(result, 'john doe');
  });
}
