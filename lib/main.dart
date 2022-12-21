import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tely_challenge/views/login_page.dart';

void main() => runApp(const ProviderScope(child: TelyChallengeApp()));

class TelyChallengeApp extends StatelessWidget {
  const TelyChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tely Pay Flutter Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.red,
      ),
      home: const LoginPage(),
    );
  }
}
