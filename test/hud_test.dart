import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_hud/src/shared/progress_indicator.dart' as hud;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test default HUD', () {
    final kDefaultHUD = HUD.kDefaultHUD;

    expect(kDefaultHUD.progressIndicator is hud.ProgressIndicator, true);
    expect(kDefaultHUD.color, Colors.black);
    expect(kDefaultHUD.opacity, 0.6);
    expect(kDefaultHUD.label, null);
    expect(kDefaultHUD.labelStyle, null);
    expect(kDefaultHUD.detailLabel, null);
    expect(kDefaultHUD.detailLabelStyle, null);
  });

  test('test custom HUD', () {
    final customHUD = HUD(
      progressIndicator: LinearProgressIndicator(),
      color: Colors.grey,
      opacity: 0.7,
      label: 'Loading...',
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.black,
      ),
      detailLabel: 'Please Wait...',
      detailLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15.0,
        color: Colors.black54,
      ),
    );

    expect(customHUD.progressIndicator is LinearProgressIndicator, true);
    expect(customHUD.color, Colors.grey);
    expect(customHUD.opacity, 0.7);
    expect(customHUD.label, 'Loading...');
    expect(customHUD.labelStyle != null, true);
    expect(customHUD.labelStyle!.fontWeight, FontWeight.bold);
    expect(customHUD.labelStyle!.fontSize, 18.0);
    expect(customHUD.labelStyle!.color, Colors.black);
    expect(customHUD.detailLabel, 'Please Wait...');
    expect(customHUD.detailLabelStyle != null, true);
    expect(customHUD.detailLabelStyle!.fontWeight, FontWeight.normal);
    expect(customHUD.detailLabelStyle!.fontSize, 15.0);
    expect(customHUD.detailLabelStyle!.color, Colors.black54);
  });
}
