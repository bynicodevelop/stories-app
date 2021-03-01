import 'package:app/blocs/passwordinput/bloc.dart';
import 'package:app/formModels/Password.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PasswordInput extends StatefulWidget {
  final Function(String) onValidedValue;
  final String label;
  final String errorMessage;

  const PasswordInput({
    Key key,
    @required this.onValidedValue,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isSecret = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordInputBloc, PasswordInputState>(
      listener: (context, state) {
        if (state.status == FormzStatus.valid) {
          widget.onValidedValue(state.password.value);
        }
      },
      child: BlocBuilder<PasswordInputBloc, PasswordInputState>(
        builder: (context, state) => TextInput(
          label: widget.label,
          isSecret: _isSecret,
          prefixIcon: Icon(Icons.lock),
          errorText: state.password.error != PasswordInputError.empty &&
                  state.password.error != null
              ? widget.errorMessage
              : null,
          onChanged: (value) => context.read<PasswordInputBloc>().add(
                PasswordChanged(
                  password: value,
                ),
              ),
          suffixIcon: InkWell(
            onTap: () => setState(() => _isSecret = !_isSecret),
            child: Icon(_isSecret ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
