import 'package:chatapp/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _submit(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext context,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (isLogin) {
        final result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore.instance
            .collection("users")
            .doc(result.user!.uid)
            .set(
          {
            'username': username,
            'email': email,
          },
        );
      }
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      var message = "please check your credentials";
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print("on catch error");
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: AuthForm(
        isLoading: _isLoading,
        trySubmit: _submit,
      ),
    );
  }
}
