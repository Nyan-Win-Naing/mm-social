import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mm_social/dummy/dummy_data.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/viewitems/conversation_view.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
        itemCount: nameList.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: ValueKey(0),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                // SlidableAction(
                //   borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                //   onPressed: (context) {},
                //   backgroundColor: Colors.blue,
                //   foregroundColor: Colors.white,
                //   icon: Icons.save,
                //   label: "Save",
                // ),
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      nameList.removeAt(index);
                    });
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Delete",
                ),
              ],
            ),
            child: ConversationView(name: nameList[index]),
          );
        },
        separatorBuilder: (BuildContext context, intindex) {
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
    );
  }
}
