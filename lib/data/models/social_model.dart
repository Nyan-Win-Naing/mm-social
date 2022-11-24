import 'dart:io';

import 'package:mm_social/data/vos/feed_vo.dart';

abstract class SocialModel {
  Stream<List<FeedVO>> getFeeds();
  Stream<FeedVO> getFeedById(int feedId);
  Future<void> addNewPost(String description, File? imageFile, File? videoFile);
  Future<void> editPost(FeedVO feedVo, File? imageFile, File? videoFile);
  Future<void> deletePost(int postId);
}