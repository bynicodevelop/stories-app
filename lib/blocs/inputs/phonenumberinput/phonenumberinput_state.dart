import 'package:app/formModels/PhoneNumber.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class PhoneNumberInputState extends Equatable {
  final PhoneNumber phoneNumber;
  final FormzStatus status;

  const PhoneNumberInputState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
  });

  PhoneNumberInputState copyWith({
    PhoneNumber phoneNumber,
    FormzStatus status,
  }) {
    return PhoneNumberInputState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        phoneNumber,
        status,
      ];
}
