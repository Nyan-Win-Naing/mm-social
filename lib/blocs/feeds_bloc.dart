import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/social_model.dart';
import 'package:mm_social/data/models/social_model_impl.dart';
import 'package:mm_social/data/vos/feed_vo.dart';

class FeedsBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  List<FeedVO>? feeds;

  /// Models
  final SocialModel _mSocialModel = SocialModelImpl();

  FeedsBloc() {
    _mSocialModel.getFeeds().listen((feedList) {
      feeds = feedList;
      notifyListeners();
    });
  }

  void onTapDeletePost(int postId) async {
    await _mSocialModel.deletePost(postId);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if(!_disposed) {
      super.notifyListeners();
    }
  }
}