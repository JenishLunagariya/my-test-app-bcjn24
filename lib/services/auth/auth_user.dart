import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

class AuthUser {
  final String? email;
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified, required this.email});

  @immutable
  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email,
        isEmailVerified: user.emailVerified,
      );
}
