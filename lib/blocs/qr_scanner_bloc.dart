import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';
import 'package:mm_social/data/models/social_model.dart';
import 'package:mm_social/data/models/social_model_impl.dart';
import 'package:mm_social/data/vos/user_vo.dart';

class QRScannerBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  String scannerId = "";
  bool isLoading = false;


  /// Models
  final SocialModel _mSocialModel = SocialModelImpl();

  QRScannerBloc({required String scannerId}) {
    this.scannerId = scannerId;
  }

  Future onScanQR(String friendId) async {
    _showLoading();
    return _mSocialModel.addFriendToScannerContact(scannerId, friendId).whenComplete(() {
      return _mSocialModel.addScannerToFriendContact(friendId, scannerId).whenComplete(() {
        _hideLoading();
      });
    });
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
    if(!_disposed) {
      super.notifyListeners();
    }
  }
}