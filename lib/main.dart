import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/landing_page.dart';

void main() {
  runApp(const Che2App());
}

class Che2App extends StatelessWidget {
  const Che2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'che2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ko', 'KR'),
      home: const LandingPage(),
    );
  }
}
