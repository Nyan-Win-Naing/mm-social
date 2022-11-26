import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/social_model.dart';
import 'package:mm_social/data/models/social_model_impl.dart';
import 'package:mm_social/data/vos/user_vo.dart';

class ContactBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  List<UserVO>? contactList;
  List<String>? alphabetList;

  /// Models
  SocialModel _mSocialModel = SocialModelImpl();

  ContactBloc() {
    _mSocialModel.getContacts().listen((contacts) {
      contactList = contacts;
      notifyListeners();
      createAlphabetListByContacts();
    });
  }

  void createAlphabetListByContacts() {
    List<String> list = [];
    contactList?.forEach((userVo) {
      list.add(userVo.userName?[0].toUpperCase() ?? "");
    });
    list = list.toSet().toList();
    list.sort();
    alphabetList = list;
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