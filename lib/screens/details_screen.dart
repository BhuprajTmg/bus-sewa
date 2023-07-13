import 'dart:io';
import 'package:bus_sewa/widgets/model/users_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bus_sewa/home/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class details extends StatefulWidget {
  static const routeName = '/details';
   details({Key key, this.email}) : super(key: key);
  String email;
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  String city;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController Address = TextEditingController();
  // TextEditingController insurence;
  // List<String> CityName = ["Yes", "No"];
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  File _image;

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
                ]),
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
          _image = File(image.path);
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
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color.fromRGBO(82, 171, 152, 90),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              width: double.infinity,
              color: Colors.white10,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            fit: StackFit.expand,
                            // overflow: Overflow.visible,
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      backgroundImage: FileImage(_image))
                                  : const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/profile.png")),
                              Positioned(
                                right: -12,
                                bottom: 0,
                                child: SizedBox(
                                  height: 46,
                                  width: 46,
                                  child: FlatButton(
                                    //padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                    color: const Color(0xFFF5F6F9),
                                    onPressed: () {
                                      _showOptionsDialog(context);
                                    },
                                    child:
                                        SvgPicture.asset("assets/camera.svg"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'First Name',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: firstName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the valid text ';
                            }
                            return null;
                          },
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Bhuraj',
                              prefixIcon:
                                  const Icon(Icons.account_circle_outlined),
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                        const Text(
                          'Last Name',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: lastName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the valid text ';
                            }
                            return null;
                          },
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Tamang',
                              prefixIcon:
                                  const Icon(Icons.account_circle_outlined),
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: Email,

                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              enabled: false,
                              fillColor: Colors.white,
                              hintText: widget.email,
                              prefixIcon: const Icon(Icons.email),
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Phone No',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: PhoneNumber,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the valid text ';
                            }
                            return null;
                          },
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '+977 9876543210',
                              prefixIcon: const Icon(Icons.phone),
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Address',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: Address,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the valid text ';
                            }
                            return null;
                          },
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Kathmandu,Chabahil',
                              prefixIcon:
                                  const Icon(Icons.location_on_outlined),
                              contentPadding: const EdgeInsets.all(25),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          shape: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(15),
                          color: const Color.fromRGBO(82, 171, 152, 90),
                          textColor: const Color.fromARGB(255, 135, 89, 89),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print(firstName.text);
                              print(lastName.text);
                              print(Email.text);
                              print(PhoneNumber.text);
                              print(Address.text);
                              await addUserdata(_image);
                              Navigator.of(context)
                                  .pushNamed(bottomBar.routeName);
                            } else {
                              print(
                                  '------------------------------------------');
                            }
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ]),
                ),
              )));
        }));
  }

  Future<void> addUserdata(File image) async {
    final storage = _firebaseStorage.ref("User/${_auth.currentUser.uid}");
    storage.putFile(image);
    String profileUrl = await storage.getDownloadURL();
    CollectionReference colRef = FirebaseFirestore.instance.collection('User');
    FirebaseAuth auth = FirebaseAuth.instance;
    final String userID = auth.currentUser.uid;
    UserModel usermodel = UserModel(
      firstname: firstName.text,
      lastname: lastName.text,
      phonenumber: PhoneNumber.text,
      address: Address.text,
      profile: profileUrl,
    );
    colRef
        .doc(userID)
        .set(usermodel.toJson(), SetOptions(merge: true))
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Data Updated Successfully...',
          style: TextStyle(
            color: Colors.lightGreen,
          ),
        ),
      ));
      Future.delayed(const Duration(seconds: 2), () {
        //Navigator.pop(context);
      });
    });
  }
}
