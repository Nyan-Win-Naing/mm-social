import 'package:flutter/material.dart';
import 'package:mm_social/blocs/profile_bloc.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/pages/get_started_page.dart';
import 'package:mm_social/pages/invite_friend_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        backgroundColor: SECONDARY_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          elevation: 0,
          title: Selector<ProfileBloc, UserVO?>(
            selector: (context, bloc) => bloc.loggedInUser,
            builder: (context, loggedInUser, child) => Column(
              children: [
                Text(
                  loggedInUser?.userName ?? "",
                ),
                SizedBox(height: MARGIN_SMALL),
                Text(
                  loggedInUser?.getUserName() ?? "",
                  style: TextStyle(
                    color: CONTACT_PHONE_NUMBER_COLOR,
                    fontSize: TEXT_SMALL,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Selector<ProfileBloc, UserVO?>(
              selector: (context, bloc) => bloc.loggedInUser,
              builder: (context, loggedInUser, child) => Padding(
                padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InviteFriendPage(qrCode: loggedInUser?.qrCode ?? ""),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.qr_code_2,
                      ),
                      SizedBox(width: MARGIN_SMALL),
                      Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Selector<ProfileBloc, UserVO?>(
                  selector: (context, bloc) => bloc.loggedInUser,
                  builder: (context, loggedInUser, child) =>
                      ProfileImageSectionView(
                          profileImage: loggedInUser?.profilePicture ?? ""),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: BioSectionView(),
                ),
                SizedBox(height: MARGIN_MEDIUM_3),
                ProfileInfoSectionView(),
                SizedBox(height: MARGIN_LARGE),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      ProfileBloc bloc =
                          Provider.of<ProfileBloc>(context, listen: false);
                      bloc.onTapLogout().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetStartedPage(),
                          ),
                        );
                      });
                    },
                    child: LogoutButtonSectionView(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutButtonSectionView extends StatelessWidget {
  const LogoutButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MARGIN_XXLARGE, vertical: MARGIN_CARD_MEDIUM_2),
      child: Text(
        "Log Out",
        style: TextStyle(
          color: CONTACT_PHONE_NUMBER_COLOR,
          fontWeight: FontWeight.w600,
          fontSize: TEXT_REGULAR_2X,
        ),
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
    );
  }
}

class ProfileInfoSectionView extends StatelessWidget {
  const ProfileInfoSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: 100,
      decoration: BoxDecoration(
        color: ADD_NEW_POST_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
      ),
      child: Row(
        children: [
          ProfileInfoItemView(label: "Posts", value: "30"),
          ProfileInfoItemView(label: "Friends", value: "5"),
          ProfileInfoItemView(label: "Chats", value: "3"),
        ],
      ),
    );
  }
}

class ProfileInfoItemView extends StatelessWidget {
  final String label;
  final String value;

  ProfileInfoItemView({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontWeight: FontWeight.w500,
              fontSize: TEXT_REGULAR + 1,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_3X,
            ),
          ),
        ],
      ),
    );
  }
}

class BioSectionView extends StatelessWidget {
  const BioSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "The worst of all possible universes and the best of all possible earths.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: CONTACT_PHONE_NUMBER_COLOR,
        height: 1.5,
      ),
    );
  }
}

class ProfileImageSectionView extends StatelessWidget {
  final String profileImage;

  ProfileImageSectionView({required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      color: Colors.yellow,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: PRIMARY_COLOR,
                height: 90,
              ),
              Container(
                color: SECONDARY_COLOR,
                height: 90,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
                image: DecorationImage(
                    image: NetworkImage(
                      (profileImage.isNotEmpty)
                          ? profileImage
                          : "https://brsc.sa.edu.au/wp-content/uploads/2018/09/placeholder-profile-sq.jpg",
                    ),
                    fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(-1, 3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
