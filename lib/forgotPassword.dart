import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/providers/membersprovider.dart';
import 'package:sharvaanimatrimony/updatePassword.dart';

import 'conts/dimensions.dart';
import 'conts/styles.dart';
import 'models/http_exception.dart';

class ForgotPassWord extends StatefulWidget {
  @override
  _ForgotPassWordState createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWord> {
  bool _isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Login Failed'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Okay"),
                )
              ],
            ));
  }

  Future<void> _search(String email) async {
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
          .emailid(email);

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
      var errorMessage = 'Could not authenicate you, Please try again later.';
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
                    'Forgot Password',
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
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailTextEdingController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
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
                          _search(emailTextEdingController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: Text(
                            'Submit',
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
