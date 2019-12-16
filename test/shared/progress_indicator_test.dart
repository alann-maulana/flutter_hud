import 'package:flutter_hud/src/shared/progress_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProgressIndicator(),
    );

    final bodyFinder = find.byType(ProgressIndicator);
    expect(bodyFinder, findsOneWidget);
  });
}
