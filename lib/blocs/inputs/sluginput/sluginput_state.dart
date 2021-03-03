import 'package:app/formModels/Slug.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class SlugInputState extends Equatable {
  final Slug slug;
  final FormzStatus status;

  const SlugInputState({
    this.slug = const Slug.pure(),
    this.status = FormzStatus.pure,
  });

  SlugInputState copyWith({
    Slug slug,
    FormzStatus status,
  }) {
    return SlugInputState(
      slug: slug ?? this.slug,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        slug,
        status,
      ];
}
