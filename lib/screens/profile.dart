import 'dart:io';

import 'package:bus_sewa/widgets/model/users_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key key}) : super(key: key);
  static const routeName = '/profilepage';

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  
  bool isLoading = false;
  UserModel usermodel = UserModel();

  TextEditingController firstName= TextEditingController();
  TextEditingController lastName= TextEditingController();
  TextEditingController email= TextEditingController();
  TextEditingController phoneNumber= TextEditingController();
  TextEditingController address= TextEditingController();
  TextEditingController profile= TextEditingController();
  
  File _image;

  getUser() async {
    setState(() {
      isLoading = true;
    });

    await _firebaseFirestore
        .collection("User")
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        isLoading = false;
      });
      usermodel = UserModel.fromJson(value.data());
    });
    firstName.text = usermodel.firstname;
    lastName.text = usermodel.lastname;
    email.text = usermodel.email;
    phoneNumber.text = usermodel.phonenumber;
    address.text = usermodel.address;
    profile.text = usermodel.profile;
    
  }

  Future<void> updateUser(File image) async {
    final storage = _firebaseStorage.ref("User/${_auth.currentUser.uid}");
    storage.putFile(image);
    String profileUrl = await storage.getDownloadURL();
    CollectionReference colRef = FirebaseFirestore.instance.collection('User');
    FirebaseAuth auth = FirebaseAuth.instance;
    final String userID = auth.currentUser.uid;
    UserModel usermodel = UserModel(
      firstname: firstName.text,
      lastname: lastName.text,
      phonenumber: phoneNumber.text,
      address: address.text,
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

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 22.0,
              ),
            ),
            title: const Text("Profile"),
          ),
          body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 180,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child:
                                Stack(fit: StackFit.loose, children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: 140.0,
                                      height: 140.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: _image != null
                                        ?DecorationImage(
                                            image: FileImage(_image),
                                            fit: BoxFit.cover)
                                        :
                                        usermodel.profile != null || usermodel.profile.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(usermodel.profile),
                                            fit: BoxFit.cover)
                                        : const DecorationImage(
                                            image: AssetImage('assets/as.png'),
                                            fit: BoxFit.cover),
                                      )),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 90.0, right: 70.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async{
                                          var imagePicker = await ImagePicker.platform.pickImage(source: ImageSource.camera) ;
                                          if(imagePicker != null) {
                                            setState(() {
                                            _image = File(imagePicker.path);
                                            });
                                          }
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 25.0,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xffFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Personal Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'First Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: firstName,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Last Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: lastName,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Text(
                                          'Email ID',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                            hintText: usermodel.email),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: const Text(
                                          'Mobile',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: const Text(
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: TextFormField(
                                        controller: phoneNumber,
                                      ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: address,
                                      ),
                                    ),
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(top: 20,left: 50),
                                        child: FlatButton(
                                          shape: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          padding: const EdgeInsets.all(15),
                                          // color: const Color.fromARGB(246, 251, 255, 0),
                                          color: Colors.green,
                                          textColor: Colors.black,
                                          onPressed: () {
                                            updateUserdata();
                                          },
                                          child: const Text(
                                            'Save',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(top: 20,right: 50),
                                        child: FlatButton(
                                          shape: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          padding: const EdgeInsets.all(15),
                                          // color: const Color.fromARGB(246, 251, 255, 0),
                                          color: Colors.red,
                                          textColor: Colors.black,
                                          onPressed: () {
                                            confirmCancle(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
  Future<void> updateUserdata() async {
    CollectionReference colRef = FirebaseFirestore.instance
        .collection('User');
    FirebaseAuth auth = FirebaseAuth.instance;
    final String userID = auth.currentUser.uid;
    // for image
    FirebaseStorage storage =  FirebaseStorage.instance;
    Reference ref= storage.ref("User/$userID");
    await ref.putFile(_image);
    String imagePath = await ref.getDownloadURL();

    UserModel usermodel= UserModel(
      firstname: firstName.text,
      lastname: lastName.text,
      email: email.text,
      phonenumber: phoneNumber.text,
      address: address.text,
      profile: imagePath
    );
    
    await colRef.doc(userID).set(usermodel.toJson(),
     SetOptions(merge: true)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 3),
        content: const Text(
          'Data Updated Successfully',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ));
      Future.delayed(const Duration(seconds: 2), () {
        //Navigator.pop(context);
      });
    });
  }

  confirmCancle(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: const Text("Cancel"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: const Text("Continue"),
    onPressed:  () {
       Navigator.pop(context);
        Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("AlertDialog"),
    content: const Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}

