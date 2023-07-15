import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bus_sewa/widgets/model/slide.dart';
import 'package:bus_sewa/screens/login_screen.dart';
import 'package:bus_sewa/widgets/slide_dots.dart';
import 'package:bus_sewa/widgets/slideitem.dart';
import 'package:bus_sewa/home/bottom_bar2.dart';

class MyHomePage extends StatefulWidget {
  static const routeName="/myhomepage ";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SecondScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          width: 10,
          height: 10,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.white, Colors.blue],
        // colors: [Color.fromRGBO(82, 171, 152, 10), Color.fromRGBO(43, 103, 119, 10)],
      )),
      child: Image.asset('assets/logo.png',width: 10,height: 10,),
    ));
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.white, Colors.blue],
          )),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: slideList.length,
                        itemBuilder: (ctx, i) => SlideItem(i),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 35),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int i = 0; i < slideList.length; i++)
                                  if (i == _currentPage)
                                    SlideDots(true)
                                  else
                                    SlideDots(false)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(15),
                      color: Colors.blue[300],
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pushNamed(bottomBar2.routeName);
                      },
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'have an account?',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        FlatButton(
                          child: const Text(
                            'Log In',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
