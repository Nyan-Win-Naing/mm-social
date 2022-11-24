import 'package:flutter/material.dart';
import 'package:mm_social/pages/conversation_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';

class ContactGroupedByAlphabetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AlphabetView(),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ContactView();
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 0.8, color: DIVIDER_COLOR);
          },
        ),
      ],
    );
  }
}

class AlphabetView extends StatelessWidget {
  const AlphabetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_LARGE, vertical: MARGIN_MEDIUM_2),
      color: DIVIDER_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "A",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "10 Friends",
            style: TextStyle(
              color: Colors.grey,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactView extends StatelessWidget {
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
        padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM_2),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
              ),
            ),
            SizedBox(width: MARGIN_MEDIUM_2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cherry David",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: MARGIN_MEDIUM),
                Text(
                  "097734959569",
                  style: TextStyle(
                    color: CONTACT_PHONE_NUMBER_COLOR,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
