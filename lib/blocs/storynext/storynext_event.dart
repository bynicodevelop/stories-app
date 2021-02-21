import 'package:equatable/equatable.dart';

abstract class StorynextEvent extends Equatable {}

class StoryNextStarted extends StorynextEvent {
  @override
  List<Object> get props => [];
}

class StoryNextPageEvent extends StorynextEvent {
  final int index;

  StoryNextPageEvent(this.index);

  @override
  List<Object> get props => [index];
}
