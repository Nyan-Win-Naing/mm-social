import 'dart:io';

import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/fcm/fcm_service.dart';
import 'package:mm_social/network/cloud_firestore_data_agent_impl.dart';
import 'package:mm_social/network/social_data_agent.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton =
      AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl() {
    return _singleton;
  }

  AuthenticationModelImpl._internal();

  SocialDataAgent mDataAgent = CloudFirestoreDataAgentImpl();
  FCMService fcmService = FCMService();

  @override
  UserVO getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  Future<void> register(String email, String username, String password,
      String phone, File? profilePicture) {
    if (profilePicture != null) {
      return mDataAgent
          .uploadFileToFirebase(profilePicture)
          .then((downloadUrl) =>
              craftUserVO(email, username, password, phone, downloadUrl))
          .then((newUser) => mDataAgent.registerNewUser(newUser));
    } else {
      return craftUserVO(email, username, password, phone, "")
          .then((newUser) => mDataAgent.registerNewUser(newUser));
    }
  }

  Future<UserVO> craftUserVO(String email, String username, String password,
      String phone, String profileUrl) async {
    String fcmToken = await fcmService.getFcmToken();
    print("FCM Token is ==========> $fcmToken");
    var newUser = UserVO(
      id: "",
      email: email,
      userName: username,
      password: password,
      phoneNumber: phone,
      profilePicture: profileUrl,
      qrCode: "",
      fcmToken: fcmToken,
    );
    return Future.value(newUser);
  }

  @override
  Future<UserVO> getUserById(String userId) {
    return mDataAgent.getUserById(userId);
  }
}
