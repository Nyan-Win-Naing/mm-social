// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      image: json['image'] as String?,
      video: json['video'] as String?,
      name: json['name'] as String?,
      profilePic: json['profile_pic'] as String?,
      timeStamp: json['time_stamp'] as int?,
      userId: json['user_id'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'image': instance.image,
      'video': instance.video,
      'message': instance.message,
      'name': instance.name,
      'profile_pic': instance.profilePic,
      'time_stamp': instance.timeStamp,
      'user_id': instance.userId,
    };
