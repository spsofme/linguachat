import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linguachat/firebase_options.dart';
import 'package:linguachat/screens/chat_screen/chat_screen.dart';
import 'package:linguachat/screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomeScreen(),
        // '/login': (BuildContext context) => const LoginScreen(),
        // '/settings': (BuildContext context) => const SettingsScreen(),
        '/chat': (BuildContext context) => const ChatScreen(),
      },
    );
  }
}
