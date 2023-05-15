// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smakowa/main.dart';
import 'package:smakowa/pages/home/home_page.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyHomePage());

    // Verify that our counter starts at 0.
    expect(find.byIcon(Icons.home), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(
        find.widgetWithImage(
            HomePage,
            const NetworkImage(
                'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=556,505')),
        findsNothing);
  });
}

// void myhomePage() {
//   testWidgets('Recipe list dipslay test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyHomePage());

//     // Verify that our counter starts at 0.
//     expect(find.byIcon(Icons.home), findsOneWidget);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.home));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(
//         find.widgetWithImage(
//             HomePage,
//             const NetworkImage(
//                 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=556,505')),
//         findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
