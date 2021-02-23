import 'package:flutter/material.dart';
import 'package:services/blocs/reservation/reservation_state.dart';

class ReservationMessagingStatus {
  message(ScaffoldState scaffoldState, ReservationStatus status) {
    Map<ReservationStatus, String> messages = {
      ReservationStatus.slugAlreadyExists:
          "L'identifiant que vous avez saisi existe déjà...",
      ReservationStatus.phoneAlreadyExists:
          "Une réservation existe déjà avec ce numéro de téléphone.",
    };

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
