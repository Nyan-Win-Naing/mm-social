import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';

class SignUpBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  bool isLoading = false;
  String name = "";
  String phone = "";
  String password = "";
  String country = "Myanmar";
  File? chosenImageFile;
  bool isAccept = false;
  bool isButtonEnable = false;

  /// Model
  AuthenticationModel _model = AuthenticationModelImpl();

  void onUsernameChanged(String username) {
    name = username;
    checkFormData();
  }

  void onAcceptPrivacyAndPolicy() {
    isAccept = !isAccept;
    notifyListeners();
    checkFormData();
  }

  void onPhoneChanged(String phone) {
    this.phone = phone;
    checkFormData();
  }

  void onPasswordChanged(String password) {
    this.password = password;
    checkFormData();
  }

  void onCountryChanged(String country) {
    this.country = country;
    notifyListeners();
  }

  void onImageChosen(File imageFile) {
    print("OnImageChosen Block works..........");
    chosenImageFile = imageFile;
    notifyListeners();
  }

  void onTapDeleteImage() {
    chosenImageFile = null;
    notifyListeners();
  }

  void checkFormData() {
    if(name.isNotEmpty && phone.isNotEmpty && password.isNotEmpty && isAccept) {
      isButtonEnable = true;
      notifyListeners();
    } else {
      isButtonEnable = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if(!_disposed) {
      super.notifyListeners();
    }
  }
}