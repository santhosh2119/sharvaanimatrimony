import 'package:flutter/material.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/providers/membersprovider.dart';

class EditProfile extends StatefulWidget {
  final String id;
  final String introduction;
  final String age;
  final String behalf;
  final String highEducaation;
  final String occupation;
  final String annualIncome;
  final String nakshathram;
  final String gothram;
  final String state;
  final String city;

  final String gReq;
  final String rHeight;
  final String rEdu;
  final String rprof;
  final String rcom;
  EditProfile(
      {@required this.id,
      @required this.introduction,
      @required this.age,
      @required this.behalf,
      @required this.highEducaation,
      @required this.occupation,
      @required this.annualIncome,
      @required this.nakshathram,
      @required this.gothram,
      @required this.state,
      @required this.city,
      @required this.gReq,
      @required this.rHeight,
      @required this.rEdu,
      @required this.rprof,
      @required this.rcom});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _isLoading = false;
  var datass;
  Future adddata(
      String id,
      String introduction,
      String highEducation,
      String occupation,
      String age,
      String behalf,
      String income,
      String nakshathram,
      String gothram,
      String state,
      String city,
      String gReq,
      String height,
      String pEducation,
      String pProf,
      String pcom) async {
    print('printing token');

    setState(() {
      _isLoading = true;
    });

    datass = await Provider.of<MemberProvider>(context, listen: false)
        .update(
            id,
            introduction,
            highEducation,
            occupation,
            age,
            behalf,
            income,
            nakshathram,
            gothram,
            state,
            city,
            gReq,
            height,
            pEducation,
            pProf,
            pcom)
        .then((value) {
      print('provichekce');
      setState(() {
        print('provider working');
        _isLoading = false;
      });
      print("interetere");
      print(value[0]);
      if (value[0] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Updated Successfully"),
          duration: Duration(seconds: 3),
        ));
        return value;
      } else {
        return null;
      }
    });
  }

  final introcontroller = TextEditingController();
  final behalfcontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final educontroller = TextEditingController();
  final occucontroller = TextEditingController();
  final incomecontroller = TextEditingController();
  final nakshatramcontroller = TextEditingController();
  final gothramcontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final greqcontroller = TextEditingController();
  final heightcontroller = TextEditingController();
  final patnereducationcontroller = TextEditingController();
  final patnerprofcontroller = TextEditingController();
  final patnercomcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    introcontroller.text = widget.introduction;
    agecontroller.text = widget.age;
    behalfcontroller.text = widget.behalf;
    educontroller.text = widget.highEducaation;
    occucontroller.text = widget.occupation;
    incomecontroller.text = widget.annualIncome;
    nakshatramcontroller.text = widget.nakshathram;
    gothramcontroller.text = widget.gothram;
    statecontroller.text = widget.state;
    citycontroller.text = widget.city;
    greqcontroller.text = widget.gReq;
    heightcontroller.text = widget.rHeight;
    patnereducationcontroller.text = widget.rEdu;
    patnerprofcontroller.text = widget.rprof;
    patnercomcontroller.text = widget.rcom;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Introduction';
                    }
                    return null;
                  },
                  controller: introcontroller,
                  // initialValue: widget.introduction,
                  decoration: InputDecoration(
                    labelText: 'Introduction',
                    hintText: 'Introduction',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: agecontroller,
                  // initialValue: widget.age,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide Age';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Age',
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: educontroller,
                  // initialValue: widget.highEducaation,
                  validator: (value) {
                    if (value.isEmpty || value.length < 2) {
                      return 'Please provide Highest Education';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Highest Education',
                    hintText: 'Highest Education',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  // initialValue: widget.occupation,
                  controller: occucontroller,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Occupation';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Occupation',
                    hintText: 'Occupation',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  // initialValue: widget.annualIncome,
                  controller: incomecontroller,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Annual Income';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Annual Income',
                    hintText: 'Annual Income',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: nakshatramcontroller,
                  // initialValue: widget.nakshathram,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Nakshatharm';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nakshathram',
                    hintText: 'Nakshathram',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  controller: gothramcontroller,
                  // initialValue: widget.gothram,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Gothram';
                    }
                    return null;
                  },
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
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: statecontroller,
                  // initialValue: widget.state,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide State';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'State',
                    hintText: 'State',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  controller: citycontroller,
                  // initialValue: widget.city,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide City';
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: greqcontroller,
                  // initialValue: widget.gReq,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide General Requirement';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'General Requirement',
                    hintText: 'General Requiement',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  controller: heightcontroller,
                  textInputAction: TextInputAction.done,
                  // initialValue: widget.rHeight,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Height';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Height',
                    hintText: 'Height',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  controller: patnereducationcontroller,
                  textInputAction: TextInputAction.done,
                  // initialValue: widget.rEdu,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Education';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Patner Education',
                    hintText: 'Patner Education',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: patnerprofcontroller,
                  // initialValue: widget.rprof,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Profession';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Patner Profession',
                    hintText: 'Patner Profession',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: patnercomcontroller,
                  // initialValue: widget.rcom,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please provide Complexion';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Complexion',
                    hintText: 'Complexion',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                ElevatedButton(
                  onPressed: () {
                    adddata(
                      widget.id,
                      introcontroller.text,
                      educontroller.text,
                      occucontroller.text,
                      agecontroller.text,
                      behalfcontroller.text,
                      incomecontroller.text,
                      nakshatramcontroller.text,
                      gothramcontroller.text,
                      statecontroller.text,
                      citycontroller.text,
                      greqcontroller.text,
                      heightcontroller.text,
                      patnereducationcontroller.text,
                      patnerprofcontroller.text,
                      patnercomcontroller.text,
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
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
