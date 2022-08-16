import 'package:chatapp/screens/auth_screen.dart';
import 'package:chatapp/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/screens/chats_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.teal,

      ),
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot){
          if(userSnapshot.hasData){
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
