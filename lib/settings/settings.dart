import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';
import 'package:sharvaanimatrimony/packages/packagess.dart';
import 'package:sharvaanimatrimony/providers/auth_users.dart';
import 'package:sharvaanimatrimony/screens/home/checkScreen.dart';
import 'package:sharvaanimatrimony/screens/profile/postImage.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoading = false;
  var uid;
  @override
  void didChangeDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    final extrateddata = json.decode(prefs.getString('userData'));
    final data = extrateddata['userid'].toString();
    setState(() {
      _isLoading = true;
      return uid = data;
    });

    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: _isLoading
            ? CircularProgressIndicator()
            : uid != null
                ? Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageInput(id: uid)),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.upload_file,
                                  size: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  'Upload Image',
                                  style: poppinsMedium.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Packagess(id: uid),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.upgrade,
                                  size: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  'Upgard Package',
                                  style: poppinsMedium.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: () {
                            Provider.of<Auth>(context, listen: false)
                                .logout(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  'Log Out',
                                  style: poppinsMedium.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  )
                : Container(
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
                  ));
  }
}
