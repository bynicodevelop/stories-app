import 'dart:async';

import 'package:app/blocs/sluginput/bloc.dart';
import 'package:app/formModels/Slug.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class SlugInputBloc extends Bloc<SlugInputEvent, SlugInputState> {
  SlugInputBloc() : super(SlugInputState());

  @override
  Stream<SlugInputState> mapEventToState(
    SlugInputEvent event,
  ) async* {
    if (event is SlugChanged) {
      Slug slug = Slug.dirty(event.slug);

      yield state.copyWith(
        slug: slug.valid ? slug : Slug.pure(event.slug),
        status: Formz.validate([slug]),
      );
    }
  }
}
