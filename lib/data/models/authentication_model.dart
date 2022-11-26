import 'dart:io';

import 'package:mm_social/data/vos/user_vo.dart';

abstract class AuthenticationModel {
  Future<void> login(String email, String password);
  Future<void> register(String email, String username, String password, String phone, File? profilePicture);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future<void> logOut();
  Future<UserVO> getUserById(String userId);
}