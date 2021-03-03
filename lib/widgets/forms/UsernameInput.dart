import 'package:app/blocs/bloc.dart';
import 'package:app/formModels/Username.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameInput extends StatelessWidget {
  final Function(String) onChanged;
  final String label;
  final String errorMessage;

  const UsernameInput({
    Key key,
    @required this.onChanged,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsernameInputBloc, UsernameInputState>(
      listener: (context, state) {
        onChanged(state.username.value);
      },
      child: BlocBuilder<UsernameInputBloc, UsernameInputState>(
        builder: (context, state) {
          return TextInput(
            label: label,
            prefixIcon: Icon(Icons.person),
            errorText: state.username.error != UsernameInputError.empty &&
                    state.username.error != null
                ? errorMessage
                : null,
            onChanged: (value) => context.read<UsernameInputBloc>().add(
                  UsernameChanged(
                    username: value,
                  ),
                ),
          );
        },
      ),
    );
  }
}
