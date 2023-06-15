import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:safarirally2023/providers/auth_provider.dart';
import 'package:safarirally2023/providers/location_provider.dart';
import 'package:safarirally2023/screens/main_screen.dart';
import 'package:safarirally2023/screens/login_screen.dart';
import 'package:safarirally2023/screens/register_screen.dart';
import 'package:safarirally2023/screens/splash_screen.dart';
import 'package:safarirally2023/widgets/map_widget.dart';
import 'firebase_options.dart';
import 'screens/reset_password_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => LocationProvider())
          ],
          child: const MyApp())
  );
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
      builder: EasyLoading.init(),
      routes: {
        SplashScreen.id:(context) => const SplashScreen(),
        MainScreen.id:(context) => const MainScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
        RegisterScreen.id:(context) => const RegisterScreen(),
        ResetPassword.id:(context) => const ResetPassword(),
        RallyStageMap.id:(context) => const RallyStageMap(stage: null),
      },
    );
  }
}