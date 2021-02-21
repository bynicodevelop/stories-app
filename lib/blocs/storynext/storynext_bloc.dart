import 'dart:async';

import 'package:app/blocs/storynext/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorynextBloc extends Bloc<StorynextEvent, StorynextState> {
  StorynextBloc() : super(StorynextInitial());

  @override
  Stream<StorynextState> mapEventToState(
    StorynextEvent event,
  ) async* {
    print('event: $event');

    if (event is StoryNextPageEvent) {
      yield state.copyWith(event.index);
    }
  }
}
