import 'package:app/blocs/reservationform/bloc.dart';
import 'package:app/helpers/MessagingStatus.dart';
import 'package:app/helpers/Translate.dart';
import 'package:app/screens/authentication/ConnexionScreen.dart';
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

class ReservationScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
        builder: (context) => ReservationScreen(),
      );

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  ReservationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                ConnectionScreen.route(),
              ),
              child: Icon(
                Icons.person,
                size: 26.0,
                color: Colors.transparent,
              ),
            ),
          )
        ],
      ),
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

                        MessagingStatus messagingStatus = MessagingStatus({
                          ReservationStatus.slugAlreadyExists.toString():
                              t(context).slugAlreadyExistsErrorMessage,
                          ReservationStatus.phoneAlreadyExists.toString():
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

                        messagingStatus.message(
                          _scaffoldState.currentState,
                          state.status.toString(),
                        );

                        context
                            .read<ReservationformBloc>()
                            .add(SubmissionFailure());
                      },
                    )
                  ],
                  child: BlocBuilder<ReservationformBloc, ReservationformState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, stateForm) {
                        return BlocBuilder<ReservationBloc, ReservationState>(
                            builder: (context, state) {
                          print('stateForm: ${stateForm.status}');
                          return Form(
                              child: Column(
                            children: [
                              UsernameInput(
                                label: t(context).usernameLabelForm,
                                errorMessage: t(context).usernameErrorMessage,
                                onChanged: (value) =>
                                    context.read<ReservationformBloc>().add(
                                          UsernameFormChanged(username: value),
                                        ),
                              ),
                              SlugInput(
                                label: t(context).slugLabelForm,
                                errorMessage: t(context).slugErrorMessage,
                                onChanged: (value) =>
                                    context.read<ReservationformBloc>().add(
                                          SlugFormChanged(slug: value),
                                        ),
                              ),
                              PhoneNumberInput(
                                label: t(context).phoneLabelForm,
                                errorMessage: t(context).phoneErrorMessage,
                                onChanged: (value) =>
                                    context.read<ReservationformBloc>().add(
                                          PhoneNumberFormChanged(
                                              phoneNumber: value),
                                        ),
                              ),
                              MainButton(
                                label:
                                    t(context).reserveLabelForm.toUpperCase(),
                                onPressed: stateForm.status ==
                                        FormzStatus.submissionInProgress
                                    ? null
                                    : () {
                                        context
                                            .read<ReservationformBloc>()
                                            .add(FormSubmitted());
                                      },
                              ),
                            ],
                          ));
                        });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
