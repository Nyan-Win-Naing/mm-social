import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';
import 'package:mm_social/data/vos/user_vo.dart';

class ProfileBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  UserVO? loggedInUser;

  /// Models
  final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  ProfileBloc() {
    loggedInUser = _mAuthenticationModel.getLoggedInUser();
    notifyListeners();
  }

  Future onTapLogout() {
    return _mAuthenticationModel.logOut();
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