import 'package:app/blocs/bloc.dart';
import 'package:app/blocs/connectionform/bloc.dart';
import 'package:app/blocs/emailinput/bloc.dart';
import 'package:app/blocs/reservationform/bloc.dart';
import 'package:app/blocs/sluginput/bloc.dart';
import 'package:app/blocs/usernameinput/bloc.dart';
import 'package:app/configs/ColorsThemeData.dart';
import 'package:app/screens/authentication/ConnexionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:services/services.dart';

// Permet de définir si on est en dev mode
// En fonction du fichier launch de VSCode
bool isDevelopmentMode() {
  const mode = String.fromEnvironment("MODE");

  return mode == 'development';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  print('isDevelopmentMode: ${isDevelopmentMode()}');

  runApp(
    Services(
      isDevelopement: isDevelopmentMode(),
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
        ),
        BlocProvider<PasswordInputBloc>(
          create: (context) => PasswordInputBloc(),
        ),
        BlocProvider<PhoneNumberInputBloc>(
          create: (context) => PhoneNumberInputBloc(),
        ),
        BlocProvider<SlugInputBloc>(
          create: (context) => SlugInputBloc(),
        ),
        BlocProvider<UsernameInputBloc>(
          create: (context) => UsernameInputBloc(),
        ),
        BlocProvider<EmailInputBloc>(
          create: (context) => EmailInputBloc(),
        ),
        BlocProvider<ConnectionFormBloc>(
          create: (context) => ConnectionFormBloc(),
        ),
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
        home: ConnectionScreen(),
      ),
    );
  }
}
