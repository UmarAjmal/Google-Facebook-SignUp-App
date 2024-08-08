
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void signUpWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "User signed up successfully");
      Get.toNamed('/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "Email already in use, please login");
        Get.toNamed('/login');
      } else {
        Get.snackbar("Error", e.message!);
      }
    }
  }

  void loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "User logged in successfully");
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!);
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _auth.signInWithCredential(credential);
        Get.snackbar("Success", "User logged in with Google successfully");
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken! as AccessToken;

        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
        await _auth.signInWithCredential(credential);
        Get.snackbar("Success", "User logged in with Facebook successfully");
        Get.offAllNamed('/home');
      } else if (result.status == LoginStatus.cancelled) {
        Get.snackbar("Cancelled", "Facebook login was cancelled");
      } else {
        Get.snackbar("Error", result.message!);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }


  void signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
class AccessToken {
  String token;

  AccessToken({required this.token});
}