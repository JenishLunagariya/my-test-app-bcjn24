import 'package:flutter/material.dart';
import 'package:test_application/constants/routes.dart';
import 'package:test_application/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify your account."),
          const SizedBox(),
          TextButton(
              onPressed: () async {
                await AuthService.firebase()
                    .sendEmailVerification(); // send email verification
              },
              child: const Text(
                  "Didn't get verification email? Send email verification")),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (context) => false,
              );
            },
            child: const Text("Back"),
          )
        ],
      ),
    );
  }
}
