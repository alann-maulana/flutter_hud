import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  CancelButton({this.onCancel});

  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextButton(
        child: Text('Cancel'),
        style: flatButtonStyle,
        onPressed: onCancel,
      ),
    );
  }
}
