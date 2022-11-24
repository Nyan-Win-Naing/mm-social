import 'package:flutter/material.dart';
import 'package:mm_social/pages/conversation_page.dart';
import 'package:mm_social/resources/dimens.dart';

class ConversationView extends StatelessWidget {

  final String name;


  ConversationView({required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationPage(),
          ),
        );
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: MARGIN_MEDIUM),
        height: 80,
        // color: Colors.blue,
        child: Row(
          children: [
            ProfileImageView(),
            SizedBox(width: MARGIN_MEDIUM_2),
            ConversationNameAndMessageView(name: name),
          ],
        ),
      ),
    );
  }
}

class ConversationNameAndMessageView extends StatelessWidget {
  final String name;


  ConversationNameAndMessageView({required this.name});

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
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Wed",
                style: TextStyle(
                  color: Color.fromRGBO(125, 138, 152, 1.0),
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_2),
          Text(
            "Tom and Jerry is an American animated media franchise and series of comedy short films created in 1940 by William Hanna and Joseph Barbera.",
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
  const ProfileImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
        "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg",
      ),
    );
  }
}
