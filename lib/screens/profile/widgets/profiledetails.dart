import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharvaanimatrimony/providers/membersprovider.dart';
import 'package:sharvaanimatrimony/screens/home/singleBirdeinfo.dart';

class Profiledetails extends StatefulWidget {
  @override
  _ProfiledetailsState createState() => _ProfiledetailsState();
}

class _ProfiledetailsState extends State<Profiledetails> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  var data;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      final extrateddata = json.decode(prefs.getString('userData'));

      data = await Provider.of<MemberProvider>(context, listen: false)
          .byId(extrateddata['userid'].toString())
          .then((value) {
        setState(() {
          print('provider working');
          _isLoading = false;
        });
        return value;
      });
      print('profile data');
      print(data[1][0].firstName);

      print(data.runtimeType);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleBrideInfo(data:data[1][0], type:'profile');
  }
}
