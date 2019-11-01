import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HUD {
  HUD({
    Widget progressIndicator,
    this.color = Colors.black,
    this.opacity = 0.6,
    this.label,
    this.labelStyle,
    this.detailLabel,
    this.detailLabelStyle,
  })  : assert(opacity >= 0.0 && opacity <= 1.0),
        progressIndicator = progressIndicator ??=
            (Platform.isIOS || Platform.isMacOS
                ? const CupertinoActivityIndicator(radius: 20)
                : const CircularProgressIndicator());

  static HUD kDefaultHUD = HUD();

  final Color color;
  final double opacity;
  final String label;
  final TextStyle labelStyle;
  final String detailLabel;
  final TextStyle detailLabelStyle;
  final Widget progressIndicator;
}
