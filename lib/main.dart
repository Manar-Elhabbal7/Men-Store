import 'package:flutter/material.dart';
import 'features/auth/login/login_screen.dart';

void main() {
  runApp(const MenStore());
}

class MenStore extends StatelessWidget {
  const MenStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MenStore',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}
