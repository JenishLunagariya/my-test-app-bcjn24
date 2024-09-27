import 'package:test/test.dart';
import 'package:test_application/services/auth/auth_exceptions.dart';
import 'package:test_application/services/auth/auth_provider.dart';
import 'package:test_application/services/auth/auth_user.dart';

void main() {
  group("Mock Authentication", () {
    final provider = MockAuthProvider();

    test('should not be implemented', () {
      expect(provider._isInitialized, false);
    });
    test("cannot logout without login", () {
      expect(provider.logOut(),
          throwsA(const TypeMatcher<NotInitializedException>()));
    });
    test("should be initialiazed", () async{
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test("User should be null after initialization", () {
      expect(provider.currentUser, null);
    });
    test(
      "should be able to initialize in less than 2 sec",
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
    test("Create user should delegate to logIn function", () async {
      final badEmailUser = provider.createUser(
        email: "foo@bar.com",
        password: "whatever",
      );
      expect(badEmailUser, throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser = provider.createUser(
        email: "some@one.com",
        password: "12121212",
      );
      expect(
          badPasswordUser, throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(
        email: "foo",
        password: "bar",
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test("Login user should be able to verified", () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test("should be able to logout and login again", () async {
      await provider.logOut();
      expect(provider.currentUser, null);
      await provider.logIn(email: "foo", password: "bar");
      expect(provider.currentUser, isNotNull);
    });
  });
}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == '12121212') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}

class NotInitializedException implements Exception {}
