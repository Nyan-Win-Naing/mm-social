import 'package:json_annotation/json_annotation.dart';

part 'feed_vo.g.dart';

@JsonSerializable()
class FeedVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "post_image")
  String? postImage;

  @JsonKey(name: "post_video")
  String? postVideo;

  FeedVO({
    this.id,
    this.description,
    this.profilePicture,
    this.userName,
    this.postImage,
    this.postVideo,
  });

  factory FeedVO.fromJson(Map<String, dynamic> json) => _$FeedVOFromJson(json);

  Map<String, dynamic> toJson() => _$FeedVOToJson(this);
}
