import 'package:bus_sewa/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bus_sewa/screens/components/auth.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email;
  String password;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Sign In Account'),
        elevation: 0,
        backgroundColor:  Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context,MyHomePage.routeName);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, Colors.blue],
            )),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(
                        'assets/logo.png',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Email',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      TextField(
                        onChanged: (v) {
                          setState(() {
                            email = v;
                          });
                        },
                        style: const TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'demo@gmail.com',
                            prefixIcon: const Icon(Icons.email),
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'Password',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      TextField(
                        onChanged: (v) {
                          setState(() {
                            password = v;
                          });
                        },
                        obscureText: _isObscure,
                        style: const TextStyle(fontSize: 18, color: Colors.black54),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // ignore: deprecated_member_use
                      FlatButton(
                        shape: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(15),
                        color: Colors.blue[300],
                        textColor: Colors.black,
                        onPressed: () {
                          MyAuth.signUp(email, password, context);
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
