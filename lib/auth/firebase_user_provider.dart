import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HealthcareFirebaseUser {
  HealthcareFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

HealthcareFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HealthcareFirebaseUser> healthcareFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<HealthcareFirebaseUser>(
            (user) => currentUser = HealthcareFirebaseUser(user));
