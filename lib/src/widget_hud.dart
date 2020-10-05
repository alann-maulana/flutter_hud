import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/src/helper.dart';
import 'package:flutter_hud/src/hud.dart';
import 'package:flutter_hud/src/shared/cancel_button.dart';

/// Class for managing progress HUD widget
// ignore: must_be_immutable
class WidgetHUD extends StatelessWidget {
  /// Initialize [WidgetHUD]
  WidgetHUD({
    @required this.builder,
    this.onCancel,
    this.showHUD = false,
    this.value,
    HUD hud,
  })  : assert(builder != null),
        hud = hud ??= HUD.kDefaultHUD;

  /// The template of [WidgetHUD]
  final HUD hud;

  /// Set [onCancel] to enable canceling process and dismissing progress HUD
  final VoidCallback onCancel;

  /// The main body of [Widget] to display
  final WidgetBuilder builder;

  /// Flag to showing progress HUD
  final bool showHUD;

  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  ///
  /// If null, this progress indicator is indeterminate, which means the
  /// indicator displays a predetermined animation that does not indicate how
  /// much actual progress is being made.
  final double value;

  @override
  Widget build(BuildContext context) {
    if (!showHUD) {
      return builder(context);
    }

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        builder(context),
        Container(
          color: hud.color.withOpacity(hud.opacity),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (onCancel != null) SizedBox(height: 32),
                Container(
                  constraints: BoxConstraints(maxWidth: size.width * 0.6),
                  child: showOrUpdateProgressIndicator(hud, value),
                ),
                if (hud.label != null || hud.detailLabel != null)
                  SizedBox(height: 8),
                if (hud.label != null) SizedBox(height: 8),
                if (hud.label != null)
                  Text(
                    hud.label,
                    style: hud.labelStyle ??
                        textTheme.headline6.copyWith(color: Colors.white),
                  ),
                if (hud.detailLabel != null) SizedBox(height: 4),
                if (hud.detailLabel != null)
                  Text(
                    hud.detailLabel,
                    style: hud.detailLabelStyle ??
                        textTheme.subtitle2.copyWith(color: Colors.white70),
                  ),
                if (onCancel != null) SizedBox(height: 16),
                if (onCancel != null) CancelButton(onCancel: onCancel),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
