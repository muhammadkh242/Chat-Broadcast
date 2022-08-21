import 'dart:io';

import 'package:chatapp/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    File? img,
    bool isLogin,
    BuildContext context,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${result.user!.uid}.jpg');

        await ref.putFile(img!).whenComplete(() {
        });

        final imgUrl = await ref.getDownloadURL();

        FirebaseFirestore.instance
            .collection("users")
            .doc(result.user!.uid)
            .set(
          {
            'username': username,
            'email': email,
            'imageUrl': imgUrl,
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

    } catch (err) {
      print(err);
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
