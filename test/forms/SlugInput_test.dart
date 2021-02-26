import 'package:app/blocs/sluginput/bloc.dart';
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
            onValidedValue: (value) => result = value,
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
            onValidedValue: (value) => result = value,
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

  testWidgets("Ne doit pas retourer de valeur si invalide (john-DOE)",
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
            errorMessage: '',
            onValidedValue: (value) => result = value,
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

  testWidgets("Ne doit pas retourer de valeur si invalide (john doe)",
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
            errorMessage: '',
            onValidedValue: (value) => result = value,
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
