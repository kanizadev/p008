// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:p008/main.dart';

void main() {
  testWidgets('Flutter Examples app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExamplesApp());

    // Verify that the app title is displayed.
    expect(find.text('Flutter Examples'), findsOneWidget);

    // Verify that at least one example item is displayed.
    expect(find.text('Basic Widgets'), findsOneWidget);
    expect(find.text('Navigation'), findsOneWidget);
    expect(find.text('Forms & Input'), findsOneWidget);
  });
}
