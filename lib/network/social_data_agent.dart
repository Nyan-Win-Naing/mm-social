import 'dart:io';

import 'package:mm_social/data/vos/feed_vo.dart';

abstract class SocialDataAgent {
  /// Feed
  Stream<List<FeedVO>> getFeeds();
  Future<void> addNewPost(FeedVO newPost);
  Future<void> deletePost(int postId);
  Stream<FeedVO> getFeedById(int feedId);
  Future<String> uploadFileToFirebase(File file);
}