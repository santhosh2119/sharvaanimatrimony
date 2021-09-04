import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/packages/succefull.dart';
import 'package:sharvaanimatrimony/providers/membersprovider.dart';

import '../conts/dimensions.dart';
import '../conts/styles.dart';
import '../models/http_exception.dart';

class PackageUpgard extends StatefulWidget {
  final String id;
  PackageUpgard({@required this.id});
  @override
  _PackageUpgardState createState() => _PackageUpgardState();
}

class _PackageUpgardState extends State<PackageUpgard> {
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

  Future<void> _search(String id ,String mobile, String uir) async {
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
          .payment(id, mobile, uir);
           Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>Success()),
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
  final uirTextEdingController = TextEditingController();

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
                Image.asset('assets/images/logobanner.png'),
                Center(
                  child: Text(
                    'UIR Details',
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
                    if (value.length < 10) {
                      return 'MObile Must contain atleast 10 digits';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: emailTextEdingController,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    hintText: 'Mobile',
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
                      return 'PLease provide the UIR no';
                    }
                    return null;
                  },
                  controller: uirTextEdingController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'UIR',
                    hintText: 'UIR',
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
                          _search(widget.id,emailTextEdingController.text,uirTextEdingController.text);
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
