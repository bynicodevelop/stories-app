import 'dart:async';

import 'package:app/blocs/phonenumberinput/bloc.dart';
import 'package:app/formModels/PhoneNumber.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class PhoneNumberInputBloc
    extends Bloc<PhoneNumberInputEvent, PhoneNumberInputState> {
  PhoneNumberInputBloc() : super(PhoneNumberInputState());

  @override
  Stream<PhoneNumberInputState> mapEventToState(
    PhoneNumberInputEvent event,
  ) async* {
    if (event is PhoneNumberChanged) {
      PhoneNumber phoneNumber = PhoneNumber.dirty(event.phoneNumber);

      yield state.copyWith(
        phoneNumber: phoneNumber.valid
            ? phoneNumber
            : PhoneNumber.pure(event.phoneNumber),
        status: Formz.validate([phoneNumber]),
      );
    }
  }
}
