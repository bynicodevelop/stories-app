abstract class StorynextState {
  int currentIndex;

  StorynextState copyWith(int index);
}

class StorynextInitial extends StorynextState {
  final int currentIndex;

  StorynextInitial({
    this.currentIndex = 0,
  });

  List<Object> get props => [currentIndex];

  @override
  StorynextState copyWith(int index) {
    return StorynextInitial(currentIndex: index);
  }
}

class StoryNextPageState extends StorynextState {
  final int currentIndex;

  StoryNextPageState({this.currentIndex});

  StoryNextPageState copyWith(int index) {
    return StoryNextPageState(
      currentIndex: index,
    );
  }

  List<Object> get props => [currentIndex];
}
