import 'package:app/blocs/emailinput/bloc.dart';
import 'package:app/formModels/Email.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInput extends StatelessWidget {
  final Function(String) onValidatedValue;
  final String label;
  final String errorMessage;

  const EmailInput({
    Key key,
    @required this.onValidatedValue,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailInputBloc, EmailInputState>(
      listener: (context, state) {
        if (state.email.valid) {
          onValidatedValue(state.email.value);
        }
      },
      child: BlocBuilder<EmailInputBloc, EmailInputState>(
        builder: (context, state) {
          return TextInput(
            label: label,
            prefixIcon: Icon(Icons.email),
            errorText: state.email.error != EmailInputError.empty &&
                    state.email.error != null
                ? errorMessage
                : null,
            onChanged: (value) => context.read<EmailInputBloc>().add(
                  EmailChanged(
                    email: value,
                  ),
                ),
          );
        },
      ),
    );
  }
}