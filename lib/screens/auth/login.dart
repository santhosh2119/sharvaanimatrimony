import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/models/http_exception.dart';
import 'package:sharvaanimatrimony/providers/auth_users.dart';
import '../../forgotPassword.dart';
import '/conts/dimensions.dart';

import '/conts/styles.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailTextEdingController = TextEditingController();
  final passwordTextEdingController = TextEditingController();
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

  bool _isLoading = false;

  void _login(String email, String password) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    print(email);
    print(password);
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).loginIn(email, password);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logobanner.png',
                    height: 100,),
                    Center(
                      child: Text(
                        'Login',
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
                    TextFormField(
                      obscureText: true,
                      controller: passwordTextEdingController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide Password';
                        }
                        return null;
                      },
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
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              _login(
                                emailTextEdingController.text,
                                passwordTextEdingController.text,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              child: Text(
                                'Login',
                                style: poppinsMedium.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassWord(),),
                              );
                            },
                            child: Text(
                              "Forgot password",
                              style: poppinsMedium.copyWith(),
                            )),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signUp');
                          },
                          child: Text(
                            'Sign Up',
                            style: poppinsMedium.copyWith(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
