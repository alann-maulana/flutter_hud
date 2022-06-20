import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Default Popup HUD', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('This is body'),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                final popup = PopupHUD(context);
                await popup.show();
              },
              child: const Icon(Icons.refresh),
            );
          }),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    expect(bodyFinder, findsOneWidget);

    final fabFinder = find.byIcon(Icons.refresh);
    await tester.tap(fabFinder);
    await tester.pump();

    final progressFinder = find.byType(CircularProgressIndicator);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Popup HUD indicator only', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('This is body'),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                final popup = PopupHUD(
                  context,
                  hud: HUD(
                    progressIndicator: const CircularProgressIndicator(),
                  ),
                );
                await popup.show();
              },
              child: const Icon(Icons.refresh),
            );
          }),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    expect(bodyFinder, findsOneWidget);

    final fabFinder = find.byIcon(Icons.refresh);
    await tester.tap(fabFinder);
    await tester.pump();

    final progressFinder = find.byType(CircularProgressIndicator);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Popup HUD with label', (WidgetTester tester) async {
    late PopupHUD popup;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('This is body'),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                popup = PopupHUD(
                  context,
                  hud: HUD(
                    progressIndicator: const CircularProgressIndicator(),
                    label: 'Loading..',
                  ),
                );
                await popup.show();
              },
              child: const Icon(Icons.refresh),
            );
          }),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    expect(bodyFinder, findsOneWidget);

    final fabFinder = find.byIcon(Icons.refresh);
    await tester.tap(fabFinder);
    await tester.pump();

    final progressFinder = find.byType(CircularProgressIndicator);
    final labelFinder = find.text('Loading..');
    expect(progressFinder, findsOneWidget);
    expect(labelFinder, findsOneWidget);

    expect(popup.label, 'Loading..');
    popup.setLabel('Done');
    await tester.pump();
    expect(popup.label, 'Done');
  });

  testWidgets('Popup HUD with label and detail', (WidgetTester tester) async {
    late PopupHUD popup;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('This is body'),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                popup = PopupHUD(
                  context,
                  hud: HUD(
                    progressIndicator: const CircularProgressIndicator(),
                    label: 'Loading..',
                    detailLabel: 'Please wait',
                  ),
                );
                await popup.show();
              },
              child: const Icon(Icons.refresh),
            );
          }),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    expect(bodyFinder, findsOneWidget);

    final fabFinder = find.byIcon(Icons.refresh);
    await tester.tap(fabFinder);
    await tester.pump();

    var progressFinder = find.byType(CircularProgressIndicator);
    var labelFinder = find.text('Loading..');
    var detailFinder = find.text('Please wait');
    expect(progressFinder, findsOneWidget);
    expect(labelFinder, findsOneWidget);
    expect(detailFinder, findsOneWidget);

    expect(popup.detailLabel, 'Please wait');
    popup.setDetailLabel('OK');
    await tester.pump();
    expect(popup.detailLabel, 'OK');

    popup.dismiss();
    await tester.pump();

    progressFinder = find.byType(CircularProgressIndicator);
    labelFinder = find.text('Loading..');
    detailFinder = find.text('OK');
    expect(progressFinder, findsNothing);
    expect(labelFinder, findsNothing);
    expect(detailFinder, findsNothing);
  });

  testWidgets('Popup HUD cancelable', (WidgetTester tester) async {
    var canceled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('This is body'),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () async {
                final popup = PopupHUD(
                  context,
                  hud: HUD(
                    progressIndicator: const CircularProgressIndicator(),
                  ),
                  onCancel: () {
                    canceled = true;
                  },
                );
                await popup.show();
              },
              child: const Icon(Icons.refresh),
            );
          }),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    expect(bodyFinder, findsOneWidget);

    final fabFinder = find.byIcon(Icons.refresh);
    await tester.tap(fabFinder);
    await tester.pump();

    final progressFinder = find.byType(CircularProgressIndicator);
    expect(progressFinder, findsOneWidget);

    final cancelButtonFinder = find.text('Cancel');
    expect(cancelButtonFinder, findsOneWidget);
    expect(canceled, isFalse);

    await tester.tap(cancelButtonFinder);
    await tester.pump();

    expect(canceled, isTrue);
  });

  testWidgets('Popup HUD progress', (WidgetTester tester) async {
    late PopupHUD popup;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('This is body'),
          floatingActionButton: Builder(builder: (context) {
            popup = PopupHUD(
              context,
              hud: HUD(
                progressIndicator: const CircularProgressIndicator(),
              ),
            );
            return FloatingActionButton(
              onPressed: () async {
                await popup.show();
              },
              child: const Icon(Icons.exposure_plus_1),
            );
          }),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    expect(bodyFinder, findsOneWidget);

    final fab1Finder = find.byIcon(Icons.exposure_plus_1);
    await tester.tap(fab1Finder);
    await tester.pump();

    final progressFinder = find.byType(CircularProgressIndicator);
    expect(progressFinder, findsOneWidget);
    expect(popup.value, isNull);

    popup.setValue(0.5);

    expect(popup.value, isNotNull);
  });
}
