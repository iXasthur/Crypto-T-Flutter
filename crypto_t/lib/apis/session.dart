import 'package:crypto_t/models/crypto_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Session {
  Session._internal(); // Private constructor

  static final Session shared = Session._internal();

  CryptoDashboard? _dashboard = null;

  bool _initialized = false;

  void _initialize(Function() onCompleted) {
    _dashboard = CryptoDashboard();

    // syncDashboard(() =>
    // {
    _initialized = true;
    onCompleted();
    // });
  }

  void destroy(Function() onCompleted) async {
    _initialized = false;
    await FirebaseAuth.instance.signOut();
    _dashboard = null;
    onCompleted();
  }

  void restore(Function(Exception?) completion) {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _initialize(() => completion(null));
    } else {
      completion(Exception("User not signed in"));
    }
  }

  void signUpEmail(
      String email, String password, Function(Exception?) completion) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) => handleFirebaseAuthResponse(null, completion),
            onError: (error) => handleFirebaseAuthResponse(error, completion));
  }

  void signInEmail(
      String email, String password, Function(Exception?) completion) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((_) => {handleFirebaseAuthResponse(null, completion)},
            onError: (error) =>
                {handleFirebaseAuthResponse(error, completion)});
  }

  void handleFirebaseAuthResponse(
      Exception? error, Function(Exception? error) completion) {
    if (error != null) {
      completion(error);
      return;
    }

    _initialize(() => {
          if (_initialized)
            {completion(null)}
          else
            {completion(new Exception("Unable to initialize session"))}
        });
  }
}
