import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/data/vos/message_vo.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/network/cloud_firestore_data_agent_impl.dart';
import 'package:mm_social/network/message_data_agent.dart';
import 'package:mm_social/network/social_data_agent.dart';

/// Database Path
const contactsAndMessagesPath = "contactsAndMessages";

/// File Upload Reference
const fileUploadRef = "uploads";

class RealtimeDatabaseDataAgentImpl extends MessageDataAgent {
  static final RealtimeDatabaseDataAgentImpl _singleton =
      RealtimeDatabaseDataAgentImpl._internal();

  factory RealtimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealtimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.ref();

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  SocialDataAgent _mSocialDataAgent = CloudFirestoreDataAgentImpl();

  @override
  Future<void> sendMessage(MessageVO messageVO, String friendId) {
    return addMessageToSender(messageVO, friendId).then((value) {
      return addMessageToFriend(messageVO, friendId).then((value) {});
    });
  }

  Future<void> addMessageToSender(MessageVO messageVO, String friendId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(_mSocialDataAgent.getLoggedInUser().id ?? "")
        .child(friendId)
        .child(messageVO.timeStamp?.toString() ?? "")
        .set(messageVO.toJson());
  }

  Future<void> addMessageToFriend(MessageVO messageVO, String friendId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(friendId)
        .child(_mSocialDataAgent.getLoggedInUser().id ?? "")
        .child(messageVO.timeStamp?.toString() ?? "")
        .set(messageVO.toJson());
  }

  @override
  Future<String> uploadFileToFirebase(File file) {
    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(file)
        .then((taskSnapShot) => taskSnapShot.ref.getDownloadURL());
  }

  @override
  Stream<List<MessageVO>> getMessages(String friendId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(_mSocialDataAgent.getLoggedInUser().id ?? "")
        .child(friendId)
        .onValue
        .map((event) {
      return event.snapshot.children.map<MessageVO>((dataSnapShot) {
        return MessageVO.fromJson(
            Map<String, dynamic>.from(dataSnapShot.value as dynamic));
      }).toList();
    });
  }

  @override
  Stream<List<Future<ConversationVO>>> getConversations() {
    List<ConversationVO> conversationList = [];
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(_mSocialDataAgent.getLoggedInUser().id ?? "")
        .onValue
        .map((event) {
      List<String?> userKeys = event.snapshot.children.map((dataSnapshot) {
        return dataSnapshot.key;
      }).toList();
      print("User Keys are ==========> $userKeys");
      return userKeys.map((userId) async {
        UserVO userVo = await _mSocialDataAgent.getUserById(userId ?? "");
        MessageVO messageVo = await getLastMessage(userVo.id ?? "");
        return ConversationVO(
          message: messageVo.message ?? "",
          userVo: userVo,
          timestamp: messageVo.timeStamp,
        );
      }).toList();
    });
  }

  Future<MessageVO> getLastMessage(String userId) async {
    DatabaseEvent event = await databaseRef
        .child(contactsAndMessagesPath)
        .child(_mSocialDataAgent.getLoggedInUser().id ?? "")
        .child(userId)
        .once();
    var messageList = event.snapshot.children.map<MessageVO>((element) {
      return MessageVO.fromJson(
          Map<String, dynamic>.from(element.value as dynamic));
    }).toList();
    return Future.value(messageList.last);
  }

  @override
  Future<void> deleteConversation(String friendId) {
    return deleteConversationFromLoggedInUser(friendId).then((value) {
      return deleteConversationFromFriend(friendId).then((value) {});
    });
  }

  Future<void> deleteConversationFromLoggedInUser(String friendId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(_mSocialDataAgent.getLoggedInUser().id ?? "")
        .child(friendId)
        .remove();
  }

  Future<void> deleteConversationFromFriend(String friendId) {
    return databaseRef
        .child(contactsAndMessagesPath)
        .child(friendId)
        .child(_mSocialDataAgent.getLoggedInUser().id ?? "")
        .remove();
  }

  // Stream<List<String?>> getConversations() {
  //   print("This function works...........");
  //   return databaseRef.child(contactsAndMessagesPath).child(_mSocialDataAgent.getLoggedInUser().id ?? "").onValue.map((event) {
  //     return event.snapshot.children.map((dataSnapshot) {
  //       return dataSnapshot.key;
  //     }).toList();
  //   });
  // }
}
