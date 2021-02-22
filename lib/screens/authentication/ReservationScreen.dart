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
      body: SingleChildScrollView(
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
              BlocListener<ReservationformBloc, ReservationformState>(
                listener: (context, state) {
                  print('state listener: ${state.status}');
                  if (state.status == FormzStatus.submissionSuccess) {
                    _scaffoldState.currentState
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('Success submit...'),
                        ),
                      );
                  }
                },
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
                        builder: (context, state) {
                          print('Submit: ${state.status}');
                          return MainButton(
                            label: t(context).reserveLabelForm.toUpperCase(),
                            onPressed:
                                state.status == FormzStatus.submissionInProgress
                                    ? null
                                    : () => context
                                        .read<ReservationformBloc>()
                                        .add(FormSubmitted()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
