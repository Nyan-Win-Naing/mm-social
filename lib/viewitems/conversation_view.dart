import 'package:flutter/material.dart';
import 'package:mm_social/blocs/chat_bloc.dart';
import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/pages/conversation_page.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:provider/provider.dart';

class ConversationView extends StatelessWidget {
  final ConversationVO? conversationVo;

  ConversationView({required this.conversationVo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChatBloc bloc = Provider.of<ChatBloc>(context, listen: false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ConversationPage(userVo: conversationVo?.userVo),
          ),
        );
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: MARGIN_MEDIUM),
        height: 80,
        // color: Colors.blue,
        child: Row(
          children: [
            ProfileImageView(
                profile: conversationVo?.userVo?.profilePicture ?? ""),
            SizedBox(width: MARGIN_MEDIUM_2),
            ConversationNameAndMessageView(conversationVO: conversationVo),
          ],
        ),
      ),
    );
  }
}

class ConversationNameAndMessageView extends StatelessWidget {
  final ConversationVO? conversationVO;

  ConversationNameAndMessageView({required this.conversationVO});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                conversationVO?.userVo?.userName ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                conversationVO?.getDateTime() ?? "",
                style: TextStyle(
                  color: Color.fromRGBO(125, 138, 152, 1.0),
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_2),
          Text(
            conversationVO?.message ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color.fromRGBO(125, 138, 152, 1.0),
              // fontSize: TEXT_REGULAR + 1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileImageView extends StatelessWidget {
  final String profile;

  ProfileImageView({required this.profile});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
        (profile.isNotEmpty)
            ? profile
            : "https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg",
      ),
    );
  }
}
