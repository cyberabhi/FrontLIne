import 'package:flutter/material.dart';
import 'package:intro/pages/bottomNavigation.dart';
import 'package:intro/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intro/pages/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return BottomNavigation();
    }
  }
}
