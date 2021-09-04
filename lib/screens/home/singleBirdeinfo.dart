import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';

import 'package:sharvaanimatrimony/providers/membersprovider.dart';
import 'package:sharvaanimatrimony/screens/home/allBrides.dart';
import 'package:sharvaanimatrimony/screens/home/imageView.dart';
import 'package:sharvaanimatrimony/screens/profile/editProfile.dart';

import 'package:sharvaanimatrimony/screens/profile/labelAndText.dart';

class SingleBrideInfo extends StatefulWidget {
  final data;
  final type;
  SingleBrideInfo({@required this.data, @required this.type});

  @override
  _SingleBrideInfoState createState() => _SingleBrideInfoState();
}

class _SingleBrideInfoState extends State<SingleBrideInfo> {
  bool _isLoading = false;
  var datas;
  var datass;
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

  Future getdata(String urls, String token) async {
    print('printing token');
    print(token);
    setState(() {
      _isLoading = true;
    });

    datas = await Provider.of<MemberProvider>(context, listen: false)
        .list(urls, token)
        .then((value) {
      print('provichekce');
      setState(() {
        print('provider working');
        _isLoading = false;
      });
      return value;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (contxt) => AllBrideGrid(
                data: datas[1],
                direction: 'vertical',
                from: urls,
              )),
    );
  }

