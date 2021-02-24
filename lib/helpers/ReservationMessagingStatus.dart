import 'package:flutter/material.dart';
import 'package:services/blocs/reservation/reservation_state.dart';

class ReservationMessagingStatus {
  final Map<ReservationStatus, String> messages;

  const ReservationMessagingStatus(this.messages);

  message(
    ScaffoldState scaffoldState,
    ReservationStatus status,
  ) {
    if (messages.containsKey(status)) {
      scaffoldState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(messages[status]),
          ),
        );
    }
  }
}
