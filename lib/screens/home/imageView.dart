import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final String url;
  final String name;
  ImageView({@required this.url,@required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        color: Colors.white,
          child: PhotoView(
        imageProvider: NetworkImage(url == 'no Image'
            ? "https://sharvaanimatrimony.com/uploads/profile_image/default.jpg"
            : "https://sharvaanimatrimony.com/uploads/profile_image/" + url),
      )),
    );
  }
}
