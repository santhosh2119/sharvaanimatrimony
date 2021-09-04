import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/SplashScreen.dart';
import 'package:sharvaanimatrimony/providers/auth_users.dart';
import 'package:sharvaanimatrimony/screens/auth/login.dart';

import 'package:sharvaanimatrimony/screens/home/singleBirdeinfo.dart';
import 'package:sharvaanimatrimony/screens/tabScreen.dart';

class CheckScreen extends StatelessWidget {
  final data;
 final String home;

  CheckScreen({this.data, this.home});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Consumer<Auth>(
          builder: (context, auth, _) => auth.isAuth
              ? home == 'homereload'
                  ? TabsScreen()
                  : SingleBrideInfo(data:data, type:"home")
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SpalshScreen()
                          : LoginScreen(),
                ),
        ),
      ),
    );
  }
}
