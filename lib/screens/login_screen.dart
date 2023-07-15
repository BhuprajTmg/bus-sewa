import 'package:bus_sewa/home/bottom_bar.dart';
import 'package:bus_sewa/screens/components/auth.dart';
import 'package:bus_sewa/try/admin_home_try.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: _auth.currentUser != null
         ? IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
         : const SizedBox(),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors:[Colors.white, Colors.blue],
            )),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            //color: Colors.blue[200],
            width: double.infinity,
            // color: Colors.purple[900],
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
                        Image.asset('assets/logo.png', height: 200),
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
                
                        TextFormField(
                          controller: _emailEditingController,
                          style: const TextStyle(fontSize: 18, color:Colors.black87),
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Please enter email';
                            }
                            if(!value.contains("@gmail.com")){
                              return "Please enter a valid email";
                            }
                            return null;
                          },
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
                
                        TextFormField(
controller: _passwordEditingController,
                          obscureText: _isObscure,
                          style: const TextStyle(fontSize: 18, color: Colors.black87),
                          validator: (value) {
                            if(value.isEmpty){
                              return '*This field i required!*';
                            }
                            if(value.length < 8){
                              return '*Password must be atleast 8 character!*';
                            }
                            return null;
                          }, 
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
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context)
                            .pushNamedAndRemoveUntil(adminHome.routeName, (route) => false);
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'login as admin',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
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
                          onPressed: () async{
                            if(_formKey.currentState.validate()) {
                              await MyAuth.auth.signInWithEmailAndPassword(email: _emailEditingController.text, password: 
                              _passwordEditingController.text).then((value) {
                            Navigator.of(context).pushNamed(bottomBar.routeName);
      });
                            }  
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
