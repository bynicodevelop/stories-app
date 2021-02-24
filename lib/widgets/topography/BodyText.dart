import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;

  const BodyText({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
