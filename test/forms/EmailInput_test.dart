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

  testWidgets("Doit permet l'ajout d'une value par default",
      (WidgetTester tester) async {
    String emailValidated = '';

    // ARRANGE
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
            onValidatedValue: (value) => emailValidated = value,
            initialValue: 'john.doe@domain.tld',
          ),
        ),
      ),
    ));

    // ACT
    final TextInput textInput = tester.firstWidget(find.byType(TextInput));

    // ASSERT
    expect(textInput.initialValue, 'john.doe@domain.tld');
    expect(emailValidated, 'john.doe@domain.tld');
  });

  testWidgets(
      "Doit afficher un message d'erreur si l'email initial est invalide",
      (WidgetTester tester) async {
    String emailValidated = '';

    // ARRANGE
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
            errorMessage: 'error message',
            onValidatedValue: (value) => emailValidated = value,
            initialValue: 'john',
          ),
        ),
      ),
    ));

    // ACT
    await tester.pumpAndSettle();

    final TextInput textInput = tester.firstWidget(find.byType(TextInput));
    final Finder errorText = find.text('error message');

    // ASSERT
    expect(textInput.initialValue, 'john');
    expect(emailValidated, '');
    expect(errorText, findsOneWidget);
  });

  testWidgets("Doit être possible d'ajouter un text d'aide",
      (WidgetTester tester) async {
    // ARRANGE
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
            onValidatedValue: (value) => null,
            helperText: 'Helper content',
          ),
        ),
      ),
    ));

    // ACT
    final TextInput textInput = tester.firstWidget(find.byType(TextInput));

    // ASSERT
    expect(textInput.helperText, 'Helper content');
  });
}
