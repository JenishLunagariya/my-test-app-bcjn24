import "package:test_application/services/auth/auth_provider.dart";
import "package:test_application/services/auth/auth_user.dart";
import 'package:test_application/services/auth/firebase_auth_provider.dart';

class AuthService extends AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() async {
    provider.initialize();
  }

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) {
    return provider.createUser(email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({required String email, required String password}) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
