// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:saferoute_lk/main.dart';
import 'package:saferoute_lk/presentation/providers/ui_provider.dart';

class EmergencyProvider extends ChangeNotifier {
}

class ChatbotProvider extends ChangeNotifier {
}

void main() {
  testWidgets('SafeRoute app loads and displays home screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UIProvider()),
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => EmergencyProvider()),
          ChangeNotifierProvider(create: (_) => ChatbotProvider()),
        ],
        child: const SafeRouteLKApp(),
      ),
    );

    // Wait for the first frame to render
    await tester.pump(const Duration(seconds: 2));

    // Verify that the app displays the correct widget tree
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

class LocationProvider extends ChangeNotifier {
}
