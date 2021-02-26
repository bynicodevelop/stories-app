import 'package:flutter/material.dart';

class MessagingStatus {
  final Map<String, String> messages;

  MessagingStatus(
    this.messages,
  );

  message(
    ScaffoldState scaffoldState,
    String status,
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
