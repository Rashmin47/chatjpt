import 'package:chatjpt/screens/auth.dart';
import 'package:chatjpt/screens/chat.dart';
import 'package:chatjpt/screens/chat_screen.dart';
import 'package:chatjpt/screens/login_screen.dart';
import 'package:chatjpt/screens/registration_screen.dart';
import 'package:chatjpt/screens/splash.dart';
import 'package:chatjpt/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
        routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        },
        title: 'ChatJPT',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder:  (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if(snapshot.hasData) {
            return ChatScreen1();
          }
          return const AuthScreen();
        }

        ),
    );
  }
}