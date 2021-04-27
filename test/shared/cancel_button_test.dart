import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/src/shared/cancel_button.dart';
import 'package:flutter_hud/src/shared/html/cancel_button.dart' as html;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('IO Android cancel button with "Cancel" text', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(
      CancelButton(),
    );

    final bodyFinder = find.text('Cancel');
    expect(bodyFinder, findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('IO Android cancel button with "onCancel" handler', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    var canceled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CancelButton(
          onCancel: () {
            canceled = true;
          },
        ),
      ),
    );

    final buttonCancelFinder = find.text('Cancel');

    expect(canceled, isFalse);
    expect(buttonCancelFinder, findsOneWidget);

    await tester.tap(buttonCancelFinder);
    expect(canceled, isTrue);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('IO iOS cancel button with "Cancel" text', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    await tester.pumpWidget(
      CancelButton(),
    );

    final bodyFinder = find.text('Cancel');
    expect(bodyFinder, findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('IO iOS cancel button with "onCancel" handler', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    var canceled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CancelButton(
          onCancel: () {
            canceled = true;
          },
        ),
      ),
    );

    final buttonCancelFinder = find.text('Cancel');

    expect(canceled, isFalse);
    expect(buttonCancelFinder, findsOneWidget);

    await tester.tap(buttonCancelFinder);
    expect(canceled, isTrue);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('HTML cancel button with "Cancel" text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      html.CancelButton(),
    );

    final bodyFinder = find.text('Cancel');
    expect(bodyFinder, findsOneWidget);
  });

  testWidgets('HTML cancel button with "onCancel" handler', (
    WidgetTester tester,
  ) async {
    var canceled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: html.CancelButton(
          onCancel: () {
            canceled = true;
          },
        ),
      ),
    );

    final buttonCancelFinder = find.text('Cancel');

    expect(canceled, isFalse);
    expect(buttonCancelFinder, findsOneWidget);

    await tester.tap(buttonCancelFinder);
    expect(canceled, isTrue);
  });
}