  Future adddata(String urls, String uid, String memberid) async {
    print('printing token');

    setState(() {
      _isLoading = true;
    });

    datass = await Provider.of<MemberProvider>(context, listen: false)
        .addlist(urls, uid, memberid)
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
          content: Text("Added Successfully"),
          duration: Duration(seconds: 3),
        ));
        return value;
      } else {
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: widget.type == 'home'
                ? AppBar(
                    title: Text('Info'),
                  )
                : AppBar(
                    title: Text('Profile'),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                      id: widget.data.memberId,
                                      introduction: widget.data.introduction,
                                      age: widget.data.age,
                                      behalf: widget.data.onbehalf,
                                      highEducaation: widget.data.education,
                                      occupation: widget.data.occupation,
                                      annualIncome: widget.data.income,
                                      nakshathram: widget.data.nakshtram,
                                      gothram: widget.data.gothram,
                                      state: widget.data.state,
                                      city: widget.data.city,
                                      gReq: widget.data.generalRequirement,
                                      rHeight: widget.data.partnerheight,
                                      rEdu: widget.data.partnereducation,
                                      rprof: widget.data. partnerprofession,
                                      rcom: widget.data.partnercomplexions)),
                            );
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageView(
                                      url: widget.data.profileImage,
                                      name: widget.data.firstName,
                                    ),
                                  ));
                            },
                            child: Image.network(widget.data.profileImage ==
                                    'no Image'
                                ? "https://sharvaanimatrimony.com/uploads/profile_image/default.jpg"
                                : "https://sharvaanimatrimony.com/uploads/profile_image/" +
                                    widget.data.profileImage),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                widget.type == 'home'
                                    ? adddata('addinterest', uid,
                                        widget.data.memberId)
                                    : getdata('interest', uid);
                              },
                              icon: Icon(
                                Icons.favorite,
                              ),
                            ),
                            Text(
                              'Interest',
                              style: poppinsMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  widget.type == 'home'
                                      ? adddata('addshortlist', uid,
                                          widget.data.memberId)
                                      : getdata('shortlist', uid);
                                },
                                icon: Icon(Icons.list)),
                            Text(
                              'Short List',
                              style: poppinsMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  widget.type == 'home'
                                      ? adddata('addfollow', uid,
                                          widget.data.memberId)
                                      : getdata('followlist', uid);
                                },
                                icon: Icon(Icons.star)),
                            Text(
                              'Follow',
                              style: poppinsMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  widget.type == 'home'
                                      ? adddata('addignore', uid,
                                          widget.data.memberId)
                                      : getdata('igonre', uid);
                                },
                                icon: Icon(Icons.hide_source)),
                            Text(
                              'Ignore',
                              style: poppinsMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      "Quick Information",
                      style: poppinsMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      ),
                    ),
                    Lables(
                        lable: 'Member Id', name: widget.data.memberProfileId),
                    Row(
                      children: [
                        Lables(
                            lable: 'Last Name',
                            name: widget.data.lastName == null
                                ? ''
                                : widget.data.lastName),
                        Spacer(),
                        Lables(
                          lable: 'First Name',
                          name: widget.data.firstName,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'Gender',
                            name: widget.data.gender == 1.toString()
                                ? 'Male'
                                : 'Female'),
                        Spacer(),
                        Lables(
                          lable: 'Age',
                          name: widget.data.age,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'Marital Status',
                            name: widget.data.maritalStatus),
                        Spacer(),
                        Lables(
                          lable: 'Number of Children',
                          name: widget.data.numberOfChildern,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(lable: 'Area', name: widget.data.area),
                        Spacer(),
                        Lables(
                          lable: 'Date of Birth',
                          name: widget.data.dateOfBirth,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'On Behalf',
                            name: widget.data.onbehalf == 1.toString()
                                ? 'Self'
                                : widget.data.onbehalf == 2.toString()
                                    ? 'Daughter/Son'
                                    : widget.data.onbehalf == 3.toString()
                                        ? 'Sister'
                                        : widget.data.onbehalf == 4.toString()
                                            ? 'Brother'
                                            : 'Frined'),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Divider(),
                    Text(
                      "Profile Information",
                      style: poppinsMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                          lable: 'Introduction',
                          name: widget.data.introduction,
                          height: 0.7,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Divider(),
                    Text(
                      "Partner Expectation",
                      style: poppinsMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'General Requirement',
                            name: widget.data.generalRequirement),
                        Spacer(),
                        Lables(
                          lable: 'Age',
                          name: widget.data.partnerage == null
                              ? ''
                              : widget.data.partnerage,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                          lable: 'Height',
                          name: widget.data.partnerheight == null
                              ? ''
                              : widget.data.partnerheight,
                        ),
                        Spacer(),
                        Lables(
                          lable: 'Weight',
                          name: widget.data.partnerweight == null
                              ? ''
                              : widget.data.partnerweight,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Lables(
                            lable: 'Marital Status',
                            name: widget.data.partnermaritalstatus == null
                                ? ''
                                : widget.data.partnermaritalstatus ==
                                        1.toString()
                                    ? 'Never Married'
                                    : widget.data.partnermaritalstatus ==
                                            2.toString()
                                        ? 'Married'
                                        : widget.data.partnermaritalstatus ==
                                                3.toString()
                                            ? 'Divorced'
                                            : widget.data
                                                        .partnermaritalstatus ==
                                                    4.toString()
                                                ? 'Separated '
                                                : 'Widowed'),
                        Spacer(),
                        Lables(
                          lable: 'With Childern Acceptables',
                          name: widget.data.withchildrenacceptables == null
                              ? ''
                              : widget.data.withchildrenacceptables,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'Country Of Residence',
                            name: widget.data.partnerresidence == null
                                ? ''
                                : widget.data.partnerresidence),
                        Spacer(),
                        Lables(
                          lable: 'Religion',
                          name: widget.data.partnerreligion == null
                              ? ''
                              : widget.data.partnerreligion,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'Caste/Sect',
                            name: widget.data.partnercaste == null
                                ? ''
                                : widget.data.partnercaste),
                        Spacer(),
                        Lables(
                          lable: 'Sub Caste',
                          name: widget.data.partnersubcaste == null
                              ? ''
                              : widget.data.partnersubcaste,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'Education',
                            name: widget.data.education == null
                                ? ''
                                : widget.data.education),
                        Spacer(),
                        Lables(
                          lable: 'Profession',
                          name: widget.data.occupation == null
                              ? ''
                              : widget.data.occupation,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'Drinking Habits',
                            name: widget.data.partnerdrinkinghabits == null
                                ? ''
                                : widget.data.partnerdrinkinghabits),
                        Spacer(),
                        Lables(
                          lable: 'Smoking Habits',
                          name: widget.data.partnersmokinghabits == null
                              ? ''
                              : widget.data.partnersmokinghabits,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                          lable: 'Diet',
                          name: widget.data.partnerdiet == null
                              ? ''
                              : widget.data.partnerdiet,
                        ),
                        Spacer(),
                        Lables(
                          lable: 'Body Type',
                          name: widget.data.partnerbodytype == null
                              ? ''
                              : widget.data.partnerbodytype,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                          lable: 'Personal Value',
                          name: widget.data.partnerpersonalvalue == null
                              ? ''
                              : widget.data.partnerpersonalvalue,
                        ),
                        Spacer(),
                        Lables(
                          lable: 'Manglik',
                          name: widget.data.manglik == null
                              ? ''
                              : widget.data.manglik,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                          lable: 'Any Disability',
                          name: widget.data.partneranydisability == null
                              ? ''
                              : widget.data.partneranydisability,
                        ),
                        Spacer(),
                        Lables(
                          lable: 'Mother Tongue',
                          name: widget.data.partnermothertongue == null
                              ? ''
                              : widget.data.partnermothertongue,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                          lable: 'Family Value',
                          name: widget.data.partnerfamilyvalue == null
                              ? ''
                              : widget.data.partnerfamilyvalue,
                        ),
                        Spacer(),
                        Lables(
                          lable: 'Prefered Country',
                          name: widget.data.preferedCountry == null
                              ? ''
                              : widget.data.preferedCountry,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                          lable: 'Prefered State',
                          name: widget.data.preferedState == null
                              ? ''
                              : widget.data.preferedState,
                        ),
                        Spacer(),
                        Lables(
                          lable: 'Prefered Status',
                          name: widget.data.preferedStatus == null
                              ? ''
                              : widget.data.preferedStatus,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Lables(
                            lable: 'Complexion',
                            name: widget.data.partnercomplexions == null
                                ? ''
                                : widget.data.partnercomplexions),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
