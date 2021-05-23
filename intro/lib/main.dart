import 'package:flutter/material.dart';
import 'package:intro/pages/admin_home.dart';
import 'package:intro/pages/bottomNavigation.dart';
import 'package:intro/pages/noticeboard.dart';
import 'package:intro/pages/request_report.dart';
import 'package:intro/pages/user_profile.dart';
import 'package:intro/pages/user_profile_settings.dart';
import 'package:intro/pages/users_list.dart';
import 'package:intro/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intro/pages/home.dart';
//import 'package:web_app/pages/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: null,
      create: (context) => FirebaseAuth.instance.authStateChanges(),
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/user_list': (context) => UserList(),
          '/admin_home': (context) => AdminHome(),
          '/user_profile': (context) => UserProfile(),
          '/user_profile_settings': (context) => UserProfileSettings(),
          '/request_report': (context) => RequestReport(),
          '/notice': (context) => NoticeBoard(),
        },
      ),
    );
  }
}
