// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:goldshop/feature/Auth/data/models/user_model.dart';
//
// import 'package:goldshop/navigation.dart';
//
// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Rx<UserModel?> currentUser = Rx<UserModel?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     _auth.authStateChanges().listen((User? user) {
//       currentUser.value = user != null ? UserModel.fromFirebaseUser(user) : null;
//     });
//   }
//
//   Future<void> loginUser(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       Get.snackbar("Success", "Login Successful!",
//           snackPosition: SnackPosition.BOTTOM);
//
//       Get.offAllNamed(CustomNavigationScreen.name);
//     } catch (e) {
//       Get.snackbar("Login Error", e.toString(),
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> updatePassword(String newPassword) async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         await user.updatePassword(newPassword);
//         Get.snackbar("Success", "Password updated successfully!",
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:goldshop/feature/ProfileDetails/presentation/screen/create_profile.dart';
import 'package:goldshop/navigation.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  // ✅ User Signup Function
  Future<void> signUpUser({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match!",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _firestore.collection("SignUp").doc(userCredential.user!.uid).set({
        "name": fullName.trim(),
        "email": email.trim(),
        "uid": userCredential.user!.uid,
      });

      Get.to(() => CreateProfileScreen());

    } catch (e) {
      Get.snackbar("Signup Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ User Login Function (Modify if needed)
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      Get.snackbar("Success", "Login successful",
          snackPosition: SnackPosition.BOTTOM);

      // Navigate to home screen after login
      Get.offAllNamed(CustomNavigationScreen.name);
    } catch (e) {
      Get.snackbar("Login Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

}
