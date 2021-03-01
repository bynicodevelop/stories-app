import 'package:app/blocs/passwordinput/bloc.dart';
import 'package:app/formModels/Password.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PasswordInput extends StatelessWidget {
  final Function(String) onValidatedValue;
  final String label;
  final String errorMessage;

  const PasswordInput({
    Key key,
    @required this.onValidatedValue,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordInputBloc, PasswordInputState>(
      listener: (context, state) {
        if (state.status == FormzStatus.valid) {
          onValidatedValue(state.password.value);
        }
      },
      child: BlocBuilder<PasswordInputBloc, PasswordInputState>(
        builder: (context, state) => TextInput(
          label: label,
          isSecret: true,
          prefixIcon: Icon(Icons.lock),
          errorText: state.password.error != PasswordInputError.empty &&
                  state.password.error != null
              ? errorMessage
              : null,
          onChanged: (value) => context.read<PasswordInputBloc>().add(
                PasswordChanged(
                  password: value,
                ),
              ),
        ),
      ),
    );
  }
}
