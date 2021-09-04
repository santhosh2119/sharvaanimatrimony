import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/providers/membersprovider.dart';
import 'package:sharvaanimatrimony/screens/auth/login.dart';

import 'conts/dimensions.dart';
import 'conts/styles.dart';
import 'models/http_exception.dart';

class NewPassWord extends StatefulWidget {
  final String data;
  NewPassWord({@required this.data});
  @override
  _NewPassWordState createState() => _NewPassWordState();
}

class _NewPassWordState extends State<NewPassWord> {
  bool _isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Update Successfull'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Login"),
                )
              ],
            ));
  }

  Future<void> _search(String id, String password) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    try {
      var data = await Provider.of<MemberProvider>(context, listen: false)
          .passwordreset(id, password);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewPassWord(
                  data: data[1][0].memberId,
                )),
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authencation failed';
      if (error.toString().contains('does_not_exists')) {
        errorMessage = 'This email is not avalible please login ';
      }
      _showErrorDialog(errorMessage);
      if (error.toString().contains('Mismatch')) {
        errorMessage = 'Email and Password is Invalid! ';
      }
      _showErrorDialog(errorMessage);
      if (error.toString().contains('pending')) {
        errorMessage = 'Your account is in review ';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'New Password updated Please login .';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailTextEdingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logobanner.png',
                  height: 100,
                ),
                Center(
                  child: Text(
                    'New Password',
                    style: poppinsMedium.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Password Must contain atleast 4 digits';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: emailTextEdingController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty ||
                        value != emailTextEdingController.text) {
                      return 'Confrim Password Must be same as Password';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          _search(widget.data, emailTextEdingController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: Text(
                            'Update',
                            style: poppinsMedium.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
