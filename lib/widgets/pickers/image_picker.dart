import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({Key? key, required this.pickImgFun}) : super(key: key);
  final Function(File pickedImg) pickImgFun;

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImageXFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImageXFile!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.pickImgFun(pickedImageFile);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          backgroundColor: Colors.grey,
        ),
        const SizedBox(height: 5),
        TextButton.icon(
          onPressed: () {
            _pickImage();
          },
          icon: const Icon(Icons.image),
          label: const Text("Add Image"),
        ),
      ],
    );
  }
}
