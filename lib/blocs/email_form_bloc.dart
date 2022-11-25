import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';

class EmailFormBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  bool isLoading = false;
  String username = "";
  String phoneNumber = "";
  String password = "";
  String email = "";
  File? profileImage;
  bool isButtonEnable = false;

  /// Model
  final AuthenticationModel _model = AuthenticationModelImpl();

  EmailFormBloc({
    required String username,
    required String phoneNumber,
    required String password,
    required File? profileImage,
  }) {
    this.username = username;
    this.phoneNumber = phoneNumber;
    this.password = password;
    this.profileImage = profileImage;
  }

  Future onTapRegister() {
    _showLoading();
    return _model
        .register(email, username, password, phoneNumber, profileImage)
        .whenComplete(() => _hideLoading());
  }

  void onEmailChanged(String email) {
    this.email = email;
    checkFormEmpty();
  }

  void checkFormEmpty() {
    if (email.isNotEmpty) {
      isButtonEnable = true;
      notifyListeners();
    } else {
      isButtonEnable = false;
      notifyListeners();
    }
  }

  void _showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
