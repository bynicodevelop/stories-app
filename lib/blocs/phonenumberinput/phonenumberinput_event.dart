import 'package:equatable/equatable.dart';

abstract class PhoneNumberInputEvent extends Equatable {
  const PhoneNumberInputEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends PhoneNumberInputEvent {
  final String phoneNumber;

  const PhoneNumberChanged({
    this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}
