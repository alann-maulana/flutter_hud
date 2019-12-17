import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator();

  @override
  Widget build(BuildContext context) {
    if ((Platform.isIOS || Platform.isMacOS) &&
        Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
        ),
        child: CupertinoActivityIndicator(radius: 20),
      );
    }
    return CircularProgressIndicator();
  }
}
