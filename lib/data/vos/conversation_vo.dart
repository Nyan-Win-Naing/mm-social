import 'package:json_annotation/json_annotation.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:intl/intl.dart';

part 'conversation_vo.g.dart';

@JsonSerializable()
class ConversationVO {
  UserVO? userVo;
  String? message;
  int? timestamp;

  ConversationVO({
    this.userVo,
    this.message,
    this.timestamp,
  });

  factory ConversationVO.fromJson(Map<String, dynamic> json) => _$ConversationVOFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationVOToJson(this);

  String getDateTime() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);
    String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
    return formattedDate;
  }
}
