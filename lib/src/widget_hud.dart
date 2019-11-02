import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/src/hud.dart';

// ignore: must_be_immutable
class WidgetHUD extends StatelessWidget {
  WidgetHUD({
    @required this.builder,
    this.onCancel,
    this.showHUD = false,
    HUD hud,
  })  : assert(builder != null),
        hud = hud ??= HUD.kDefaultHUD;

  final HUD hud;
  final VoidCallback onCancel;
  final WidgetBuilder builder;
  final bool showHUD;

  @override
  Widget build(BuildContext context) {
    if (!showHUD) {
      return builder(context);
    }

    final textTheme = Theme.of(context).textTheme;

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
                hud.progressIndicator,
                if (hud.label != null || hud.detailLabel != null)
                  SizedBox(height: 8),
                if (hud.label != null) SizedBox(height: 8),
                if (hud.label != null)
                  Text(
                    hud.label,
                    style: hud.labelStyle ??
                        textTheme.title.copyWith(color: Colors.white),
                  ),
                if (hud.detailLabel != null) SizedBox(height: 4),
                if (hud.detailLabel != null)
                  Text(
                    hud.detailLabel,
                    style: hud.detailLabelStyle ??
                        textTheme.subtitle.copyWith(color: Colors.white70),
                  ),
                if (onCancel != null) SizedBox(height: 16),
                if (onCancel != null)
                  (Platform.isIOS || Platform.isMacOS)
                      ? CupertinoButton(
                          child: Text('Cancel'),
                          onPressed: onCancel,
                        )
                      : FlatButton(
                          child: Text('Cancel'),
                          textTheme: ButtonTextTheme.primary,
                          onPressed: onCancel,
                        ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
