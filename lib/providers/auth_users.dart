import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sharvaanimatrimony/models/http_exception.dart';
import 'package:sharvaanimatrimony/screens/tabScreen.dart';

class Auth with ChangeNotifier {
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  void logout(BuildContext context) async {
    _userId = null;

    notifyListeners();
    print(_userId);
    print('printed id');
    if (_userId == null) {
      final pref = await SharedPreferences.getInstance();
      pref.clear();
      print('done');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabsScreen()),
      );
    }
  }

  Future<void> signUp(
    String fullName,
    String dateofBirth,
    String email,
    String gender,
    String mobile,
    String altMobile,
    String behalf,
    String password,
    String gothram,
    String nakshathram,
    String community,
    String region,
    String state,
    String city,
  ) async {
    print('register');
    print(behalf);
    final url =
        Uri.parse('https://sharvaanimatrimony.com/api/customer/register.php');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "first_name": fullName,
            "gender": gender,
            "gothram": gothram,
            "nakshtram": nakshathram,
            "community": community,
            "state": state,
            "city": city,
            "region": region,
            "email": email,
            "date_of_birth": dateofBirth,
            "on_behalf": behalf,
            "mobile": mobile,
            "password": password,
            "referal_code": "",
            'returnSecureToken': true,
          },
        ),
      );
      print('uiid');

      final data = json.decode(response.body);
      print(data);
      print(data['ResultData']);
      print('uiid');
      print(data['ResponseMsg']);
      print(data['ResultData']['ResponseCode']);
    
    } catch (error) {
    
      throw error;
    }
  }

  Future<void> loginIn(String email, String password) async {
    final url =
        Uri.parse(('https://sharvaanimatrimony.com/api/customer/login.php'));

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final data = json.decode(response.body);
      print(json.decode(response.body));
      print(data['ResultData']);
      print('uiid');
      print(data['ResponseMsg']);
      print(data['ResultData']['status']);
      // print(data)
      if (data['ResultData']['status'] == "pending") {
        throw HttpException(data['ResultData']['status']);
      }
      if (data['ResponseMsg'] == "Username/Email and Password Mismatch!") {
        throw HttpException(data['ResponseMsg']);
      }
      _userId = data['ResultData']['member_id'];

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'userid': _userId});
      prefs.setString('userData', userData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final extrateddata = json.decode(prefs.getString('userData'));
    if (!prefs.containsKey('userData')) {
      return false;
    }
    _userId = extrateddata['userid'];
    notifyListeners();
    return true;
  }
}
