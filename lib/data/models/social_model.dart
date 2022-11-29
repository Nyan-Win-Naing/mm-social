import 'dart:io';

import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/data/vos/feed_vo.dart';
import 'package:mm_social/data/vos/message_vo.dart';
import 'package:mm_social/data/vos/user_vo.dart';

abstract class SocialModel {
  Stream<List<FeedVO>> getFeeds();
  Stream<FeedVO> getFeedById(int feedId);
  Future<void> addNewPost(String description, File? imageFile, File? videoFile);
  Future<void> editPost(FeedVO feedVo, File? imageFile, File? videoFile);
  Future<void> deletePost(int postId);

  /// Friend Invitation
  Future<void> addFriendToScannerContact(String scannerId, String friendId);
  Future<void> addScannerToFriendContact(String friendId, String scannerId);
  Stream<List<UserVO>> getContacts();

  /// Chat
  Future<void> sendMessage({
    required String friendId,
    required String message,
    required File? imageFile,
    required File? videoFile,
  });
  Stream<List<MessageVO>> getMessages(String friendId);
  Stream<List<Future<ConversationVO>>> getConversations();
  Future<void> deleteConversation(String friendId);
}
