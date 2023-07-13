import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  static const routeName = '/body';
   Body({Key key, this.img}) : super(key: key);
  File img;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          // Open camera logic
                          _browseImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                        title: const Text(
                          'Open Camera',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          // Open gallery logic
                          _browseImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        title: const Text(
                          'Open Gallery',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        title: const Center(child: Text('Cancel')),
                      ),
                    ],
                  ),
                ),
            ]
            ),
          ),
        );
      },
    );
  }

  

  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          widget.img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      ],
    );
  }
}
