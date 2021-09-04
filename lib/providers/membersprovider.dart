import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sharvaanimatrimony/models/newmember.dart';
import 'package:sharvaanimatrimony/models/response.dart';

class MemberProvider with ChangeNotifier {
  List<Newmember> _items = [];

  List<Newmember> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  // Future fetchAndSetProducts() async {
  //   final url =
  //       Uri.parse('https://sharvaanimatrimony.com/api/customer/member.php');
  //   try {
  //     final response = await http.get(url);
  //     print(url);
  //     print('jdlasjldjalkddata');
  //     //print(response.body);
  //     print(json.decode(response.body));
  //     final extractedData = json.decode(response.body);
  //     print('jdlasjldjalkd');

  //     List<Newmember> loadedProducts = [];

  //     loadedProducts =
  //         extractedData['Catlist'].map((e) => Newmember.fromJson(e)).toList();

  //     notifyListeners();
  //     return _items = loadedProducts;
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future fetchAndSetProducts() async {
    final String id =
        '[{"current_package":"free membership","package_price":"0","payment_type":"None"}]';
    final url = Uri.parse(
        "https://www.sharvaanimatrimony.com/api/customer/premiummember.php?id='$id'");
    try {
      final response = await http.get(url);

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      print('resonse');
      print(extractedData['ResponseCode']);
      print(extractedData['Catlist']);

      print('length');
      print(extractedData['Catlist'].length);

      final List<Newmember> loadedproducts = [];

      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        bool _profile = false;
        var data;
        bool _patner = false;
        var patner;
        bool _basicinfo = false;
        var education;
        var bascic;
        if (extractedData['Catlist'][i]['education_and_career']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          education =
              jsonDecode(extractedData['Catlist'][i]['education_and_career']);
        } else {
          education = 'no data';
        }
        if (extractedData['Catlist'][i]['profile_image']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['profile_image'].toString() != null) {
          _profile = true;
          data = jsonDecode(extractedData['Catlist'][i]['profile_image']);
        } else {
          data = 'no Image';
        }
        if (extractedData['Catlist'][i]['basic_info'].toString().isNotEmpty &&
            extractedData['Catlist'][i]['basic_info'].toString() != null) {
          _basicinfo = true;
          bascic = jsonDecode(extractedData['Catlist'][i]['basic_info']);
        } else {
          bascic = 'no data';
        }
        if (extractedData['Catlist'][i]['partner_expectation']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          patner =
              jsonDecode(extractedData['Catlist'][i]['partner_expectation']);
        } else {
          patner = 'no data';
        }
        print(bascic);
        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
          memberProfileId: extractedData['Catlist'][i]['member_profile_id'],
          firstName: extractedData['Catlist'][i]['first_name'],
          lastName: extractedData['Catlist'][i]['last_name'],
          mobile: extractedData['Catlist'][i]['mobile'],
          profileImage: _profile ? data[0]['profile_image'] : data,
          gender: extractedData['Catlist'][i]['gender'],
          email: extractedData['Catlist'][i]['email'],
          height: extractedData['Catlist'][i]['height'],
          education: _patner ? education[0]['highest_education'] : education,
          occupation: _patner ? education[0]['occupation'] : education,
          income: _patner ? education[0]['annual_income'] : education,
          nakshtram: extractedData['Catlist'][i]['nakshtram'],
          gothram: extractedData['Catlist'][i]['gothram'],
          state: extractedData['Catlist'][i]['state'],
          city: extractedData['Catlist'][i]['city'],
          community: extractedData['Catlist'][i]['community'],
          region: extractedData['Catlist'][i]['region'],
          age: _basicinfo ? bascic[0]['age'] : bascic,
          maritalStatus: _basicinfo ? bascic[0]['marital_status'] : bascic,
          numberOfChildern:
              _basicinfo ? bascic[0]['number_of_children'] : bascic,
          area: _basicinfo ? bascic[0]['area'] : bascic,
          onbehalf: bascic[0]['on_behalf'],
          introduction: extractedData['Catlist'][i]['introduction'],
          generalRequirement:
              _patner ? patner[0]['general_requirement'] : patner,
          partnerage: _patner ? patner[0]['partner_age'] : patner,
          partnerheight: _patner ? patner[0]['partner_height'] : patner,
          partnerweight: _patner ? patner[0]['partner_weight'] : patner,
          partnermaritalstatus:
              _patner ? patner[0]['partner_marital_status'] : patner,

          withchildrenacceptables:
              _patner ? patner[0]['with_children_acceptables'] : patner,
          partnerresidence:
              _patner ? patner[0]['partner_country_of_residence'] : patner,

          partnerreligion: _patner ? patner[0]['partner_religion'] : patner,
          partnercaste: _patner ? patner[0]['partner_caste'] : patner,
          partnersubcaste: _patner ? patner[0]['partner_sub_caste'] : patner,
          partnercomplexions:
              _patner ? patner[0]['partner_complexion'] : patner,
          partnereducation: _patner ? patner[0]['partner_education'] : patner,
          partnerprofession: _patner ? patner[0]['partner_profession'] : patner,
          partnerdrinkinghabits:
              _patner ? patner[0]['partner_drinking_habits'] : patner,
          partnersmokinghabits:
              _patner ? patner[0]['partner_smoking_habits'] : patner,
          partnerdiet: _patner ? patner[0]['partner_diet'] : patner,
          partnerbodytype: _patner ? patner[0]['partner_body_type'] : patner,
          partnerpersonalvalue:
              _patner ? patner[0]['partner_personal_value'] : patner,
          manglik: _patner ? patner[0]['manglik'] : patner,
          partneranydisability:
              _patner ? patner[0]['partner_any_disability'] : patner,
          partnermothertongue:
              _patner ? patner[0]['partner_mother_tongue'] : patner,
          partnerfamilyvalue:
              _patner ? patner[0]['partner_family_value'] : patner,
          preferedCountry: _patner ? patner[0]['prefered_country'] : patner,
          preferedState: _patner ? patner[0]['prefered_state'] : patner,
          preferedStatus: _patner ? patner[0]['prefered_status'] : patner,
          dateOfBirth: extractedData['Catlist'][i]['date_of_birth'],

          // profileImage: data[0]['profile_image'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200.toString()) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future freemembers() async {
    final String id =
        '[{"current_package":"free membership","package_price":"0","payment_type":"None"}]';
    final url = Uri.parse(
        "https://www.sharvaanimatrimony.com/api/customer/freemember.php?id='$id'");
    try {
      final response = await http.get(url);

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      print('resonse');
      print(extractedData['ResponseCode']);
      print(extractedData['Catlist']);

      print('length');
      print(extractedData['Catlist'].length);

      final List<Newmember> loadedproducts = [];

      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        bool _profile = false;
        var data;
        bool _patner = false;
        var patner;
        bool _basicinfo = false;
        var education;
        var bascic;
        if (extractedData['Catlist'][i]['education_and_career']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          education =
              jsonDecode(extractedData['Catlist'][i]['education_and_career']);
        } else {
          education = 'no data';
        }
        if (extractedData['Catlist'][i]['profile_image']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['profile_image'].toString() != null) {
          _profile = true;
          data = jsonDecode(extractedData['Catlist'][i]['profile_image']);
        } else {
          data = 'no Image';
        }
        if (extractedData['Catlist'][i]['basic_info'].toString().isNotEmpty &&
            extractedData['Catlist'][i]['basic_info'].toString() != null) {
          _basicinfo = true;
          bascic = jsonDecode(extractedData['Catlist'][i]['basic_info']);
        } else {
          bascic = 'no data';
        }
        if (extractedData['Catlist'][i]['partner_expectation']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          patner =
              jsonDecode(extractedData['Catlist'][i]['partner_expectation']);
        } else {
          patner = 'no data';
        }
        print(bascic);
        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
          memberProfileId: extractedData['Catlist'][i]['member_profile_id'],
          firstName: extractedData['Catlist'][i]['first_name'],
          lastName: extractedData['Catlist'][i]['last_name'],
          mobile: extractedData['Catlist'][i]['mobile'],
          age: _basicinfo ? bascic[0]['age'] : bascic,
          profileImage: _profile ? data[0]['profile_image'] : data,
          gender: extractedData['Catlist'][i]['gender'],
          email: extractedData['Catlist'][i]['email'],
          height: extractedData['Catlist'][i]['height'],
          education: _patner ? education[0]['highest_education'] : education,
          occupation: _patner ? education[0]['occupation'] : education,
          income: _patner ? education[0]['annual_income'] : education,
          nakshtram: extractedData['Catlist'][i]['nakshtram'],
          gothram: extractedData['Catlist'][i]['gothram'],
          state: extractedData['Catlist'][i]['state'],
          city: extractedData['Catlist'][i]['city'],
          community: extractedData['Catlist'][i]['community'],
          region: extractedData['Catlist'][i]['region'],
          maritalStatus: _basicinfo ? bascic[0]['marital_status'] : bascic,
          numberOfChildern:
              _basicinfo ? bascic[0]['number_of_children'] : bascic,
          area: _basicinfo ? bascic[0]['area'] : bascic,
          onbehalf: bascic[0]['on_behalf'],
          introduction: extractedData['Catlist'][i]['introduction'],
          generalRequirement:
              _patner ? patner[0]['general_requirement'] : patner,
          partnerage: _patner ? patner[0]['partner_age'] : patner,
          partnerheight: _patner ? patner[0]['partner_height'] : patner,
          partnerweight: _patner ? patner[0]['partner_weight'] : patner,
          partnermaritalstatus:
              _patner ? patner[0]['partner_marital_status'] : patner,

          withchildrenacceptables:
              _patner ? patner[0]['with_children_acceptables'] : patner,
          partnerresidence:
              _patner ? patner[0]['partner_country_of_residence'] : patner,

          partnerreligion: _patner ? patner[0]['partner_religion'] : patner,
          partnercaste: _patner ? patner[0]['partner_caste'] : patner,
          partnersubcaste: _patner ? patner[0]['partner_sub_caste'] : patner,
          partnercomplexions:
              _patner ? patner[0]['partner_complexion'] : patner,
          partnereducation: _patner ? patner[0]['partner_education'] : patner,
          partnerprofession: _patner ? patner[0]['partner_profession'] : patner,
          partnerdrinkinghabits:
              _patner ? patner[0]['partner_drinking_habits'] : patner,
          partnersmokinghabits:
              _patner ? patner[0]['partner_smoking_habits'] : patner,
          partnerdiet: _patner ? patner[0]['partner_diet'] : patner,
          partnerbodytype: _patner ? patner[0]['partner_body_type'] : patner,
          partnerpersonalvalue:
              _patner ? patner[0]['partner_personal_value'] : patner,
          manglik: _patner ? patner[0]['manglik'] : patner,
          partneranydisability:
              _patner ? patner[0]['partner_any_disability'] : patner,
          partnermothertongue:
              _patner ? patner[0]['partner_mother_tongue'] : patner,
          partnerfamilyvalue:
              _patner ? patner[0]['partner_family_value'] : patner,
          preferedCountry: _patner ? patner[0]['prefered_country'] : patner,
          preferedState: _patner ? patner[0]['prefered_state'] : patner,
          preferedStatus: _patner ? patner[0]['prefered_status'] : patner,
          dateOfBirth: extractedData['Catlist'][i]['date_of_birth'],

          // profileImage: data[0]['profile_image'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200.toString()) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future passwordreset(String id, String password) async {
    final url = Uri.parse(
        'https://sharvaanimatrimony.com/api/customer/updatepassword.php');
    try {
      final response = await http.post(url,
          body: json.encode({
            "id": id,
            "password": password,
          }));

      print(id);
      print(password);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Newmember> loadedproducts = [];
      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future payment(String id, String mobile, String uir) async {
    final url = Uri.parse(
        'https://sharvaanimatrimony.com/api/customer/mobile_payments.php');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "id": id,
            "phone": mobile,
            "uir_number": uir,
          },
        ),
      );

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Newmember> loadedproducts = [];
      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future emailid(String id) async {
    final url = Uri.parse(
        'https://sharvaanimatrimony.com/api/customer/forgetpasswordemail.php?id=$id');
    try {
      final response = await http.get(url);

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Newmember> loadedproducts = [];
      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future byId(String id) async {
    final url = Uri.parse(
        'https://www.sharvaanimatrimony.com/api/customer/profile.php?id=$id');
    try {
      final response = await http.get(url);

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      print('resonse');
      print(extractedData['ResponseCode']);
      print(extractedData['Catlist'][0]['member_id']);
      print(extractedData['Catlist'][0]['profile_image']);
      print('length');
      print(extractedData['Catlist'].length);

      final List<Newmember> loadedproducts = [];

      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        bool _profile = false;
        var data;
        bool _patner = false;
        var patner;
        bool _basicinfo = false;
        var bascic;
        var education;
        if (extractedData['Catlist'][i]['profile_image']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['profile_image'].toString() != null) {
          _profile = true;
          data = jsonDecode(extractedData['Catlist'][i]['profile_image']);
        } else {
          data = 'no Image';
        }
        if (extractedData['Catlist'][i]['basic_info'].toString().isNotEmpty &&
            extractedData['Catlist'][i]['basic_info'].toString() != null) {
          _basicinfo = true;
          bascic = jsonDecode(extractedData['Catlist'][i]['basic_info']);
        } else {
          bascic = 'no data';
        }
        if (extractedData['Catlist'][i]['partner_expectation']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          patner =
              jsonDecode(extractedData['Catlist'][i]['partner_expectation']);
        } else {
          patner = 'no data';
        }
        print(bascic);
        if (extractedData['Catlist'][i]['education_and_career']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          education =
              jsonDecode(extractedData['Catlist'][i]['education_and_career']);
        } else {
          education = 'no data';
        }
        print(bascic);

        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
          memberProfileId: extractedData['Catlist'][i]['member_profile_id'],
          firstName: extractedData['Catlist'][i]['first_name'],
          lastName: extractedData['Catlist'][i]['last_name'],
          mobile: extractedData['Catlist'][i]['mobile'],
          profileImage: _profile ? data[0]['profile_image'] : data,
          gender: extractedData['Catlist'][i]['gender'],
          email: extractedData['Catlist'][i]['email'],
          height: extractedData['Catlist'][i]['height'],
          nakshtram: extractedData['Catlist'][i]['nakshtram'],
          age: _basicinfo ? bascic[0]['age'] : bascic,
          gothram: extractedData['Catlist'][i]['gothram'],
          state: extractedData['Catlist'][i]['state'],
          city: extractedData['Catlist'][i]['city'],
          community: extractedData['Catlist'][i]['community'],
          region: extractedData['Catlist'][i]['region'],
          maritalStatus: _basicinfo ? bascic[0]['marital_status'] : bascic,
          numberOfChildern:
              _basicinfo ? bascic[0]['number_of_children'] : bascic,
          area: _basicinfo ? bascic[0]['area'] : bascic,
          education: _patner ? education[0]['highest_education'] : education,
          occupation: _patner ? education[0]['occupation'] : education,
          income: _patner ? education[0]['annual_income'] : education,

          onbehalf: bascic[0]['on_behalf'],
          introduction: extractedData['Catlist'][i]['introduction'],
          generalRequirement:
              _patner ? patner[0]['general_requirement'] : patner,
          partnerage: _patner ? patner[0]['partner_age'] : patner,
          partnerheight: _patner ? patner[0]['partner_height'] : patner,
          partnerweight: _patner ? patner[0]['partner_weight'] : patner,
          partnermaritalstatus:
              _patner ? patner[0]['partner_marital_status'] : patner,

          withchildrenacceptables:
              _patner ? patner[0]['with_children_acceptables'] : patner,
          partnerresidence:
              _patner ? patner[0]['partner_country_of_residence'] : patner,

          partnerreligion: _patner ? patner[0]['partner_religion'] : patner,
          partnercaste: _patner ? patner[0]['partner_caste'] : patner,
          partnersubcaste: _patner ? patner[0]['partner_sub_caste'] : patner,
          partnercomplexions:
              _patner ? patner[0]['partner_complexion'] : patner,
          partnereducation: _patner ? patner[0]['partner_education'] : patner,
          partnerprofession: _patner ? patner[0]['partner_profession'] : patner,
          partnerdrinkinghabits:
              _patner ? patner[0]['partner_drinking_habits'] : patner,
          partnersmokinghabits:
              _patner ? patner[0]['partner_smoking_habits'] : patner,
          partnerdiet: _patner ? patner[0]['partner_diet'] : patner,
          partnerbodytype: _patner ? patner[0]['partner_body_type'] : patner,
          partnerpersonalvalue:
              _patner ? patner[0]['partner_personal_value'] : patner,
          manglik: _patner ? patner[0]['manglik'] : patner,
          partneranydisability:
              _patner ? patner[0]['partner_any_disability'] : patner,
          partnermothertongue:
              _patner ? patner[0]['partner_mother_tongue'] : patner,
          partnerfamilyvalue:
              _patner ? patner[0]['partner_family_value'] : patner,
          preferedCountry: _patner ? patner[0]['prefered_country'] : patner,
          preferedState: _patner ? patner[0]['prefered_state'] : patner,
          preferedStatus: _patner ? patner[0]['prefered_status'] : patner,
          dateOfBirth: extractedData['Catlist'][i]['date_of_birth'],

          // profileImage: data[0]['profile_image'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200.toString()) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future search(String fromAge, String toAge, String gender) async {
    print('search details');

    print(fromAge);
    print(toAge);
    print(gender);
    final url = Uri.parse(
        'https://www.sharvaanimatrimony.com/api/customer/search.php?fromAge=$fromAge&toAge=$toAge&gender=$gender');
    try {
      final response = await http.get(url);

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      print('resonse');
      print(extractedData['ResponseCode']);
      print(extractedData['Catlist']);

      print('length');
      print(extractedData['Catlist'].length);

      final List<Newmember> loadedproducts = [];

      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        bool _profile = false;
        var data;
        bool _patner = false;
        var patner;
        bool _basicinfo = false;
        var bascic;
        var education;
        if (extractedData['Catlist'][i]['education_and_career']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          education =
              jsonDecode(extractedData['Catlist'][i]['education_and_career']);
        } else {
          education = 'no data';
        }
        if (extractedData['Catlist'][i]['profile_image']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['profile_image'].toString() != null) {
          _profile = true;
          data = jsonDecode(extractedData['Catlist'][i]['profile_image']);
        } else {
          data = 'no Image';
        }
        if (extractedData['Catlist'][i]['basic_info'].toString().isNotEmpty &&
            extractedData['Catlist'][i]['basic_info'].toString() != null) {
          _basicinfo = true;
          bascic = jsonDecode(extractedData['Catlist'][i]['basic_info']);
        } else {
          bascic = 'no data';
        }
        if (extractedData['Catlist'][i]['partner_expectation']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          patner =
              jsonDecode(extractedData['Catlist'][i]['partner_expectation']);
        } else {
          patner = 'no data';
        }
        print(bascic);
        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
          memberProfileId: extractedData['Catlist'][i]['member_profile_id'],
          firstName: extractedData['Catlist'][i]['first_name'],
          lastName: extractedData['Catlist'][i]['last_name'],
          mobile: extractedData['Catlist'][i]['mobile'],
          profileImage: _profile ? data[0]['profile_image'] : data,
          gender: extractedData['Catlist'][i]['gender'],
          age: _basicinfo ? bascic[0]['age'] : bascic,
          email: extractedData['Catlist'][i]['email'],
          height: extractedData['Catlist'][i]['height'],
          education: _patner ? education[0]['highest_education'] : education,
          occupation: _patner ? education[0]['occupation'] : education,
          income: _patner ? education[0]['annual_income'] : education,
          nakshtram: extractedData['Catlist'][i]['nakshtram'],
          gothram: extractedData['Catlist'][i]['gothram'],
          state: extractedData['Catlist'][i]['state'],
          city: extractedData['Catlist'][i]['city'],
          community: extractedData['Catlist'][i]['community'],
          region: extractedData['Catlist'][i]['region'],
          maritalStatus: _basicinfo ? bascic[0]['marital_status'] : bascic,
          numberOfChildern:
              _basicinfo ? bascic[0]['number_of_children'] : bascic,
          area: _basicinfo ? bascic[0]['area'] : bascic,
          onbehalf: bascic[0]['on_behalf'],
          introduction: extractedData['Catlist'][i]['introduction'],
          generalRequirement:
              _patner ? patner[0]['general_requirement'] : patner,
          partnerage: _patner ? patner[0]['partner_age'] : patner,
          partnerheight: _patner ? patner[0]['partner_height'] : patner,
          partnerweight: _patner ? patner[0]['partner_weight'] : patner,
          partnermaritalstatus:
              _patner ? patner[0]['partner_marital_status'] : patner,

          withchildrenacceptables:
              _patner ? patner[0]['with_children_acceptables'] : patner,
          partnerresidence:
              _patner ? patner[0]['partner_country_of_residence'] : patner,

          partnerreligion: _patner ? patner[0]['partner_religion'] : patner,
          partnercaste: _patner ? patner[0]['partner_caste'] : patner,
          partnersubcaste: _patner ? patner[0]['partner_sub_caste'] : patner,
          partnercomplexions:
              _patner ? patner[0]['partner_complexion'] : patner,
          partnereducation: _patner ? patner[0]['partner_education'] : patner,
          partnerprofession: _patner ? patner[0]['partner_profession'] : patner,
          partnerdrinkinghabits:
              _patner ? patner[0]['partner_drinking_habits'] : patner,
          partnersmokinghabits:
              _patner ? patner[0]['partner_smoking_habits'] : patner,
          partnerdiet: _patner ? patner[0]['partner_diet'] : patner,
          partnerbodytype: _patner ? patner[0]['partner_body_type'] : patner,
          partnerpersonalvalue:
              _patner ? patner[0]['partner_personal_value'] : patner,
          manglik: _patner ? patner[0]['manglik'] : patner,
          partneranydisability:
              _patner ? patner[0]['partner_any_disability'] : patner,
          partnermothertongue:
              _patner ? patner[0]['partner_mother_tongue'] : patner,
          partnerfamilyvalue:
              _patner ? patner[0]['partner_family_value'] : patner,
          preferedCountry: _patner ? patner[0]['prefered_country'] : patner,
          preferedState: _patner ? patner[0]['prefered_state'] : patner,
          preferedStatus: _patner ? patner[0]['prefered_status'] : patner,
          dateOfBirth: extractedData['Catlist'][i]['date_of_birth'],

          // profileImage: data[0]['profile_image'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200.toString()) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future uploadImage(String image, String id) async {
    final url = Uri.parse(
        'https://sharvaanimatrimony.com/api/customer/imageupload.php');
    try {
      final response = await http.post(url,
          body: json.encode({
            "id": id,
            "image": image,
            //   "imageBase64" : image,
            //   "usecase" : usecase,
          }));
      print(image);
      print(id);
      var result = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode < 400) {
        notifyListeners();

        return [true, result];
      } else {
        return [false, result];
      }
    } catch (error) {
      print("in catch imageUpload");
      throw error;
    }
  }

  Future list(String urls, String id) async {
    final url = Uri.parse(
        'https://www.sharvaanimatrimony.com/api/customer/$urls.php?id=$id');
    print("url");
    print(url);
    try {
      final response = await http.get(url);

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      print('resonse');
      print(extractedData['ResponseCode']);
      print(extractedData['Catlist']);

      print('length');
      print(extractedData['Catlist'].length);

      final List<Newmember> loadedproducts = [];

      for (int i = 0; i < extractedData['Catlist'].length; i++) {
        bool _profile = false;
        var data;
        bool _patner = false;
        var patner;
        bool _basicinfo = false;
        var bascic;
        var education;
        if (extractedData['Catlist'][i]['education_and_career']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          education =
              jsonDecode(extractedData['Catlist'][i]['education_and_career']);
        } else {
          education = 'no data';
        }
        if (extractedData['Catlist'][i]['profile_image']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['profile_image'].toString() != null) {
          _profile = true;
          data = jsonDecode(extractedData['Catlist'][i]['profile_image']);
        } else {
          data = 'no Image';
        }
        if (extractedData['Catlist'][i]['basic_info'].toString().isNotEmpty &&
            extractedData['Catlist'][i]['basic_info'].toString() != null) {
          _basicinfo = true;
          bascic = jsonDecode(extractedData['Catlist'][i]['basic_info']);
        } else {
          bascic = 'no data';
        }
        if (extractedData['Catlist'][i]['partner_expectation']
                .toString()
                .isNotEmpty &&
            extractedData['Catlist'][i]['partner_expectation'].toString() !=
                null) {
          _patner = true;
          patner =
              jsonDecode(extractedData['Catlist'][i]['partner_expectation']);
        } else {
          patner = 'no data';
        }
        print(bascic);
        loadedproducts.add(Newmember(
          memberId: extractedData['Catlist'][i]['member_id'],
          memberProfileId: extractedData['Catlist'][i]['member_profile_id'],
          firstName: extractedData['Catlist'][i]['first_name'],
          lastName: extractedData['Catlist'][i]['last_name'],
          mobile: extractedData['Catlist'][i]['mobile'],
          profileImage: _profile ? data[0]['profile_image'] : data,
          gender: extractedData['Catlist'][i]['gender'],
          age: _basicinfo ? bascic[0]['age'] : bascic,
          email: extractedData['Catlist'][i]['email'],
          height: extractedData['Catlist'][i]['height'],
          education: _patner ? education[0]['highest_education'] : education,
          occupation: _patner ? education[0]['occupation'] : education,
          income: _patner ? education[0]['annual_income'] : education,
          nakshtram: extractedData['Catlist'][i]['nakshtram'],
          gothram: extractedData['Catlist'][i]['gothram'],
          state: extractedData['Catlist'][i]['state'],
          city: extractedData['Catlist'][i]['city'],
          community: extractedData['Catlist'][i]['community'],
          region: extractedData['Catlist'][i]['region'],
          maritalStatus: _basicinfo ? bascic[0]['marital_status'] : bascic,
          numberOfChildern:
              _basicinfo ? bascic[0]['number_of_children'] : bascic,
          area: _basicinfo ? bascic[0]['area'] : bascic,
          onbehalf: bascic[0]['on_behalf'],
          introduction: extractedData['Catlist'][i]['introduction'],
          generalRequirement:
              _patner ? patner[0]['general_requirement'] : patner,
          partnerage: _patner ? patner[0]['partner_age'] : patner,
          partnerheight: _patner ? patner[0]['partner_height'] : patner,
          partnerweight: _patner ? patner[0]['partner_weight'] : patner,
          partnermaritalstatus:
              _patner ? patner[0]['partner_marital_status'] : patner,

          withchildrenacceptables:
              _patner ? patner[0]['with_children_acceptables'] : patner,
          partnerresidence:
              _patner ? patner[0]['partner_country_of_residence'] : patner,

          partnerreligion: _patner ? patner[0]['partner_religion'] : patner,
          partnercaste: _patner ? patner[0]['partner_caste'] : patner,
          partnersubcaste: _patner ? patner[0]['partner_sub_caste'] : patner,
          partnercomplexions:
              _patner ? patner[0]['partner_complexion'] : patner,
          partnereducation: _patner ? patner[0]['partner_education'] : patner,
          partnerprofession: _patner ? patner[0]['partner_profession'] : patner,
          partnerdrinkinghabits:
              _patner ? patner[0]['partner_drinking_habits'] : patner,
          partnersmokinghabits:
              _patner ? patner[0]['partner_smoking_habits'] : patner,
          partnerdiet: _patner ? patner[0]['partner_diet'] : patner,
          partnerbodytype: _patner ? patner[0]['partner_body_type'] : patner,
          partnerpersonalvalue:
              _patner ? patner[0]['partner_personal_value'] : patner,
          manglik: _patner ? patner[0]['manglik'] : patner,
          partneranydisability:
              _patner ? patner[0]['partner_any_disability'] : patner,
          partnermothertongue:
              _patner ? patner[0]['partner_mother_tongue'] : patner,
          partnerfamilyvalue:
              _patner ? patner[0]['partner_family_value'] : patner,
          preferedCountry: _patner ? patner[0]['prefered_country'] : patner,
          preferedState: _patner ? patner[0]['prefered_state'] : patner,
          preferedStatus: _patner ? patner[0]['prefered_status'] : patner,
          dateOfBirth: extractedData['Catlist'][i]['date_of_birth'],

          // profileImage: data[0]['profile_image'],
        ));
      }
      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200.toString()) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future addlist(String urls, String id, String memberid) async {
    final url = Uri.parse(
        'https://www.sharvaanimatrimony.com/api/customer/$urls.php?id=$id&memberid=$memberid');
    print("url");
    print(url);
    try {
      final response = await http.get(url);

      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      print('resonse');
      print(extractedData['ResponseCode']);

      final List<ResponseData> loadedproducts = [];

      loadedproducts.add(ResponseData(
        result: extractedData['Result'],
        responseCode: extractedData['ResponseCode'],
        responseMsg: extractedData['ResponseMsg'],
        // profileImage: data[0]['profile_image'],
      ));

      notifyListeners();
      // return loadedproducts;
      if (extractedData['ResponseCode'] == 200.toString()) {
        return [true, loadedproducts];
      } else {
        return [false, loadedproducts];
      }
    } catch (error) {
      throw error;
    }
  }

  Future update(
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
    String pcom,
  ) async {
    final url = Uri.parse(
        'https://www.sharvaanimatrimony.com/api/customer/update_profile.php');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "id": id,
            "introduction": introduction,
            "edu": highEducation,
            "occupation": occupation,
            "age": age,
            "behalf": behalf,
            "annual_income": income,
            "nakshtram": nakshathram,
            "gothram": gothram,
            "state": state,
            "city": city,
            "general_requirement": gReq,
            "partner_height": height,
            "partner_education": pEducation,
            "partner_profession": pProf,
            "partner_complexion": pcom,
          },
        ),
      );
      print(id);
      print(introduction);
      print(highEducation);
      print(occupation);
      print(age);
      print(behalf);
      print(income);
      print(nakshathram);

      print(gothram);
      print(state);
      print(city);
      print(gReq);
      print(height);
      print(pEducation);
      print(pProf);
      print(pcom);

      print("reso");
      print(response.body);
      var result = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode < 400) {
        notifyListeners();

        return [true, result];
      } else {
        return [false, result];
      }
    } catch (error) {
      throw error;
    }
  }
}
