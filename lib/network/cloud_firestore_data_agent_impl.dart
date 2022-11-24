import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mm_social/data/vos/feed_vo.dart';
import 'package:mm_social/network/social_data_agent.dart';

/// Feed Collection
const feedCollection = "feed";
const fileUploadRef = "uploads";

class CloudFirestoreDataAgentImpl extends SocialDataAgent {
  /// Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Storage
  final firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addNewPost(FeedVO newPost) {
    return _firestore
        .collection(feedCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _firestore
        .collection(feedCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Stream<FeedVO> getFeedById(int feedId) {
    return _firestore
        .collection(feedCollection)
        .doc(feedId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => FeedVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Stream<List<FeedVO>> getFeeds() {
    return _firestore
        .collection(feedCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<FeedVO>((document) {
        return FeedVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<String> uploadFileToFirebase(File file) {
    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(file)
        .then((taskSnapShot) => taskSnapShot.ref.getDownloadURL());
  }
}
