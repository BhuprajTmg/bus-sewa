import 'package:bus_sewa/screens/signup_screen.dart';
import 'package:bus_sewa/uitls/custom_clipper.dart';
import 'package:flutter/material.dart';

class userProfile2 extends StatefulWidget {
  static const routeName = '/user_profile';
  const userProfile2({Key key}) : super(key: key);

  @override
  State<userProfile2> createState() => _userProfile2State();
}

class _userProfile2State extends State<userProfile2> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  bool signIn = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
      body: signIn ?const Center(
        child: Text('Profile2'),
      ) : AlertDialog(
          title: const Text('Login'),
          content: const Text('You need to login to access this page'),
          actions: [
            TextButton(onPressed: (){
              // Navigator.pushAndRemoveUntil(context, LoginScreenf, (route) => false);
              Navigator.pushNamed(context, SignupScreen.routeName);
              setState(() {
                signIn = true;
              });
            }, child: const Text('Login'))
          ],
        
      ),
    );
  }
}
