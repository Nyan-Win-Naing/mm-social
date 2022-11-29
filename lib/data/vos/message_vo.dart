import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVO {
  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "video")
  String? video;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "profile_pic")
  String? profilePic;

  @JsonKey(name: "time_stamp")
  int? timeStamp;

  @JsonKey(name: "user_id")
  String? userId;

  MessageVO({
    this.image,
    this.video,
    this.name,
    this.profilePic,
    this.timeStamp,
    this.userId,
    this.message,
  });

  factory MessageVO.fromJson(Map<String, dynamic> json) => _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
