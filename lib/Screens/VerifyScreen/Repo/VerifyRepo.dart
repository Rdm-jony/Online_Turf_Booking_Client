import 'package:firebase_auth/firebase_auth.dart';
import 'package:playspot_client/Screens/RegisterScreen/Repo/RegisterRepo.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class VerifyRepo {
  static Future<User?> verifyNumberFunction(smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: RegisterRepo.varificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      var result = await auth.signInWithCredential(credential);
      print(result.user);
      return result.user;
    } catch (e) {
      print(e);
    }
  }
}
