import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/social_model.dart';
import 'package:mm_social/data/models/social_model_impl.dart';
import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/dummy/dummy_data.dart';

class ChatBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  List<ConversationVO> conversationList = [];
  List<ConversationVO> conversations = [];

  /// Models
  SocialModel _model = SocialModelImpl();

  ChatBloc() {
    getConversations();
  }

  void getConversations()  {
    _model.getConversations().listen((listConversation) {
      conversationList = [];
      print("List Conversation is ========> $listConversation");
      if (listConversation.isNotEmpty) {
        print("List Conversation is not empty ........");
        int count = 0;
        listConversation.forEach((futureConversation) {
          print("Count is ${count++}");
          futureConversation.then((conversation) {
            conversationList.add(conversation);
            conversationList.sort((a, b) => (b.timestamp ?? 0).compareTo(a.timestamp ?? 0));
            conversationList = List.of(conversationList);
            notifyListeners();
          });
        });
      } else {
        print("List Conversation is empty ........");
        conversationList = [];
        notifyListeners();
      }
    });
  }

  void onTapDeleteConversation(String friendId) async {
    await _model.deleteConversation(friendId);
  }

  void clearAllConversations() {
    conversations = [];
    conversationList = [];
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    print("Chat bloc is disposed ...............");
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
