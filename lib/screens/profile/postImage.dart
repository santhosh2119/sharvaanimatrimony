import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:sharvaanimatrimony/conts/dimensions.dart';
import 'package:sharvaanimatrimony/conts/styles.dart';
import 'package:sharvaanimatrimony/providers/membersprovider.dart';

class ImageInput extends StatefulWidget {
  final String id;
  ImageInput({@required this.id});
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var datass;
  File _imageFile;
  String base64Image = "";
  var postImage;
  var _isLoading = false;
  var imageFlag = false;
  Future<void> _uplaod(String base64Image, String id) async {
    setState(() {
      _isLoading = true;
    });
    if (base64Image == null || id == null) {
      return;
    }
    try {
      datass = await Provider.of<MemberProvider>(context, listen: false)
          .uploadImage(base64Image, id)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value[0] == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Updated Successfully"),
            duration: Duration(seconds: 3),
          ));
        } else {
          return null;
        }
      });

      print('complete');
    } catch (error) {
      print(error);
    }
  }

  final ImagePicker _picker = ImagePicker();
  Future<void> _takePicture() async {
    try {
      // ignore: deprecated_member_use
      final pickedFile = await _picker.getImage(
          source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1920);
      print("path");
      print("path  : ${pickedFile.path}");
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      var imageBytes = _imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);

      print(base64Image);
    } catch (e) {
      print(e);
      imageFlag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Profile Image"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: _imageFile != null
                    ? Image.file(
                        _imageFile,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Text(
                        'No Image Taken',
                        textAlign: TextAlign.center,
                      ),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 8,
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Choose A Picture'),
                onPressed: _takePicture,
              ),
              SizedBox(
                height: 16,
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        _uplaod(base64Image, widget.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text(
                          'Uplaod Image',
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
    );
  }
}
