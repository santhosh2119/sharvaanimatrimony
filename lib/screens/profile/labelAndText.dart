import 'package:flutter/material.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';

class Lables extends StatelessWidget {
  final String lable;
  final String name;
  final double height;
  final Color color;
  Lables({@required this.lable, @required this.name, this.height = 0.45, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: MediaQuery.of(context).size.width * height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lable,
            style: poppinsMedium.copyWith(
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(name,
              maxLines: 3,
              style: poppinsMedium.copyWith(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              )),
        ],
      ),
    );
  }
}
