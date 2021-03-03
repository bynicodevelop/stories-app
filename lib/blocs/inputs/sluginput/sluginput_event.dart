import 'package:equatable/equatable.dart';

abstract class SlugInputEvent extends Equatable {
  const SlugInputEvent();

  @override
  List<Object> get props => [];
}

class SlugChanged extends SlugInputEvent {
  final String slug;

  const SlugChanged({
    this.slug,
  });

  @override
  List<Object> get props => [slug];
}
