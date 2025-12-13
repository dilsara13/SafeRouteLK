// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saferoute_lk/presentation/providers/ui_provider.dart';
import 'package:saferoute_lk/presentation/screens/home_screen.dart';

void main() {
  runApp(const SafeRouteLKApp());
}

class SafeRouteLKApp extends StatelessWidget {
  const SafeRouteLKApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UIProvider(),
      child: MaterialApp(
        title: 'SafeRouteLK - AI Safety Assistant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2A5C82),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          fontFamily: 'Inter',
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
