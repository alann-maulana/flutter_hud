import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../html/cancel_button.dart' as cb;

class CancelButton extends StatelessWidget {
  CancelButton({this.onCancel});

  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoButton(
          child: Text('Cancel'),
          onPressed: onCancel,
        ),
      );
    }

    return cb.CancelButton(onCancel: onCancel);
  }
}
