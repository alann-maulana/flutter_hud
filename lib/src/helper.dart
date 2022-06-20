import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

Widget showOrUpdateProgressIndicator(HUD hud, double? value) {
  if (value == null) {
    return hud.progressIndicator;
  }

  if (hud.progressIndicator is CircularProgressIndicator) {
    CircularProgressIndicator old =
        hud.progressIndicator as CircularProgressIndicator;
    return CircularProgressIndicator(
      key: old.key,
      value: value,
      backgroundColor: old.backgroundColor,
      semanticsLabel: old.semanticsLabel,
      semanticsValue: old.semanticsValue,
      strokeWidth: old.strokeWidth,
      valueColor: old.valueColor,
    );
  }

  if (hud.progressIndicator is LinearProgressIndicator) {
    LinearProgressIndicator old =
        hud.progressIndicator as LinearProgressIndicator;
    return LinearProgressIndicator(
      key: old.key,
      value: value,
      backgroundColor: old.backgroundColor,
      semanticsLabel: old.semanticsLabel,
      semanticsValue: old.semanticsValue,
      valueColor: old.valueColor,
    );
  }

  return CircularProgressIndicator(
    value: value,
  );
}
