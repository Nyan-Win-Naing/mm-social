import 'package:flutter/material.dart';
import 'package:mm_social/dummy/dummy_conversation_function_vo.dart';
import 'package:mm_social/resources/dimens.dart';

class ConversationFunctionItemView extends StatelessWidget {

  DummyConversationFunctionVO functionVo;


  ConversationFunctionItemView({required this.functionVo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          functionVo.iconData,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          functionVo.label ?? "",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            fontSize: TEXT_13,
          ),
        ),
      ],
    );
  }
}
