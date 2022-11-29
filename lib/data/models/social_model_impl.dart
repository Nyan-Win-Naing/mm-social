import 'dart:io';

import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';
import 'package:mm_social/data/models/social_model.dart';
import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/data/vos/feed_vo.dart';
import 'package:mm_social/data/vos/message_vo.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/network/cloud_firestore_data_agent_impl.dart';
import 'package:mm_social/network/message_data_agent.dart';
import 'package:mm_social/network/real_time_database_data_agent_impl.dart';
import 'package:mm_social/network/social_data_agent.dart';

class SocialModelImpl extends SocialModel {
  static final SocialModelImpl _singleton = SocialModelImpl._internal();

  factory SocialModelImpl() {
    return _singleton;
  }

  SocialModelImpl._internal();

  /// Data Agent
  SocialDataAgent mDataAgent = CloudFirestoreDataAgentImpl();
  MessageDataAgent mMessageDataAgent = RealtimeDatabaseDataAgentImpl();

  /// Models
  AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  @override
  Future<void> addNewPost(
      String description, File? imageFile, File? videoFile) {
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftFeedVO(description, downloadUrl, ""))
          .then((newPost) => mDataAgent.addNewPost(newPost));
    } else if (videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => craftFeedVO(description, "", downloadUrl))
          .then((newPost) => mDataAgent.addNewPost(newPost));
    } else {
      return craftFeedVO(description, "", "")
          .then((newPost) => mDataAgent.addNewPost(newPost));
    }
  }

  Future<FeedVO> craftFeedVO(
      String description, String imageUrl, String videoUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = FeedVO(
      id: currentMilliseconds,
      userName: "Nyan Win Naing",
      postImage: imageUrl,
      description: description,
      profilePicture:
          "https://i.pinimg.com/736x/8b/15/81/8b1581d6b4827e604c6f5fbe8defc3cb.jpg",
      postVideo: videoUrl,
    );
    return Future.value(newPost);
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Future<void> editPost(FeedVO feedVo, File? imageFile, File? videoFile) {
    // return mDataAgent.addNewPost(feedVo);
    if (imageFile != null) {
      return mDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftFeedVOForEdit(feedVo, downloadUrl, ""))
          .then((feed) => mDataAgent.addNewPost(feed));
    } else if (videoFile != null) {
      return mDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => craftFeedVOForEdit(feedVo, "", downloadUrl))
          .then((feed) => mDataAgent.addNewPost(feed));
    } else {
      return craftFeedVOForEdit(
              feedVo, feedVo.postImage ?? "", feedVo.postVideo ?? "")
          .then((feed) => mDataAgent.addNewPost(feed));
    }
  }

  Future<FeedVO> craftFeedVOForEdit(
      FeedVO feedVo, String imageUrl, String videoUrl) {
    feedVo.postImage = imageUrl;
    feedVo.postVideo = videoUrl;
    return Future.value(feedVo);
  }

  @override
  Stream<FeedVO> getFeedById(int feedId) {
    return mDataAgent.getFeedById(feedId);
  }

  @override
  Stream<List<FeedVO>> getFeeds() {
    return mDataAgent.getFeeds();
  }

  @override
  Future<void> addFriendToScannerContact(String scannerId, String friendId) {
    return _mAuthenticationModel.getUserById(friendId).then((friendUser) {
      return mDataAgent.addFriendToScannerContact(scannerId, friendUser);
    });
    // return mDataAgent.addFriendToScannerContact(scannerId, friendUserVo);
  }

  @override
  Future<void> addScannerToFriendContact(String friendId, String scannerId) {
    return _mAuthenticationModel.getUserById(scannerId).then((scannerUser) {
      return mDataAgent.addScannerToFriendContact(friendId, scannerUser);
    });
  }

  @override
  Stream<List<UserVO>> getContacts() {
    return mDataAgent.getContacts();
  }

  @override
  Future<void> sendMessage({
    required String friendId,
    required String message,
    required File? imageFile,
    required File? videoFile,
  }) {
    if (imageFile != null) {
      return mMessageDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadUrl) => craftMessageVO(message, downloadUrl, ""))
          .then((newMessage) =>
              mMessageDataAgent.sendMessage(newMessage, friendId));
    } else if (videoFile != null) {
      return mMessageDataAgent
          .uploadFileToFirebase(videoFile)
          .then((downloadUrl) => craftMessageVO(message, "", downloadUrl))
          .then((newMessage) =>
              mMessageDataAgent.sendMessage(newMessage, friendId));
    } else {
      return craftMessageVO(message, "", "").then(
          (newMessage) => mMessageDataAgent.sendMessage(newMessage, friendId));
    }
  }

  Future<MessageVO> craftMessageVO(
      String message, String imageUrl, String videoUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newMessage = MessageVO(
      image: imageUrl,
      video: videoUrl,
      message: message,
      name: _mAuthenticationModel.getLoggedInUser().userName,
      profilePic: _mAuthenticationModel.getLoggedInUser().profilePicture,
      timeStamp: currentMilliseconds,
      userId: _mAuthenticationModel.getLoggedInUser().id,
    );
    return Future.value(newMessage);
  }

  @override
  Stream<List<MessageVO>> getMessages(String friendId) {
    return mMessageDataAgent.getMessages(friendId);
  }

  @override
  Stream<List<Future<ConversationVO>>> getConversations() {
    return mMessageDataAgent.getConversations();
  }

  @override
  Future<void> deleteConversation(String friendId) {
    return mMessageDataAgent.deleteConversation(friendId);
  }
}
