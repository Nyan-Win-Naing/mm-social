import 'dart:io';

import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/data/vos/message_vo.dart';

abstract class MessageDataAgent {
  Stream<List<MessageVO>> getMessages(String friendId);
  Future<void> sendMessage(MessageVO messageVO, String friendId);
  Future<String> uploadFileToFirebase(File file);
  Stream<List<Future<ConversationVO>>> getConversations();
  Future<void> deleteConversation(String friendId);
}