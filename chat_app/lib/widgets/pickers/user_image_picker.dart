import "package:flutter/material.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFunction;

  UserImagePicker(this.imagePickFunction);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage = null;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    void imagePicker() async {
      var pickedImage;
      final picker = ImagePicker();
      setState(() {
        isLoading = true;
      });
      pickedImage = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
      );
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        isLoading = false;
        _pickedImage = pickedImageFile;
      });
      widget.imagePickFunction(_pickedImage);
    }

    void imageTaker() async {
      var pickedImage;
      final picker = ImagePicker();
      setState(() {
        isLoading = true;
      });
      pickedImage = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        isLoading = false;
        _pickedImage = pickedImageFile;
      });
      widget.imagePickFunction(_pickedImage);
    }

    return Column(
      children: <Widget>[
        if (isLoading)
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            radius: screenWidth * 0.15,
          ),
        if (!isLoading)
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            backgroundImage: _pickedImage != null
                ? FileImage(_pickedImage)
                : AssetImage("assets/images/faceIcon.png"),
            radius: screenWidth * 0.15,
          ),
        FittedBox(
          child: Row(
            children: <Widget>[
              FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: imagePicker,
                icon: const Icon(Icons.photo_library),
                label: const Text("Select Image"),
              ),
              FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: imageTaker,
                icon: const Icon(Icons.add_a_photo),
                label: const Text("Take new image"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
