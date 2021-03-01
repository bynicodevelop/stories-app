import 'package:app/blocs/bloc.dart';
import 'package:app/widgets/forms/PasswordInput.dart';
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
        BlocProvider<PasswordInputBloc>(
          create: (context) => PasswordInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: PasswordInput(
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

  testWidgets("Ne doit pas retourer de valeur si invalide",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '12345';
    String result = '';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<PasswordInputBloc>(
          create: (context) => PasswordInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: PasswordInput(
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
    expect(result, '');
  });

  testWidgets("Doit verifier que pas défaut le champs mot de passe est secret",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '12345';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<PasswordInputBloc>(
          create: (context) => PasswordInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: PasswordInput(
            label: 'password',
            errorMessage: '',
            onValidedValue: (value) => null,
          ),
        ),
      ),
    ));

    final Finder textInput = find.byType(TextInput);
    await tester.enterText(textInput, enteredText);

    // ACT
    final TextInput textInputField = tester.firstWidget(find.byType(TextInput));

    // ASSERT
    expect(textInputField.isSecret, true);
  });

  testWidgets("Doit afficher le mot de passe en claire",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '12345';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<PasswordInputBloc>(
          create: (context) => PasswordInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: PasswordInput(
            label: 'password',
            errorMessage: '',
            onValidedValue: (value) => null,
          ),
        ),
      ),
    ));

    final Finder textInput = find.byType(TextInput);
    await tester.enterText(textInput, enteredText);

    final Finder changeStatePasswordIcon = find.byIcon(Icons.visibility);

    // ACT
    await tester.tap(changeStatePasswordIcon);
    await tester.pumpAndSettle();

    // // ASSERT
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);

    final TextInput textInputField = tester.firstWidget(find.byType(TextInput));
    expect(textInputField.isSecret, false);
  });

  testWidgets("Doit afficher le mot de passe en claire",
      (WidgetTester tester) async {
    // ARRANGE
    final String enteredText = '12345';

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider<PasswordInputBloc>(
          create: (context) => PasswordInputBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: PasswordInput(
            label: 'password',
            errorMessage: '',
            onValidedValue: (value) => null,
            helperText: 'Helper text',
          ),
        ),
      ),
    ));

    final TextInput textInput = tester.firstWidget(find.byType(TextInput));

    // ACT
    // // ASSERT
    expect(textInput.helperText, 'Helper text');
  });
}
