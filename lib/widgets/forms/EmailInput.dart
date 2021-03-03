import 'package:app/blocs/bloc.dart';
import 'package:app/formModels/Email.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInput extends StatefulWidget {
  final Function(String) onChanged;
  final String label;
  final String errorMessage;
  final String initialValue;
  final String helperText;

  EmailInput({
    Key key,
    @required this.onChanged,
    @required this.label,
    @required this.errorMessage,
    this.initialValue,
    this.helperText,
  }) : super(key: key);

  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      context.read<EmailInputBloc>().add(
            EmailChanged(
              email: widget.initialValue,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailInputBloc, EmailInputState>(
      listener: (context, state) {
        widget.onChanged(state.email.value);
      },
      child: BlocBuilder<EmailInputBloc, EmailInputState>(
        builder: (context, state) {
          return TextInput(
            initialValue: widget.initialValue,
            helperText: widget.helperText,
            label: widget.label,
            prefixIcon: Icon(Icons.email),
            errorText: state.email.error != EmailInputError.empty &&
                    state.email.error != null
                ? widget.errorMessage
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
