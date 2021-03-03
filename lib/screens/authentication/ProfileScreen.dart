import 'package:app/blocs/profileform/bloc.dart';
import 'package:app/helpers/MessagingStatus.dart';
import 'package:app/helpers/Translate.dart';
import 'package:app/widgets/forms/EmailInput.dart';
import 'package:app/widgets/forms/MainButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:services/blocs/authentication/authentication_bloc.dart';
import 'package:services/blocs/authentication/authentication_state.dart';
import 'package:services/blocs/bloc.dart';
import 'package:services/exceptions/UserRepositoryException.dart';

class ProfileScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ProfileScreen(),
    );
  }

  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final MessagingStatus _messagingStatus = MessagingStatus({
      UserRepositoryException.EMAIL_ALREADY_EXISTS:
          t(context).emailAlreadyExistsErrorMessage,
      UserRepositoryException.REQUIRES_RECENT_LOGIN:
          t(context).authenticationRequiredErrorMessage,
      'PROFIL_UPDATED_WITH_SUCCESS': t(context).profileUpdatedWithSucessMessage
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                print('AuthenticationBloc state: $state');
                if (state is ProfileUpdated) {
                  _messagingStatus.message(
                    _scaffoldKey.currentState,
                    'PROFIL_UPDATED_WITH_SUCCESS',
                  );

                  context
                      .read<ProfileFormBloc>()
                      .add(ProfileFormUpdatedWithSucess());
                } else if (state is AuthenticationErrors) {
                  _messagingStatus.message(
                    _scaffoldKey.currentState,
                    state.errorCode,
                  );

                  context
                      .read<ProfileFormBloc>()
                      .add(ProfileFormUpdatedWithError());
                }
              },
            ),
            BlocListener<ProfileFormBloc, ProfileFormState>(
                listener: (context, state) {
              print("Status form: ${state.status}");

              if (state.status == FormzStatus.submissionInProgress) {
                print("Send form...");
                context
                    .read<AuthenticationBloc>()
                    .add(UpdateEmailProfileEvent(state.email.value));
              }
            })
          ],
          child: BlocBuilder<ProfileFormBloc, ProfileFormState>(
            builder: (context, profileFormState) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        children: [
                          EmailInput(
                            initialValue:
                                state is Authenticated ? state.email : null,
                            helperText:
                                "Le changement d'email aura un impact sur vos identifiants de connexion.",
                            errorMessage: t(context).emailCodeErrorMessage,
                            label: t(context).emailCodeLabelForm,
                            onChanged: (value) => context
                                .read<ProfileFormBloc>()
                                .add(EmailProfileUpdated(email: value)),
                          ),
                          MainButton(
                            label: 'Mettre à jour',
                            onPressed:
                                profileFormState.status == FormzStatus.valid &&
                                        profileFormState.status !=
                                            FormzStatus.submissionInProgress
                                    ? () => context
                                        .read<ProfileFormBloc>()
                                        .add(ProfileFormSubmitted())
                                    : null,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
