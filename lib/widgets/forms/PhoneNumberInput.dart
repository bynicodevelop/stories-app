import 'package:app/blocs/bloc.dart';
import 'package:app/formModels/PhoneNumber.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberInput extends StatelessWidget {
  final String label;
  final String errorMessage;

  const PhoneNumberInput({
    Key key,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationformBloc, ReservationformState>(
      builder: (context, state) {
        return TextInput(
          label: label,
          prefixIcon: Icon(Icons.phone),
          errorText: state.phoneNumber.error != PhoneNumberInputError.empty &&
                  state.phoneNumber.error != null
              ? errorMessage
              : null,
          onChanged: (value) => context.read<ReservationformBloc>().add(
                PhoneNumberChanged(
                  phoneNumber: value,
                ),
              ),
        );
      },
    );
  }
}
