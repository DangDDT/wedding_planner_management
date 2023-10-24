import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wedding_planner_management/src/domain/exceptions/exceptions.dart';
import 'package:wedding_planner_management/src/domain/services/firebase/firebase_authentication_service.dart';

import '../../../environment.dart';

class FirebaseAuthenticationRepository extends FirebaseAuthenticationService {
  final FirebaseAuth? _firebaseAuthInstance;

  FirebaseAuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    required Environment? environment,
  }) : _firebaseAuthInstance = firebaseAuth ?? FirebaseAuth.instance
          ..setSettings(
            forceRecaptchaFlow: false,
            appVerificationDisabledForTesting: true,
          );

  @override
  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> getCurrentUser() async {
    try {
      final user = _firebaseAuthInstance!.currentUser;
      if (user == null) {
        throw const RemoteException(
          kind: RemoteExceptionKind.serverError,
          httpErrorCode: 500,
          serverError: ServerError(
            generalServerStatusCode: 500,
            generalMessage: 'Firebase_Không tìm thấy user',
          ),
        );
      }
      final token = await user.getIdToken();
      if (token == null) {
        throw const RemoteException(
          kind: RemoteExceptionKind.serverError,
          httpErrorCode: 500,
          serverError: ServerError(
            generalServerStatusCode: 500,
            generalMessage: 'Firebase_Không tìm thấy token',
          ),
        );
      }
      return token;
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Không tìm thấy user';
          break;
        case 'wrong-password':
          errorMessage = 'Sai mật khẩu';
          break;
        case 'invalid-email':
          errorMessage = 'Email không hợp lệ';
          break;
        case 'user-disabled':
          errorMessage = 'Tài khoản đã bị khóa';
          break;
        case 'unknown':
          errorMessage = 'Lỗi không xác định';
          break;
      }
      if (errorMessage != null) {
        Get.snackbar(
          'Đăng nhập thất bại',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isUserLoggedIn() {
    final user = _firebaseAuthInstance!.currentUser;
    return Future.value(user != null);
  }

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final googleProvider = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final user = await _firebaseAuthInstance!.signInWithCredential(
        googleProvider,
      );
      if (user.user == null) {
        throw const RemoteException(
          kind: RemoteExceptionKind.serverError,
          httpErrorCode: 500,
          serverError: ServerError(
              generalServerStatusCode: 500,
              generalMessage: 'Firebase_Không tìm thấy user'),
        );
      }
      final token = await user.user!.getIdToken();
      if (token == null) {
        throw const RemoteException(
          kind: RemoteExceptionKind.serverError,
          httpErrorCode: 500,
          serverError: ServerError(
            generalServerStatusCode: 500,
            generalMessage: 'Firebase_Không tìm thấy token',
          ),
        );
      }
      return token;
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Không tìm thấy user';
          break;
        case 'wrong-password':
          errorMessage = 'Sai mật khẩu';
          break;
        case 'invalid-email':
          errorMessage = 'Email không hợp lệ';
          break;
        case 'user-disabled':
          errorMessage = 'Tài khoản đã bị khóa';
          break;
        case 'unknown':
          errorMessage = 'Lỗi không xác định';
          break;
      }
      if (errorMessage != null) {
        Get.snackbar(
          'Đăng nhập thất bại',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      throw RemoteException(
        kind: RemoteExceptionKind.serverError,
        httpErrorCode: 500,
        serverError: ServerError(
          generalServerStatusCode: 500,
          generalMessage: errorMessage ?? 'Lỗi không xác định',
          generalError: e.toString(),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    final user = _firebaseAuthInstance!.currentUser;
    if (user != null) {
      await _firebaseAuthInstance!.signOut();
    }
  }
}
