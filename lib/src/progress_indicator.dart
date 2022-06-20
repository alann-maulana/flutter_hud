import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const CupertinoTheme(
          data: CupertinoThemeData(
            brightness: Brightness.dark,
          ),
          child: CupertinoActivityIndicator(radius: 20),
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        break;
    }

    return const CircularProgressIndicator();
  }
}
