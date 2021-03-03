import 'package:app/screens/authentication/ConnexionScreen.dart';
import 'package:app/screens/authentication/ProfileScreen.dart';
import 'package:app/widgets/forms/MainButton.dart';
import 'package:app/widgets/topography/Headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/blocs/bloc.dart';

class HomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute<void>(builder: (_) => HomeScreen());

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                ProfileScreen.route(),
              ),
              child: Icon(
                Icons.person,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Headline(
              text: 'Vous êtes connecté',
            ),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    ConnectionScreen.route(),
                    (_) => false,
                  );
                }
              },
              child: MainButton(
                label: 'Deconnection',
                onPressed: () =>
                    context.read<AuthenticationBloc>().add(SignOut()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
