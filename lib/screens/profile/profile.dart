import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/SplashScreen.dart';
import 'package:sharvaanimatrimony/providers/auth_users.dart';
import 'package:sharvaanimatrimony/screens/home/checkScreen.dart';
import 'package:sharvaanimatrimony/screens/profile/widgets/profiledetails.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Auth>(
        builder: (context, auth, _) => auth.isAuth
            ? Profiledetails()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) =>
                    authResultSnapshot.connectionState ==
                            ConnectionState.waiting
                        ? SpalshScreen()
                        : profile22(context),
              ),
      ),
    );
  }

  Widget profile22(context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        child: Text('Please Login'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckScreen(
                      home: 'homereload',
                    )),
          );
        },
      )),
    );
  }
}
