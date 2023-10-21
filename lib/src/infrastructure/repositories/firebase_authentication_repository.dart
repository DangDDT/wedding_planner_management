import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_planner_management/src/domain/exceptions/exceptions.dart';
import 'package:wedding_planner_management/src/domain/services/firebase/firebase_authentication_service.dart';

import '../../../core/core.dart';
import '../../../environment.dart';

class FirebaseAuthenticationRepository extends FirebaseAuthenticationService {
  final FirebaseAuth? _firebaseAuthInstance;

  FirebaseAuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    required Environment? environment,
  }) : _firebaseAuthInstance = firebaseAuth ?? FirebaseAuth.instance;

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
    } on FirebaseAuthException catch (e, stackTrace) {
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
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Logger.log(
          errorMessage,
          name: 'FirebaseAuthenticationRepository_getCurrentUser()',
          stackTrace: stackTrace,
        );
      }
      Logger.log(
        e.toString(),
        name: 'FirebaseAuthenticationRepository_getCurrentUser()',
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'FirebaseAuthenticationRepository_getCurrentUser()',
        stackTrace: stackTrace,
      );
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
      final user = await _firebaseAuthInstance!.signInWithEmailAndPassword(
        email: email,
        password: password,
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
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'FirebaseAuthenticationRepository_signInWithEmailAndPassword()',
        stackTrace: stackTrace,
      );
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
