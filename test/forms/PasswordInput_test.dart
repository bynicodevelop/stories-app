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

  testWidgets("Doit retourer de valeur même invalide",
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
