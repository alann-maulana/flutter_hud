import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/src/shared/html/progress_indicator.dart' as html;
import 'package:flutter_hud/src/shared/progress_indicator.dart' as hud;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HTML Progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      html.ProgressIndicator(),
    );

    final bodyFinder = find.byType(html.ProgressIndicator);
    expect(bodyFinder, findsOneWidget);
  });

  testWidgets('IO Android Progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      hud.ProgressIndicator(),
    );

    final bodyFinder = find.byType(hud.ProgressIndicator);
    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);
    expect(bodyFinder, findsOneWidget);
    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('IO iOS Progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.iOS),
        home: hud.ProgressIndicator(),
      ),
    );

    final bodyFinder = find.byType(hud.ProgressIndicator);
    final cupertinoThemeFinder = find.byType(CupertinoTheme);
    final cupertinoActivityIndicatorFinder =
        find.byType(CupertinoActivityIndicator);

    expect(bodyFinder, findsOneWidget);
    expect(cupertinoThemeFinder, findsWidgets);
    expect(cupertinoActivityIndicatorFinder, findsOneWidget, skip: true);
  });
}
