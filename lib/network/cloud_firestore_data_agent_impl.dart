import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mm_social/data/vos/feed_vo.dart';
import 'package:mm_social/data/vos/message_vo.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/network/social_data_agent.dart';

/// Feed Collection
const feedCollection = "feed";
const usersCollection = "users";
const fileUploadRef = "uploads";
const contactsCollection = "contacts";

class CloudFirestoreDataAgentImpl extends SocialDataAgent {
  /// Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Storage
  final firebaseStorage = FirebaseStorage.instance;

  /// Auth
  FirebaseAuth auth = FirebaseAuth.instance;

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

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
      profilePicture: auth.currentUser?.photoURL,
    );
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? "", password: newUser.password ?? "")
        .then((credential) => credential.user
          ?..updateDisplayName(newUser.userName)
          ..updatePhotoURL(newUser.profilePicture))
        .then((user) {
      newUser.id = user?.uid ?? "";
      newUser.qrCode = user?.uid ?? "";
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser) {
    return _firestore
        .collection(usersCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future<UserVO> getUserById(String userId) {
    // return _firestore
    //     .collection(usersCollection)
    //     .doc(userId)
    //     .get()
    //     .asStream()
    //     .where((documentSnapShot) => documentSnapShot.data() != null)
    //     .map((documentSnapShot) => UserVO.fromJson(documentSnapShot.data()!));
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .get()
        .then((documentSnapShot) {
      if (documentSnapShot.data() != null) {
        return UserVO.fromJson(documentSnapShot.data()!);
      } else {
        return UserVO();
      }
    });
  }

  @override
  Future<void> addFriendToScannerContact(String scannerId, UserVO userVo) {
    return _firestore
        .collection(usersCollection)
        .doc(scannerId)
        .collection(contactsCollection)
        .doc(userVo.id)
        .set(userVo.toJson());
  }

  @override
  Future<void> addScannerToFriendContact(String friendId, UserVO userVo) {
    return _firestore
        .collection(usersCollection)
        .doc(friendId)
        .collection(contactsCollection)
        .doc(userVo.id)
        .set(userVo.toJson());
  }

  @override
  Stream<List<UserVO>> getContacts() {
    return _firestore
        .collection(usersCollection)
        .doc(getLoggedInUser().id)
        .collection(contactsCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<UserVO>((document) {
        return UserVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> sendMessage(MessageVO messageVO, int friendId) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
