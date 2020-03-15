// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:conditional_wrapper_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ConditionalWrapperHome());

    expect(find.text('Unwrapped'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.byKey(containerKey), findsNothing);

    // Tap the switch.
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.text('Unwrapped'), findsNothing);
    expect(find.text('Wrapped'), findsOneWidget);
    expect(find.byKey(containerKey), findsOneWidget);
  });
}
