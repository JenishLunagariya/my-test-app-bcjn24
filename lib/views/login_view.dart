import 'package:firebase_auth/firebase_auth.dart'; // firebase authenticate
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:test_application/firebase_options.dart'; // firebase initialize

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login View"),),
      body: Column(
        children: [
          TextField(
            controller: _email,
            // enableSuggestions: false,
            // autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: _password,
            obscureText: true, // makes password invisible
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: password);
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == "invalid-credential") {
                  print("Invalid Email or Password");
                } else if (e.code == "wrong-password") {
                  print("Wrong Password");
                } else {
                  print("Something Bad Happened");
                  print(e.code);
                }
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: const Text("Not Registered yet? Register here!"))
        ],
      ),
    );
  }
}
