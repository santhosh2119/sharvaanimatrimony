import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/conts/colors.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';
import 'package:sharvaanimatrimony/models/http_exception.dart';

import 'package:sharvaanimatrimony/providers/membersprovider.dart';
import 'package:sharvaanimatrimony/screens/home/allBrides.dart';
import 'package:sharvaanimatrimony/widgets/dropdown_formfield.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  void _search(String fromAge, String toAge, String gender) async {
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
          .search(fromAge, toAge, gender);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AllBrideGrid(data: data[1], direction: 'vertical', from: 'search')),
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
  final toageTextEdingController = TextEditingController();
  final fromageTextEdingController = TextEditingController();

  Map<String, dynamic> provider = {
    'gender': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        if (value.isEmpty || value.length < 2) {
                          return 'PLease Enter valid age from';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: fromageTextEdingController,
                      decoration: InputDecoration(
                        labelText: 'Age From',
                        hintText: '24',
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
                        if (value.isEmpty || value.length < 2) {
                          return 'PLease Enter valid Age to';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: toageTextEdingController,
                      decoration: InputDecoration(
                        labelText: 'Age To',
                        hintText: ' 30',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                   _isLoading?Center(child: CircularProgressIndicator()): ElevatedButton(
                      onPressed: () {
                        _search(fromageTextEdingController.text,
                            toageTextEdingController.text, provider['type']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          'Search',
                          style: poppinsMedium.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
