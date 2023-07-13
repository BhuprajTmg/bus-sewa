import 'package:bus_sewa/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:bus_sewa/Passenger_Details/passenger_details.dart';
import 'package:bus_sewa/home/searchscreen.dart';
import 'package:bus_sewa/home/myTicket.dart';

class bottomBar extends StatefulWidget {
  static const routeName = '/bottom';

  static void changeIndex(int i) {
    _bottomBarState._currentIndex = i;
  }
  @override
  _bottomBarState createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  static int _currentIndex = 0;
  final List<Widget> _children = [
    const SearchScreen(),
    myTicket(BookingDetails(
        travelsname: "Hamro bus sewa",
        boardingpoint: 'Kathmandu',
        droppingpoint: 'Udayapur',
        bookingid: '3546354',
        passengerdetails: 'pass1-20-M,pass2-22-M',
        journeydate: '19/07/2021',
        seatnumber: '10',
        totalamount: '1200')),
    const userProfile(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    // return Scaffold(
    //   body:  _children[_currentIndex],
    //   bottomNavigationBar: Container(
        
    //     margin: EdgeInsets.all(displayWidth * .05),
    //     height: displayWidth * .155,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black.withOpacity(.1),
    //           blurRadius: 30,
    //           offset: const Offset(0, 10),
    //         ),
    //       ],
    //       borderRadius: BorderRadius.circular(50),
    //     ),
    //     child: ListView.builder(
    //       itemCount: 4,
    //       scrollDirection: Axis.horizontal,
    //       padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
    //       itemBuilder: (context, index) => InkWell(
    //         onTap: () {
    //           setState(() {
    //             currentIndex = index;
    //             HapticFeedback.lightImpact();
    //           });
    //         },
    //         splashColor: Colors.transparent,
    //         highlightColor: Colors.transparent,
    //         child: Stack(
    //           children: [
    //             AnimatedContainer(
    //               duration: const Duration(seconds: 1),
    //               curve: Curves.fastLinearToSlowEaseIn,
    //               width: index == currentIndex
    //                   ? displayWidth * .32
    //                   : displayWidth * .18,
    //               alignment: Alignment.center,
    //               child: AnimatedContainer(
    //                 duration: const Duration(seconds: 1),
    //                 curve: Curves.fastLinearToSlowEaseIn,
    //                 height: index == currentIndex ? displayWidth * .12 : 0,
    //                 width: index == currentIndex ? displayWidth * .32 : 0,
    //                 decoration: BoxDecoration(
    //                   color: index == currentIndex
    //                       ? Colors.blueAccent.withOpacity(.2)
    //                       : Colors.transparent,
    //                   borderRadius: BorderRadius.circular(50),
    //                 ),
    //               ),
    //             ),
    //             AnimatedContainer(
    //               duration: const Duration(seconds: 1),
    //               curve: Curves.fastLinearToSlowEaseIn,
    //               width: index == currentIndex
    //                   ? displayWidth * .31
    //                   : displayWidth * .18,
    //               alignment: Alignment.center,
    //               child: Stack(
    //                 children: [
    //                   Row(
    //                     children: [
    //                       AnimatedContainer(
    //                         duration: const Duration(seconds: 1),
    //                         curve: Curves.fastLinearToSlowEaseIn,
    //                         width:
    //                             index == currentIndex ? displayWidth * .13 : 0,
    //                       ),
    //                       AnimatedOpacity(
    //                         opacity: index == currentIndex ? 1 : 0,
    //                         duration: const Duration(seconds: 1),
    //                         curve: Curves.fastLinearToSlowEaseIn,
    //                         child: Text(
    //                           index == currentIndex
    //                               ? listOfStrings[index]
    //                               : '',
    //                           style: const TextStyle(
    //                             color: Colors.blueAccent,
    //                             fontWeight: FontWeight.w600,
    //                             fontSize: 15,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   Row(
    //                     children: [
    //                       AnimatedContainer(
    //                         duration: const Duration(seconds: 1),
    //                         curve: Curves.fastLinearToSlowEaseIn,
    //                         width:
    //                             index == currentIndex ? displayWidth * .03 : 20,
    //                       ),
    //                       Icon(
    //                         listOfIcons[index],
    //                         size: displayWidth * .076,
    //                         color: index == currentIndex
    //                             ? Colors.blueAccent
    //                             : Colors.black26,
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );



    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[400],
        selectedItemColor: Colors.black,
        selectedFontSize: 15,
        unselectedFontSize: 12,
        unselectedItemColor: Colors.white.withOpacity(.60),
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            // title: Text('Home'),
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Tickets',
            icon: Icon(Icons.article_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          )
        ],
      ),
    );
  }
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.airplane_ticket,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Tickets',
    'Account',
  ];
}







