import 'package:app/blocs/bloc.dart';
import 'package:app/helpers/Translate.dart';
import 'package:app/widgets/forms/MainButton.dart';
import 'package:app/widgets/forms/PhoneNumberInput.dart';
import 'package:app/widgets/forms/SlugInput.dart';
import 'package:app/widgets/forms/UsernameInput.dart';
import 'package:app/widgets/topography/BodyText.dart';
import 'package:app/widgets/topography/Headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:services/blocs/bloc.dart';
import 'package:services/blocs/reservation/reservation_bloc.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Headline(
                  text: t(context).reserveAccountTitle,
                ),
                BodyText(
                  text: t(context).reserveAccountText,
                ),
                MultiBlocListener(
                  listeners: [
                    BlocListener<ReservationformBloc, ReservationformState>(
                      listener: (context, state) {
                        print(
                            'ReservationformBloc state listener: ${state.status}');
                        if (state.status == FormzStatus.submissionInProgress) {
                          print('CreateReservation: $state');
                          context.read<ReservationBloc>().add(
                                CreateReservation(
                                  displayName: state.username.value,
                                  slug: state.slug.value,
                                  phoneNumber: state.phoneNumber.value,
                                ),
                              );
                        }
                      },
                    ),
                    BlocListener<ReservationBloc, ReservationState>(
                      listener: (context, state) {
                        print(
                            'ReservationBloc state listener: ${state.status}');

                        if (state.status == ReservationStatus.complete) {
                          _scaffoldState.currentState
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text('Success submit...'),
                              ),
                            );
                        }

                        if (state.status ==
                            ReservationStatus.slugAlreadyExists) {
                          _scaffoldState.currentState
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                    "L'identifiant que vous avez saisi existe déjà..."),
                              ),
                            );
                        }

                        if (state.status ==
                            ReservationStatus.phoneAlreadyExists) {
                          _scaffoldState.currentState
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Une réservation existe déjà avec ce numéro de téléphone"),
                              ),
                            );
                        }
                      },
                    )
                  ],
                  child: Form(
                    child: Column(
                      children: [
                        UsernameInput(
                          label: t(context).usernameLabelForm,
                          errorMessage: t(context).usernameErrorMessage,
                        ),
                        SlugInput(
                          label: t(context).slugLabelForm,
                          errorMessage: t(context).slugErrorMessage,
                        ),
                        PhoneNumberInput(
                          label: t(context).phoneLabelForm,
                          errorMessage: t(context).phoneErrorMessage,
                        ),
                        BlocBuilder<ReservationformBloc, ReservationformState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, stateForm) {
                            return BlocBuilder<ReservationBloc,
                                ReservationState>(
                              builder: (context, state) {
                                return MainButton(
                                  label:
                                      t(context).reserveLabelForm.toUpperCase(),
                                  onPressed: () {
                                    print(stateForm.props);
                                    context
                                        .read<ReservationformBloc>()
                                        .add(FormSubmitted());
                                  },
                                );
                              },
                            );
                          },
                        )
                      ],
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
