import 'package:bus_sewa/screens/login_screen.dart';
import 'package:bus_sewa/try/admin_add_bus.dart';
import 'package:bus_sewa/try/admin_profile.dart';
import 'package:bus_sewa/try/card_btn.dart';
import 'package:flutter/material.dart';

class adminHome extends StatefulWidget {
  const adminHome({Key key}) : super(key: key);
  static const routeName = '/adminHome';

  @override
  State<adminHome> createState() => adminHomeState();
}

class adminHomeState extends State<adminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("what the fuck")
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, addBus.routeName );
                    },
                    child:  const cardbtn(
                      txt: "Add",
                      icon: Icons.add,
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      //do smthing
                      Navigator.pushNamed(context, adminProfile.routeName )
                    },
                    child: const cardbtn(
                      txt: "Edit",
                      icon: Icons.edit,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => {
                       Navigator.pushNamed(context, adminProfile.routeName )
                    },
                    child: const cardbtn(
                      txt: "Analytics",
                      icon: Icons.analytics_rounded,
                    ),
                  ),
                  InkWell(
                    onTap: () async => {
                      // await Auth().signout(),
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false)
                      //do another db thing
                    },
                    child: const cardbtn(
                      txt: "Logout",
                      icon: Icons.data_usage_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // const urlogohere()
            ],
          ),
        ),
      ),
    );
  }
}