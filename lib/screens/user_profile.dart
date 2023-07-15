import 'dart:developer';
import 'dart:io';

import 'package:bus_sewa/screens/profile.dart';
import 'package:bus_sewa/uitls/custom_clipper.dart';
import 'package:bus_sewa/widgets/model/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userProfile extends StatefulWidget {
  static const routeName = '/userProfile';
  const userProfile({Key key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  UserModel usermodel = UserModel();

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
      log(usermodel.toString());
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              leading: const SizedBox(),
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: ClipPath(
                clipper: MyCustomClipperForAppBar(),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Color.fromRGBO(82, 171, 152, 10), Colors.blue],
                    // colors: [Color.fromRGBO(43, 103, 119, 10), Color.fromRGBO(82, 171, 152, 10)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    tileMode: TileMode.clamp,
                  )),
                ),
              ),
            ),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          // Container(
                          //   height: 181,
                          //   color: Colors.white,
                          //   child: Column(

                          //     children: <Widget>[

                          //       Container(
                          //         child:
                          //             Stack(fit: StackFit.loose, children: <Widget>[
                          //           Column(
                          //             crossAxisAlignment: CrossAxisAlignment.center,
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: <Widget>[
                          //               Container(
                          //                   width: 140.0,
                          //                   height: 140.0,
                          //                   decoration: const BoxDecoration(
                          //                     shape: BoxShape.circle,
                          //                     image: DecorationImage(
                          //                         image: AssetImage('usermodel.profile'),
                          //                         fit: BoxFit.cover),
                          //                   )),
                          //               Container(
                          //                 child: Text("${usermodel.firstname} ${usermodel.lastname}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 18,),),
                          //               )
                          //             ],
                          //           ),
                          //         ]),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              fit: StackFit.expand,
                              // overflow: Overflow.visible,
                              children: [
                                usermodel.profile != null &&
                                        usermodel.profile.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(usermodel.profile))
                                    : const CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/profile.png")),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                                    fontStyle:
                                                        FontStyle.italic),
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
                                                hintText: usermodel.firstname,
                                              ),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                hintText: usermodel.lastname,
                                              ),
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
                                                'Email ',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: const Text(
                                                'Mobile',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: TextField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        usermodel.phonenumber),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: TextField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                  hintText: usermodel.address),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: FlatButton(
                                            shape: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(15),
                                            // color: const Color.fromARGB(246, 251, 255, 0),
                                            color: Colors.green,
                                            textColor: Colors.black,
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  profilePage.routeName);
                                            },
                                            child: const Text(
                                              'Edit profile',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          )),
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
}

@override
// void dispose() {
//   // Clean up the controller when the Widget is disposed
//   myFocusNode.dispose();
//   super.dispose();
// }

Widget _getActionButtons() {
  return Padding(
    padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
                child: RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                // setState(() {
                //   _status = true;
                //   FocusScope.of(context).requestFocus(new FocusNode());
                // });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: const Text("Edit profile"),
            )),
          ),
        ),
      ],
    ),
  );
}
