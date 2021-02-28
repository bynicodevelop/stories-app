import 'package:app/blocs/bloc.dart';
import 'package:app/formModels/PhoneNumber.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberInput extends StatelessWidget {
  final Function(String) onValidedValue;
  final String label;
  final String errorMessage;

  const PhoneNumberInput({
    Key key,
    @required this.onValidedValue,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneNumberInputBloc, PhoneNumberInputState>(
      listener: (context, state) {
        if (state.phoneNumber.valid) {
          onValidedValue(state.phoneNumber.value);
        }
      },
      child: BlocBuilder<PhoneNumberInputBloc, PhoneNumberInputState>(
        builder: (context, state) {
          return TextInput(
            label: label,
            prefixIcon: Icon(Icons.phone),
            errorText: state.phoneNumber.error != PhoneNumberInputError.empty &&
                    state.phoneNumber.error != null
                ? errorMessage
                : null,
            onChanged: (value) => context.read<PhoneNumberInputBloc>().add(
                  PhoneNumberChanged(
                    phoneNumber: value,
                  ),
                ),
          );
        },
      ),
    );
  }
}
