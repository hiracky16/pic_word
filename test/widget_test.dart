// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pic_word/main.dart';

void main() {
  testWidgets('flutter_app sample test!', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();

  expect(find.text('Apple:200円'), findsOneWidget);
  expect(find.byIcon(Icons.star), findsOneWidget);
  });
}
