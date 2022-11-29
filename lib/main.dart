import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';
import 'package:mm_social/data/vos/conversation_vo.dart';
import 'package:mm_social/network/real_time_database_data_agent_impl.dart';
import 'package:mm_social/pages/bottom_nav_page.dart';
import 'package:mm_social/pages/get_started_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _authenticationModel = AuthenticationModelImpl();
  final RealtimeDatabaseDataAgentImpl _mDataAgent = RealtimeDatabaseDataAgentImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (_authenticationModel.isLoggedIn()) ? BottomNavPage() : GetStartedPage(),
    );
  }
}
