import 'package:app/blocs/bloc.dart';
import 'package:app/formModels/Password.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInput extends StatelessWidget {
  final Function(String) onChanged;
  final String label;
  final String errorMessage;

  const PasswordInput({
    Key key,
    @required this.onChanged,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordInputBloc, PasswordInputState>(
      listener: (context, state) {
        onChanged(state.password.value);
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
