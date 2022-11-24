import 'package:flutter/material.dart';
import 'package:mm_social/blocs/feeds_bloc.dart';
import 'package:mm_social/pages/add_new_post_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/viewitems/feed_view.dart';
import 'package:provider/provider.dart';

class FeedsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 20;

    return ChangeNotifierProvider(
      create: (context) => FeedsBloc(),
      child: Scaffold(
        backgroundColor: SECONDARY_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          elevation: 2.0,
          title: Text(
            "Feeds",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  top: MARGIN_MEDIUM, bottom: MARGIN_MEDIUM),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<FeedsBloc>(
                  builder: (context, bloc, child) => ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
                    itemCount: bloc.feeds?.length ?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FeedView(
                        feed: bloc.feeds?[index],
                        onTapDelete: (feedId) {
                          bloc.onTapDeletePost(feedId);
                        },
                        onTapEdit: (feedId) {
                          Future.delayed(Duration(milliseconds: 1000))
                              .then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddNewPostPage(feedId: feedId),
                              ),
                            );
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: MARGIN_XLARGE);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ADD_NEW_POST_BUTTON_COLOR,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewPostPage(),
              ),
            );
          },
          child: Icon(
            Icons.create_rounded,
          ),
        ),
      ),
    );
  }
}
