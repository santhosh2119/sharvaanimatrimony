import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSliderDemo extends StatelessWidget {
  final List<dynamic> imgList = [
    'https://sharvaanimatrimony.com/uploads/home_page/slider_image/slider_image_1.jpg',
    'https://sharvaanimatrimony.com/uploads/home_page/slider_image/slider_image_2.jpg',
    'https://sharvaanimatrimony.com/uploads/home_page/slider_image/slider_image_3.jpg',
  ];

  // Future<dynamic> imgs(BuildContext context) async {
  //   final bannar = Provider.of<BannerProvider>(context).fetchAndSetProducts();

  // }

  @override
  Widget build(BuildContext context) {
    // final bannar = imgs(context);

    //final Banner = imgList;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150,
          aspectRatio: 10 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: imgList
            .map((item) => Container(
                  child: Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.28,
                    ),
                  )),
                ))
            .toList(),
      ),
    );
  }
}
