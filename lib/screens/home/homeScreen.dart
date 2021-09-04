import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';

import 'package:sharvaanimatrimony/providers/membersprovider.dart';
import 'package:sharvaanimatrimony/screens/home/allBrides.dart';

import 'package:sharvaanimatrimony/screens/home/widgets/bridegrid.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';

import '../../bannerImages.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _isInit2 = true;
  var _isLoading2 = false;
  var _isCompleted = true;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  var data;
  var datas;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      data = await Provider.of<MemberProvider>(context, listen: false)
          .fetchAndSetProducts()
          .then((value) {
        print('working');
        setState(() {
          print('provider working');
          _isLoading = false;
        });
        return value;
      });
    }
    _isInit = false;
    if (_isInit2) {
      setState(() {
        _isLoading2 = true;
      });

      datas = await Provider.of<MemberProvider>(context, listen: false)
          .freemembers()
          .then((value) {
        setState(() {
          print('provider working');
          _isLoading2 = false;
        });
        return value;
      });
    }
    _isInit2 = false;

    _isCompleted = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future _refreshPage(BuildContext context) async {
      setState(() {
        _isLoading = true;
      });

      data = await Provider.of<MemberProvider>(context, listen: false)
          .fetchAndSetProducts()
          .then((value) {
        setState(() {
          data = data;
          print('provider working');
          _isLoading = false;
        });
        return value;
      });
      print('provieder data');
      print(data[1][0].firstName);
    }
    // _isInit = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sharvaani Matrimony"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshPage(context),
        child: SingleChildScrollView(
          child: _isCompleted
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                  ],
                )
              : Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ImageSliderDemo(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Aryasvysys Brides & Grooms',
                            style: poppinsMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            ),
                          ),
                          TextButton(
                            onPressed: _isLoading
                                ? () {}
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllBrideGrid(
                                              data: data[1],
                                              direction: 'vertical')),
                                    );
                                  },
                            child: Text(
                              'View All',
                              style: poppinsMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _isLoading2
                          ? Center(child: CircularProgressIndicator())
                          : data[0]
                              ? BrideGrid(
                                  data: data[1], direction: 'horizontal')
                              : Text('no data'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Free Members',
                            style: poppinsMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            ),
                          ),
                          TextButton(
                            onPressed: _isLoading2
                                ? () {}
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllBrideGrid(
                                              data: datas[1],
                                              direction: 'vertical')),
                                    );
                                  },
                            child: Text(
                              'View All',
                              style: poppinsMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _isLoading2
                          ? Center(child: CircularProgressIndicator())
                          : datas[0]
                              ? BrideGrid(
                                  data: datas[1], direction: 'horizontal')
                              : Text('no data'),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
