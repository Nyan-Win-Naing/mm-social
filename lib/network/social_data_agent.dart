import 'dart:io';

import 'package:mm_social/data/vos/feed_vo.dart';
import 'package:mm_social/data/vos/user_vo.dart';

abstract class SocialDataAgent {
  /// Feed
  Stream<List<FeedVO>> getFeeds();
  Future<void> addNewPost(FeedVO newPost);
  Future<void> deletePost(int postId);
  Stream<FeedVO> getFeedById(int feedId);
  Future<String> uploadFileToFirebase(File file);

  /// Authentication
  Future registerNewUser(UserVO newUser);
  Future login(String email, String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();
}