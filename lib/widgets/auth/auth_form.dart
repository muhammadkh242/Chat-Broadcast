import 'package:flutter/material.dart';

enum AuthMode { SignUp, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.trySubmit, required this.isLoading})
      : super(key: key);
  final Function trySubmit;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var authMode = AuthMode.Login;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  void _switchAuthMode() {
    if (authMode == AuthMode.Login) {
      setState(() {
        authMode = AuthMode.SignUp;
        _isLogin = false;
      });
    } else {
      setState(() {
        authMode = AuthMode.Login;
        _isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide an email.";
                      }
                      return null;
                    },
                  ),
                  if (authMode == AuthMode.SignUp)
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide a username.";
                        }
                        return null;
                      },
                      controller: usernameController,
                    ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide a password.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            widget.trySubmit(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              usernameController.text.trim(),
                              _isLogin,
                              context,
                            );
                          },
                          child: Text(
                            authMode == AuthMode.Login ? "Login" : "Signup",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        authMode == AuthMode.Login
                            ? "Don't have an account?"
                            : "Already have an account?",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                          authMode == AuthMode.Login ? "Join now" : "Login",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
