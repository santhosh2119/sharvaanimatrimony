import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/conts/colors.dart';
import 'package:sharvaanimatrimony/providers/auth_users.dart';
import 'package:sharvaanimatrimony/widgets/dropdown_formfield.dart';
import '/conts/dimensions.dart';
import 'package:intl/intl.dart';
import '/conts/styles.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUp';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final fullNameTextEdingController = TextEditingController();
  // final dobTextEdingController = TextEditingController();
  final mobileTextEdingController = TextEditingController();
  final alternateMobileTextEdingController = TextEditingController();
  final emailTextEdingController = TextEditingController();
  final passwordTextEdingController = TextEditingController();
  final confirmTextEdingController = TextEditingController();
  final gothramTextEdingController = TextEditingController();
  final nakshathramTextEdingController = TextEditingController();
  final regionTextEdingController = TextEditingController();
  final cityTextEdingController = TextEditingController();
  DateTime _selectedDate;
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Sign Up Successfull'),
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

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  void _signUp(
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
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    print(fullName);
    print(_selectedDate);
    print(email);
    print(provider['type']);
    print(mobile);
    print(altMobile);
    print(provider['beoff']);
    print(password);
    print(confirmTextEdingController.text);
    print(gothram);
    print(nakshathram);
    print(region);
    print(provider['state']);
    print(city);

    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signUp(
          fullName,
          dateofBirth,
          email,
          gender,
          mobile,
          altMobile,
          behalf,
          password,
          gothram,
          nakshathram,
          community,
          region,
          state,
          city,);

    } catch (error) {
      var errorMessage = 'Please wait for admin approval.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Map<String, dynamic> provider = {
    'type': '',
    'beoff': '',
    'community': '',
    'state': '',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logobanner.png',
                  height: 100,),
                  Center(
                    child: Text(
                      'Sign Up',
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
                      if (value.isEmpty) {
                        return 'Please provide your Full Name';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: fullNameTextEdingController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    // ignore: deprecated_member_use
                    child: FlatButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: set1_meroon),
                      ),

                      //padding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                      onPressed: _presentDatePicker,
                      icon: Icon(
                        Icons.calendar_today,
                        color: set1_meroon,
                        size: 30,
                      ),
                      label: _selectedDate == null
                          ? Text(
                              "Date of Birth".toUpperCase(),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: dark_grey,
                              ),
                            )
                          : Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: dark_grey,
                              ),
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
                  Container(
                    child: DropDownFormField(
                      filled: true,
                      fillcolor: set1_light_blue_light,
                      //titleText: 'type',
                      hintText: 'Please choose your Gender',
                      value: provider["type"],
                      onSaved: (value) {
                        setState(() {
                          provider["type"] = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          provider["type"] = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide your Gender.';
                        }
                        return null;
                      },
                      dataSource: [
                        {
                          "display": "Male",
                          "value": "1",
                        },
                        {
                          "display": "Female",
                          "value": "2",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 10) {
                        return 'PLease Enter valid Mobile Number';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: mobileTextEdingController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Mobile Number',
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
                      if (value.isEmpty || value.length < 10) {
                        return 'PLease Enter valid Mobile Number';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: alternateMobileTextEdingController,
                    decoration: InputDecoration(
                      labelText: 'Alternate Mobile Number',
                      hintText: ' Alternete Mobile Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  Container(
                    child: DropDownFormField(
                      filled: true,
                      fillcolor: set1_light_blue_light,
                      //titleText: 'type',
                      hintText: 'On Behalf',
                      value: provider["beoff"],
                      onSaved: (value) {
                        setState(() {
                          provider["beoff"] = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          provider["beoff"] = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide your on BeHalf.';
                        }
                        return null;
                      },
                      dataSource: [
                        {
                          "display": "Self",
                          "value": "1",
                        },
                        {
                          "display": "Daughter/Son",
                          "value": "2",
                        },
                        {
                          "display": "Sister",
                          "value": "3",
                        },
                        {
                          "display": "Brother",
                          "value": "4",
                        },
                        {
                          "display": "Friend",
                          "value": "5",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
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
                      if (value.isEmpty || value.length < 6) {
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
                  TextFormField(
                    obscureText: true,
                    controller: confirmTextEdingController,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty ||
                          value != passwordTextEdingController.text) {
                        return 'Password and confirm Password must match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
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
                      if (value.isEmpty) {
                        return 'Please provide your Gothram';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: gothramTextEdingController,
                    decoration: InputDecoration(
                      labelText: 'Gothram',
                      hintText: 'Gothram',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide your Nakshathram';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: nakshathramTextEdingController,
                    decoration: InputDecoration(
                      labelText: 'Nakshathram',
                      hintText: 'Nakshatthram',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  Container(
                    child: DropDownFormField(
                      filled: true,
                      fillcolor: set1_light_blue_light,
                      //titleText: 'type',
                      hintText: 'Please choose your Community',
                      value: provider["community"],
                      onSaved: (value) {
                        setState(() {
                          provider["community"] = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          provider["community"] = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      dataSource: [
                        {
                          "display": "Aryavysya",
                          "value": "Aryavysya",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide your Region';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: regionTextEdingController,
                    decoration: InputDecoration(
                      labelText: 'Region',
                      hintText: 'Region',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  Container(
                    child: DropDownFormField(
                      filled: true,
                      fillcolor: set1_light_blue_light,
                      //titleText: 'type',
                      hintText: 'Please choose your State',
                      value: provider["state"],
                      onSaved: (value) {
                        setState(() {
                          provider["state"] = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          provider["state"] = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      dataSource: [
                        {
                          "display": "Telangana",
                          "value": "Telangana",
                        },
                        {
                          "display": "Andhra Pradesh",
                          "value": "Andhra Pradesh",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide your City';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: cityTextEdingController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      hintText: 'City',
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
                            _signUp(
                                fullNameTextEdingController.text,
                                _selectedDate.toString(),
                                emailTextEdingController.text,
                                provider['type'],
                                mobileTextEdingController.text,
                                alternateMobileTextEdingController.text,
                                provider['beoff'],
                                passwordTextEdingController.text,
                                gothramTextEdingController.text,
                                nakshathramTextEdingController.text,
                                provider['community'],
                                regionTextEdingController.text,
                                provider['state'],
                                cityTextEdingController.text);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: Text(
                              'Sign Up',
                              style: poppinsMedium.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Already Have an Account?',
                      style: poppinsMedium.copyWith(),
                    ),
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
    );
  }
}
