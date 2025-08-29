// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:footyfinds/main.dart';

void main() {
  testWidgets('FutFinds app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FutFindsApp());

    // Verify that the app title is displayed
    expect(find.text('FutFinds'), findsOneWidget);

    // Verify that the three main tabs are present
    expect(find.text('Fields'), findsOneWidget);
    expect(find.text('Pick-ups'), findsOneWidget);
    expect(find.text('Create-a-Match'), findsOneWidget);

    // Verify that the app starts on the Fields tab
    expect(find.text('Central Park Soccer Field'), findsOneWidget);
  });

  testWidgets('Tab navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FutFindsApp());

    // Tap on the Pick-ups tab
    await tester.tap(find.text('Pick-ups'));
    await tester.pumpAndSettle();

    // Verify that pickup games are displayed
    expect(find.text('Central Park Soccer Field'), findsOneWidget);
    expect(find.text('Sign Up'), findsWidgets);

    // Tap on the Create-a-Match tab
    await tester.tap(find.text('Create-a-Match'));
    await tester.pumpAndSettle();

    // Verify that the create match form is displayed
    expect(find.text('Where will the game take place?'), findsOneWidget);
  });
}
