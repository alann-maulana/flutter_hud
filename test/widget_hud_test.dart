import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Default HUD not shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      WidgetHUD(
        builder: (BuildContext context, Widget? child) => child!,
        child: const MaterialApp(home: Text('This is body')),
      ),
    );

    final bodyFinder = find.text('This is body');
    expect(bodyFinder, findsOneWidget);
  });

  testWidgets('Default HUD shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WidgetHUD(
          builder: (BuildContext context, Widget? child) => child!,
          showHUD: true,
          child: const Text('This is body'),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    final progressFinder = find.byType(CupertinoActivityIndicator);
    final progressFinder2 = find.byType(CircularProgressIndicator);

    expect(bodyFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget, skip: true);
    expect(progressFinder2, findsOneWidget, skip: true);
  });

  testWidgets('CircularProgressIndicator HUD shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WidgetHUD(
          hud: HUD(progressIndicator: const CircularProgressIndicator()),
          builder: (BuildContext context, Widget? child) => child!,
          showHUD: true,
          child: const Text('This is body'),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    final progressFinder = find.byType(CircularProgressIndicator);

    expect(bodyFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('CupertinoActivityIndicator HUD shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WidgetHUD(
          hud: HUD(progressIndicator: const CupertinoActivityIndicator()),
          builder: (BuildContext context, Widget? child) => child!,
          showHUD: true,
          child: const Text('This is body'),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    final progressFinder = find.byType(CupertinoActivityIndicator);

    expect(bodyFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('CircularProgressIndicator HUD with title shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WidgetHUD(
          hud: HUD(
            progressIndicator: const CircularProgressIndicator(),
            label: 'Loading...',
          ),
          builder: (BuildContext context, Widget? child) => child!,
          showHUD: true,
          child: const Text('This is body'),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    final labelFinder = find.text('Loading...');
    final progressFinder = find.byType(CircularProgressIndicator);

    expect(bodyFinder, findsOneWidget);
    expect(labelFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('CircularProgressIndicator HUD with title and detail shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WidgetHUD(
          hud: HUD(
            progressIndicator: const CircularProgressIndicator(),
            label: 'Loading...',
            detailLabel: 'Please wait',
          ),
          builder: (BuildContext context, Widget? child) => child!,
          showHUD: true,
          child: const Text('This is body'),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    final labelFinder = find.text('Loading...');
    final detailFinder = find.text('Please wait');
    final progressFinder = find.byType(CircularProgressIndicator);

    expect(bodyFinder, findsOneWidget);
    expect(labelFinder, findsOneWidget);
    expect(detailFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('CircularProgressIndicator HUD with cancelation shown', (WidgetTester tester) async {
    var canceled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: WidgetHUD(
          hud: HUD(
            progressIndicator: const CircularProgressIndicator(),
          ),
          onCancel: () {
            canceled = true;
          },
          builder: (BuildContext context, Widget? child) => child!,
          showHUD: true,
          child: const Text('This is body'),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    final progressFinder = find.byType(CircularProgressIndicator);
    final buttonCancelFinder = find.text('Cancel');

    expect(canceled, isFalse);
    expect(bodyFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
    expect(buttonCancelFinder, findsOneWidget);

    await tester.tap(buttonCancelFinder);
    expect(canceled, isTrue);
  });

  double? value;
  testWidgets('CircularProgressIndicator HUD with label and progress shown', (WidgetTester tester) async {
    late StateSetter setStater;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              setStater = setState;
              return WidgetHUD(
                hud: HUD(
                  progressIndicator: const CircularProgressIndicator(),
                  label: value == null ? 'Initializing' : 'Processing',
                ),
                value: value,
                builder: (BuildContext context, Widget? child) => child!,
                showHUD: true,
                child: const Text('This is body'),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setStater(() {
                value = 0.5;
              });
            },
            child: const Icon(Icons.refresh),
          ),
        ),
      ),
    );

    final bodyFinder = find.text('This is body');
    final progressFinder = find.byType(CircularProgressIndicator);
    final labelFinder = find.text('Initializing');
    final buttonFinder = find.byIcon(Icons.refresh);

    expect(value, isNull);
    expect(bodyFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
    expect(labelFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();
    expect(value, isNotNull);
    expect(labelFinder, findsNothing);

    final labelFinder2 = find.text('Processing');
    expect(labelFinder2, findsOneWidget);
  });
}
