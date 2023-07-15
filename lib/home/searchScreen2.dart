import 'package:bus_sewa/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'package:bus_sewa/home/bottom_bar.dart';
import 'package:bus_sewa/payment/wallet_partners.dart';
import 'package:bus_sewa/bus_list/bus_list.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:bus_sewa/screens/login_screen.dart';
import 'package:bus_sewa/support/support_screen.dart';
import 'package:bus_sewa/uitls/custom_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';


class searchScreenWithoutUser extends StatefulWidget {
  const searchScreenWithoutUser({Key key}) : super(key: key);
  static const routeName = '/searchScreenTwo';
  @override
  State<searchScreenWithoutUser> createState() => _searchScreenWithoutUserState();
}

class _searchScreenWithoutUserState extends State<searchScreenWithoutUser> {
  DateTime currentDate = DateTime.now();
  final dateController = TextEditingController();


  // @override
  // void initState() {
  //   // TODO: implement initState
    
  //   super.initState();
  // }


  String city1, city2;
  String Name;
  String Email;
  bool dataarrived = false;
  List<String> CityName = [
    "Kathmandu",
    "Pokhara",
    "Bhaktapur",
    "Lalitpur",
    "Jhapa",
    "udayapur",
    "Siraha",
    "Sapthari",
    "Khotang",
    "Sindhuli",
    "Dhading",
    "Rolpa",
    "Tista",
    "Ilam",
    "Biratnagar",
    "Solukhumbu",
    "Pachthar",
    "Banke",
    "Bardiya",
    "Kavre",
    "Sindhupalchok",
    "Naranghat",
    "Gorkha",
    "Lumbini",
    "Palpa",
    "Okhaldhunga",
    "Rolpa",
    "Kanchanpur",
    "Dhangadi",
  ];

  @override
  void dispose() {
    // Clean up the Controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  static FirebaseAuth auth = FirebaseAuth.instance;
  static void Search(
      String From, String To, BuildContext context) async {
    
  }
  showAlertDialog(BuildContext context) {
    backgroundColor:Colors.blue;
  // set up the button
  Widget okButton = FlatButton(
    child: const Text("OK"),
    onPressed: () { 
      Navigator.pushNamed(context, SignupScreen.routeName);
    
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    
    title: const Text("User not Logged In"),
    content: const Text("You need to log into the system to get your profile"),
    actions: [
      okButton,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: 
              ListView(
                  padding: const EdgeInsets.only(top: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ClipPath(
                      clipper: MyCustomClipperForDrawer(),
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            image: const DecorationImage(image: AssetImage("assets/profile.png")
                            )
                          ),
                        ),
                        accountName: const Text(
                          "Hello! There",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: const Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Text(
                            "Alex@gmail.com",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [Colors.blue,Color.fromRGBO(82, 171, 152, 10) ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          tileMode: TileMode.clamp,
                        )),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.assignment_ind_rounded),
                      title: const Text(
                        'Your Profile',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onTap: () {
                        showAlertDialog(context);
                        bottomBar.changeIndex(2);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.payment),
                      title: const Text(
                        'Wallet',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(paymentPartner.routeName);
                      },
                    ),
                    // ListTile(
                    //   leading: const Icon(Icons.feedback_outlined),
                    //   title: const Text(
                    //     'Customer Feedback',
                    //     style: TextStyle(fontSize: 18.0),
                    //   ),
                    //   onTap: () {
                    //     Navigator.of(context).pushNamed(feedback.routeName);
                    //   },
                    // ),
                    // ListTile(
                    //   leading: Icon(Icons.wallet_giftcard_sharp),
                    //   title: Text(
                    //     'Gift Card',
                    //     style: TextStyle(fontSize: 18.0),
                    //   ),
                    //   onTap: () {
                    //     Navigator.of(context).pushNamed(gift.routeName);
                    //   },
                    // ),
                    ListTile(
                      leading: const Icon(Icons.support_agent),
                      title: const Text(
                        'Support',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(support.routeName);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onTap: () async {

                          Navigator.pushReplacementNamed(context,LoginScreen.routeName);
                      },
                    ),
                  ],
                )
            
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            'Search for Bus Tickets',
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            color: Colors.white10,
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
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Book Ticket For Your",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                        ),
                         
                        Text(
                          "Next Trip !!",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 60)),
                      // Lottie.asset(
                      //   'assets/bus.json',
                      //   height: 150,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          DropDownField(
                            onValueChanged: (dynamic value) {
                              city1 = value;
                            },
                            value: city1,
                            required: false,
                            hintText: 'Starting',
                            labelText: 'From',
                            items: CityName,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DropDownField(
                            onValueChanged: (dynamic value) {
                              city2 = value;
                            },
                            value: city2,
                            required: false,
                            hintText: 'Destination',
                            labelText: 'To',
                            items: CityName,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                          readOnly: true,
                          controller: dateController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.date_range),
                            hintText: 'Select Date',
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(const Duration(days: 0)),
                              lastDate: DateTime(2050),
                            );
                            dateController.text =
                                date.toString().substring(0, 10);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        shape: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(15),
                        // color: const Color.fromARGB(246, 251, 255, 0),
                        color:  const Color.fromRGBO(82, 171, 152, 90),
                        textColor: Colors.black,
                        onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reservations(
                                      str1: city1,
                                      str2: city2,
                                      date: dateController.text,
                                    )),
                          );
                        },
                        child: const Text(
                          'Search',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

}

  
