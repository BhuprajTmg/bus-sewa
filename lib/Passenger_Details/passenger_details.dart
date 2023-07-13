
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bus_sewa/home/myTicket.dart';
import 'package:bus_sewa/payment/payment_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;

enum PaymentStatus { Success, Failed, Proceesing, NotInitited, TimeOut }

class passenger extends StatefulWidget {
  static const routeName = '/passenger';
  final String price;
  int passegerCount;
  final String bookingStatusPath;
  Map<String, bool> seatStatus;
  List<PassengerDetails> passengerFields = [];
  PaymentStatus payStatus = PaymentStatus.NotInitited;
  BookingDetails bookingDetails;

  //const passenger({Key key,this.price,this.passegerCount}) : super(key: key);

  passenger(
      {this.price,
      passegerCount,
      this.bookingDetails,
      this.bookingStatusPath,
      this.seatStatus}) {
    if (passegerCount == null) {
      passegerCount = 1;
    } else {
      this.passegerCount = passegerCount;
    }
    for (int i = 0; i < this.passegerCount; i++) {
      passengerFields.add(PassengerDetails());
    }
  }

  @override
  _passengerState createState() => _passengerState();
}

List gender = ["Male", "Female", "Other"];
String select;

int _value1 = 0;

class _passengerState extends State<passenger> {
  Future<void> updateSeat(String path, var value) async {
    store.DocumentReference colRef =
        store.FirebaseFirestore.instance.collection('bus_final').doc(path);
    colRef.update(
      {
        'seatStatus': value,
      },
    );
  }

  bool _checkBoxVal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Passenger Details',
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
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          width: double.infinity,
          color: Colors.white70,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Lottie.asset(
                  'assets/user_id.json',
                  height: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Passenger Details',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                for (int i = 0; i < widget.passengerFields.length; i++)
                  widget.passengerFields[i],
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Center(
                      child: Checkbox(
                        activeColor: Colors.blue,
                        onChanged: (bool value) {
                          setState(() => _checkBoxVal = value);
                        },
                        value: _checkBoxVal,
                      ),
                    ),
                    const Text("I agree to the "),
                    const Text(
                      "Terms and Condition",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    shape: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color.fromRGBO(82, 171, 152, 90), width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(82, 171, 152, 90),
                    textColor: Colors.black,
                    onPressed: () async {
                      log(widget.bookingDetails.boardingpoint.toString());
                      log(widget.bookingDetails.droppingpoint.toString());
                      log(widget.bookingDetails.totalamount.toString());
                      log(widget.bookingDetails.journeydate.toString());
                      widget.bookingDetails.passengerdetails = "";
                      for (int i = 0; i < widget.passegerCount; i++) {
                        widget.bookingDetails.passengerdetails += '${widget
                                .passengerFields[i].name}-${widget.passengerFields[i].age}-${widget.passengerFields[i].value == 1 ? 'M' : 'F'},';
                      }
                      widget.payStatus = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => payment(
                              bookingDetails: widget.bookingDetails,
                                  price: widget.bookingDetails.totalamount,
                                )),
                      );
                      if (widget.payStatus == PaymentStatus.Success) {
                        widget.bookingDetails.bookingid = DateTime.now()
                            .millisecondsSinceEpoch
                            .remainder(100000)
                            .toString();

                        store.CollectionReference colRef = store
                            .FirebaseFirestore.instance
                            .collection('booking_details');
                        colRef.add({
                          'boardingpoint': widget.bookingDetails.boardingpoint,
                          'bookingid': widget.bookingDetails.bookingid,
                          'droppingpoint': widget.bookingDetails.droppingpoint,
                          'journeydate': widget.bookingDetails.journeydate,
                          'passengerdetails':
                              widget.bookingDetails.passengerdetails,
                          'seatnumber': widget.bookingDetails.seatnumber,
                          'totalamount': widget.bookingDetails.totalamount,
                          'travelsname': widget.bookingDetails.travelsname,
                          'userId': "",
                        });
                        await updateSeat(
                            widget.bookingStatusPath, widget.seatStatus);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    myTicket(widget.bookingDetails)));
                      }
                    },
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

BookingDetails tempTicket;

class BookingDetails {
  String boardingpoint;
  String bookingid;
  String droppingpoint;
  String journeydate;
  String passengerdetails;
  String seatnumber;
  String totalamount;
  String travelsname;
  String userId;

  BookingDetails(
      {this.boardingpoint,
      this.bookingid,
      this.droppingpoint,
      this.journeydate,
      this.passengerdetails,
      this.seatnumber,
      this.totalamount,
      this.travelsname,
      this.userId});
}

class PassengerDetails extends StatefulWidget {
  int _value = 0;

  int get value => _value;
  String name = "";
  int age = 0;

  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
          child: Container(
        height: 190,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                  onChanged: (val) {
                    widget.name = val;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Full Name',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                  onChanged: (val) {
                    widget.age = int.parse(val ?? '0');
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Age',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text("Gender",style: TextStyle(fontSize: 18,color: Colors.black54),),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left:11.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => setState(() => widget._value = 0),
                    child: Container(
                      height: 40,
                      width: 40,
                      color:
                          widget._value == 0 ? Colors.blue : Colors.transparent,
                      child: const Icon(
                        Icons.male,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => widget._value = 1),
                    child: Container(
                      height: 40,
                      width: 40,
                      color:
                          widget._value == 1 ? Colors.blue : Colors.transparent,
                      child: const Icon(Icons.female),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
