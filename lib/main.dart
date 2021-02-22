import 'package:app/blocs/bloc.dart';
import 'package:app/configs/ColorsThemeData.dart';
import 'package:app/screens/authentication/ReservationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
          ),
          BlocProvider<ReservationformBloc>(
            create: (context) => ReservationformBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Run new stories...',
          theme: ColorsThemeData.lightThemeData,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('fr', ''),
          ],
          home: ReservationScreen(),
        ));
  }
}
