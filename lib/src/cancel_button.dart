import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key, this.onCancel}) : super(key: key);

  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return Directionality(
          textDirection: TextDirection.ltr,
          child: CupertinoButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        break;
    }

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextButton(
        style: flatButtonStyle,
        onPressed: onCancel,
        child: const Text('Cancel'),
      ),
    );
  }
}
