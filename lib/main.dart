import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sharvaanimatrimony/providers/membersprovider.dart';
import 'package:sharvaanimatrimony/screens/auth/login.dart';
import 'package:sharvaanimatrimony/screens/tabScreen.dart';

import 'providers/auth_users.dart';
import 'screens/auth/signup.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF91292E, color);
    MaterialColor colorCustom2 = MaterialColor(0xFFE91E6D, color);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ChangeNotifierProvider.value(
        //   value: BannerProvider(),
        // ),
        ChangeNotifierProvider.value(
          value: MemberProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Sharvaani Matrimony',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: colorCustom,
            accentColor: colorCustom2,
          ),
          home: TabsScreen(),
          routes: {
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            TabsScreen.routeName: (ctx) => TabsScreen(),
          }),
    );
  }
}
