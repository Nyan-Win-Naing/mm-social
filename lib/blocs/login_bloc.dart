import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';

class LoginBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  bool isLoading = false;
  String email = "";
  String password = "";
  bool isButtonEnable = false;

  /// Model
  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapLogin() {
    _showLoading();
    return _model.login(email, password).whenComplete(() => _hideLoading());
  }

  void onEmailChanged(String email) {
    this.email = email;
    checkFormEmpty();
  }

  void onPasswordChanged(String password) {
    this.password = password;
    checkFormEmpty();
  }

  void _showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  void checkFormEmpty() {
    if(email.isNotEmpty && password.isNotEmpty) {
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