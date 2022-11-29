import 'package:flutter/material.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/pages/conversation_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';

class ContactGroupedByAlphabetView extends StatefulWidget {

  final String alphabet;
  final List<UserVO> contactList;


  ContactGroupedByAlphabetView({required this.alphabet, required this.contactList});

  @override
  State<ContactGroupedByAlphabetView> createState() => _ContactGroupedByAlphabetViewState();
}

class _ContactGroupedByAlphabetViewState extends State<ContactGroupedByAlphabetView> {

  List<UserVO> contactsByAlphabet = [];

  @override
  void initState() {
    contactsByAlphabet = widget.contactList.where((userVo) => userVo.userName?[0].toUpperCase() == widget.alphabet).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AlphabetView(alphabet: widget.alphabet, total: contactsByAlphabet.length),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: contactsByAlphabet.length,
          itemBuilder: (context, index) {
            return ContactView(user: contactsByAlphabet[index]);
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

  final String alphabet;
  final int total;


  AlphabetView({required this.alphabet, required this.total});

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
            alphabet,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$total Friends",
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

  final UserVO? user;


  ContactView({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationPage(userVo: user),
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
                (user?.profilePicture ?? "").isNotEmpty ? user?.profilePicture ?? "" : "https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg",
              ),
            ),
            SizedBox(width: MARGIN_MEDIUM_2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.userName ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: MARGIN_MEDIUM),
                Text(
                  user?.phoneNumber ?? "",
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
