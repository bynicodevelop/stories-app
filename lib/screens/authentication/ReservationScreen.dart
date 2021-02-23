import 'package:app/blocs/bloc.dart';
import 'package:app/helpers/ReservationMessagingStatus.dart';
import 'package:app/helpers/Translate.dart';
import 'package:app/screens/authentication/EndReservationScreen.dart';
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
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

                        ReservationMessagingStatus reservationMessagingStatus =
                            ReservationMessagingStatus({
                          ReservationStatus.slugAlreadyExists:
                              t(context).slugAlreadyExistsErrorMessage,
                          ReservationStatus.phoneAlreadyExists:
                              t(context).phoneAlreadyExistsErrorMessage,
                        });

                        if (state.status == ReservationStatus.complete) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EndReservationScreen(),
                            ),
                            (_) => false,
                          );
                        }

                        reservationMessagingStatus.message(
                          _scaffoldState.currentState,
                          state.status,
                        );
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
