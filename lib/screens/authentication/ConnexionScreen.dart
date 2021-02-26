import 'package:app/blocs/connectionform/bloc.dart';
import 'package:app/helpers/MessagingStatus.dart';
import 'package:app/helpers/Translate.dart';
import 'package:app/screens/HomeScreen.dart';
import 'package:app/widgets/forms/EmailInput.dart';
import 'package:app/widgets/forms/MainButton.dart';
import 'package:app/widgets/forms/PasswordInput.dart';
import 'package:app/widgets/topography/Headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:services/blocs/bloc.dart';
import 'package:services/exceptions/UserRepositoryException.dart';

class ConnectionScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  ConnectionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessagingStatus _messagingStatus = MessagingStatus({
      UserRepositoryException.BAD_CREDENTIALS:
          t(context).badCredentialsErrorMessage,
      UserRepositoryException.TOO_MANY_REQUESTS:
          t(context).tooManyRequestsErrorMessage
    });

    return Scaffold(
      key: _scaffoldState,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo-app.png',
                  height: 80.0,
                ),
                Headline(
                  text: t(context).connexionFormTitle,
                ),
                MultiBlocListener(
                  listeners: [
                    BlocListener<ConnectionFormBloc, ConnectionFormState>(
                        listener: (context, state) {
                      print(
                          'BlocListener ConnectionFormBloc state: ${state.status}');

                      if (state.status == FormzStatus.submissionInProgress) {
                        // TODO: Send form
                        context.read<AuthenticationBloc>().add(
                              SignInWithEmailAndPassword(
                                email: state.email.value,
                                password: state.password.value,
                              ),
                            );
                      }
                    }),
                    BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                      if (state is AuthenticationErrors) {
                        print(
                            'BlocListener ConneAuthenticationBlocctionFormBloc state: ${state.errorCode}');

                        _messagingStatus.message(
                          _scaffoldState.currentState,
                          state.errorCode,
                        );
                      } else if (state is Authenticated) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          HomeScreen.route(),
                          (_) => false,
                        );
                      }
                    })
                  ],
                  child: BlocBuilder<ConnectionFormBloc, ConnectionFormState>(
                    builder: (context, connectionState) => Form(
                      child: Column(
                        children: [
                          EmailInput(
                            label: t(context).emailCodeLabelForm,
                            errorMessage: t(context).emailCodeErrorMessage,
                            onValidatedValue: (value) =>
                                context.read<ConnectionFormBloc>().add(
                                      ConnectionEmailFormUpdated(
                                        email: value,
                                      ),
                                    ),
                          ),
                          PasswordInput(
                            label: t(context).passwordCodeLabelForm,
                            errorMessage: t(context).passwordCodeErrorMessage,
                            onValidedValue: (value) =>
                                context.read<ConnectionFormBloc>().add(
                                      ConnectionPasswordFormUpdated(
                                        password: value,
                                      ),
                                    ),
                          ),
                          MainButton(
                            label: t(context)
                                .connectionButtonLabelForm
                                .toUpperCase(),
                            onPressed: () => context
                                .read<ConnectionFormBloc>()
                                .add(ConnectionFormSubmitted()),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
