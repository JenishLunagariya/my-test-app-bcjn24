import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

class AuthUser {
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified});

  @immutable
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}
