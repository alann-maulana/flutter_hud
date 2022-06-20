import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/src/progress_indicator.dart' as hud;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HTML Progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      const hud.ProgressIndicator(),
    );

    final bodyFinder = find.byType(hud.ProgressIndicator);
    expect(bodyFinder, findsOneWidget);
  });

  testWidgets('IO Android Progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      const hud.ProgressIndicator(),
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
        home: const hud.ProgressIndicator(),
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
