import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_hud/src/helper.dart';
import 'package:flutter_hud/src/progress_indicator.dart' as hud;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test default HUD + value == null', () {
    final widget = showOrUpdateProgressIndicator(HUD.kDefaultHUD, null);

    expect(widget is hud.ProgressIndicator, true);
  });

  test('test default HUD + value != null', () {
    final widget = showOrUpdateProgressIndicator(HUD.kDefaultHUD, 0.1);

    expect(
      widget is CircularProgressIndicator ||
          widget is CupertinoActivityIndicator,
      true,
    );
  });

  test('test custom HUD', () {
    final widget = showOrUpdateProgressIndicator(
      HUD(progressIndicator: const CupertinoActivityIndicator()),
      null,
    );

    expect(widget is CupertinoActivityIndicator, true);

    final widget2 = showOrUpdateProgressIndicator(
      HUD(progressIndicator: const CupertinoActivityIndicator()),
      0.2,
    );

    expect(widget2 is CupertinoActivityIndicator, false);
    expect(widget2 is CircularProgressIndicator, true);
  });

  test('test custom HUD + value != null', () {
    final widget = showOrUpdateProgressIndicator(
      HUD(progressIndicator: const LinearProgressIndicator()),
      0.1,
    );

    expect(widget is hud.ProgressIndicator, false);
    expect(widget is LinearProgressIndicator, true);
  });
}
