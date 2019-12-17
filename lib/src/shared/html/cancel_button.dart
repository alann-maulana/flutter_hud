import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  CancelButton({this.onCancel});

  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FlatButton(
        child: Text('Cancel'),
        textTheme: ButtonTextTheme.primary,
        onPressed: onCancel,
      ),
    );
  }
}
