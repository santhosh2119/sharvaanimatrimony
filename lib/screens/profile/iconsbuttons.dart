import 'package:flutter/material.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';

class IconsLable extends StatelessWidget {
  final String label;
  final Icon icon;
  final Function fname;
  IconsLable({@required this.label, @required this.fname, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: fname, icon: icon),
        Text(label,
          style: poppinsMedium.copyWith(
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: Theme.of(context).primaryColor,
            ),),
      ],
    );
  }
}
