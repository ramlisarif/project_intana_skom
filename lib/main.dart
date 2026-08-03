import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_intana_skom/firebase_option.dart';
import 'package:project_intana_skom/views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SERTAKAN OPTIONS DI SINI (Wajib untuk Windows)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal KBM Guru',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF1D4ED8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1D4ED8),
        ),
      ),
      home: const LoginPage(),
    );
  }
}