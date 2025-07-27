import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // ⬅️ must be generated via flutterfire CLI
import 'Citizens/SigInPage.dart'; // or RegisterPage depending on where you start

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuzzOff',
      theme: ThemeData.dark(), // or your custom theme
      debugShowCheckedModeBanner: false,
      home: const SignInPage(), // or RegisterPage for testing
    );
  }
}
