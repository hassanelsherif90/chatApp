import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screen/chat_app.dart';
import 'package:chatapp/screen/login_screen.dart';
import 'package:chatapp/screen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SchoralApp());
}

class SchoralApp extends StatelessWidget {
  const SchoralApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginView.id: (context) => const LoginView(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        ChatApp.id: (context) => ChatApp(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginView.id,
    );
  }
}
