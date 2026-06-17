import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseGoogleAuthService {
  FirebaseGoogleAuthService({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth? _auth;
  final GoogleSignIn _googleSignIn;

  bool get isConfigured => Firebase.apps.isNotEmpty;

  FirebaseAuth get _firebaseAuth {
    if (_auth != null) return _auth;
    if (!isConfigured) {
      throw Exception(
        'Firebase is not configured. Run flutterfire configure or add google-services.json.',
      );
    }

    return FirebaseAuth.instance;
  }

  User? get currentUser {
    if (!isConfigured) return null;
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signInWithGoogle() async {
    if (!isConfigured) {
      throw Exception(
        'Firebase is not configured. Please run flutterfire configure first.',
      );
    }

    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google Sign-In was cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    if (isConfigured) {
      await _firebaseAuth.signOut();
    }
  }
}
