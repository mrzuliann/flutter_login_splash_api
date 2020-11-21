import 'package:flutter/material.dart';
import 'package:signup_ui/Screens/DashboardScreen.dart';
import 'package:signup_ui/Screens/SplashScreen.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/SignUPScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Screen ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: 'Splash',
      routes: {
        'Dashboard': (context) => DashboardScreen(),
        'SignIn': (context) => SignInScreen(),
        'SignUp': (context) => SignUpScreen(),
        'Splash': (context) => SplashScreen(),
      },
    );
  }
}
