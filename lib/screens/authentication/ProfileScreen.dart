import 'package:app/blocs/emailinput/bloc.dart';
import 'package:app/blocs/profileform/bloc.dart';
import 'package:app/helpers/Translate.dart';
import 'package:app/widgets/forms/EmailInput.dart';
import 'package:app/widgets/forms/MainButton.dart';
import 'package:app/widgets/forms/PasswordInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:services/blocs/authentication/authentication_bloc.dart';
import 'package:services/blocs/authentication/authentication_state.dart';

class ProfileScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ProfileScreen(),
    );
  }

  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileFormBloc, ProfileFormState>(
          builder: (context, profileFormState) {
            print('profileFormState.status: ${profileFormState.status}');
            return BlocListener<ProfileFormBloc, ProfileFormState>(
              listener: (context, state) {
                if (state.status == FormzStatus.submissionInProgress) {
                  // TODO: Envoie du formulaire
                }
              },
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
                            initialValue: (state as Authenticated).email,
                            helperText:
                                "Le changement d'email aura un impact sur vos identifiants de connexion.",
                            errorMessage: t(context).emailCodeErrorMessage,
                            label: t(context).emailCodeLabelForm,
                            onValidatedValue: (value) => context
                                .read<ProfileFormBloc>()
                                .add(EmailProfileUpdated(email: value)),
                          ),
                          MainButton(
                            label: 'Mettre à jour',
                            onPressed:
                                profileFormState.status == FormzStatus.valid
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
              ),
            );
          },
        ),
      ),
    );
  }
}
