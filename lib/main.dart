import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safarirally2023/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safari Rally 2023',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        fontFamily: "Lato",
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context) => const SplashScreen(),
      },
    );
  }
}