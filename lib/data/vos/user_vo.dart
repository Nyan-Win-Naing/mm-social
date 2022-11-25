import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "username")
  String? userName;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "profile_picture")
  String? profilePicture;

  @JsonKey(name: "qr_code")
  String? qrCode;

  @JsonKey(name: "fcm_token")
  String? fcmToken;

  UserVO({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.phoneNumber,
    this.profilePicture,
    this.qrCode,
    this.fcmToken,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  String getUserName() {
    String name = userName ?? "";
    return name.replaceAll(" ", "").toLowerCase();
  }

  @override
  String toString() {
    return 'UserVO{id: $id, userName: $userName, email: $email, profilePicture: $profilePicture}';
  }
}
