// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedVO _$FeedVOFromJson(Map<String, dynamic> json) => FeedVO(
      id: json['id'] as int?,
      description: json['description'] as String?,
      profilePicture: json['profile_picture'] as String?,
      userName: json['user_name'] as String?,
      postImage: json['post_image'] as String?,
      postVideo: json['post_video'] as String?,
    );

Map<String, dynamic> _$FeedVOToJson(FeedVO instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'profile_picture': instance.profilePicture,
      'user_name': instance.userName,
      'post_image': instance.postImage,
      'post_video': instance.postVideo,
    };
