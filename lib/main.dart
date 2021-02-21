import 'package:app/Home.dart';
import 'package:app/blocs/bloc.dart';
import 'package:app/configs/ColorsThemeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  runApp(
    Services(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<StorynextBloc>(
            create: (context) => StorynextBloc()..add(StoryNextStarted()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Run new stories...',
          theme: ColorsThemeData.lightThemeData,
          home: Home(),
        ));
  }
}
