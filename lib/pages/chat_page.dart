import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mm_social/blocs/chat_bloc.dart';
import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/dummy/dummy_data.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/viewitems/conversation_view.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void dispose() {
    print("Chat page is disposed ............");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        backgroundColor: SECONDARY_COLOR,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          elevation: 2.0,
          title: const Text(
            "MM Social",
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: Selector<ChatBloc, List<ConversationVO>>(
          selector: (context, bloc) => bloc.conversationList,
          shouldRebuild: (previous, next) => true,
          builder: (context, conversationList, child) => ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
            itemCount: conversationList.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(0),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // setState(() {
                        //   nameList.removeAt(index);
                        // });
                        ChatBloc bloc = Provider.of<ChatBloc>(context, listen: false);
                        bloc.onTapDeleteConversation(conversationList[index].userVo?.id ?? "");
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: "Delete",
                    ),
                  ],
                ),
                child: ConversationView(conversationVo: conversationList[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
                    height: 0.7,
                    width: MediaQuery.of(context).size.width * 2.3 / 3,
                    color: Color.fromRGBO(9, 16, 26, 1.0),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
