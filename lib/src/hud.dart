import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class for managing progress HUD template
class HUD {
  /// Initialize progress HUD tempalte
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

  /// The global default template for generating progress HUD
  static HUD kDefaultHUD = HUD();

  /// The background color of progress HUD to display
  final Color color;

  /// The background opacity of [color] HUD to display
  final double opacity;

  /// The label displayed below [progressIndicator]
  final String label;

  /// The [TextStyle] used by [label]
  final TextStyle labelStyle;

  /// The detail label displayed below [label]
  final String detailLabel;

  /// The [TextStyle] used by [detailLabel]
  final TextStyle detailLabelStyle;

  /// The widget used by progress HUD
  final Widget progressIndicator;
}
