import 'package:app/formModels/PhoneNumber.dart';
import 'package:app/formModels/Slug.dart';
import 'package:app/formModels/Username.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class ReservationformState extends Equatable {
  final Username username;
  final Slug slug;
  final PhoneNumber phoneNumber;
  final FormzStatus status;

  const ReservationformState({
    this.username = const Username.pure(),
    this.slug = const Slug.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
  });

  ReservationformState copyWith({
    Username username,
    Slug slug,
    PhoneNumber phoneNumber,
    FormzStatus status,
  }) {
    return ReservationformState(
      username: username ?? this.username,
      slug: slug ?? this.slug,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        username,
        slug,
        phoneNumber,
        status,
      ];
}
