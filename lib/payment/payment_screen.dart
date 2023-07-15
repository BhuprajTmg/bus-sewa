

import 'package:bus_sewa/bus_seats/bus_seats.dart';
import 'package:bus_sewa/home/booked_detail.dart';
import 'package:bus_sewa/home/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bus_sewa/Passenger_Details/passenger_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class payment extends StatefulWidget {
  static const routeName = '/payment';
  final String price;
  final BookingDetails bookingDetails;
const payment({Key key, this.price,
  this.bookingDetails}) : super(key: key);

  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  String PhoneNumber;
  String Email;
  String Amount;
  bool dataarrived = false;
  static const platfrom = MethodChannel("razorpzy_flutter");

  Razorpay _razorpay;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    readData();
    // TODO: implement initState
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSucess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_Qs38n2LORuU2Eh",
      //"amount": num.parse(PhoneNumber)*100,
      "amount": int.parse(widget.price) * 100,
      //"amount": num.parse(textEditingController.text)*100,
      "name": "Track_n_Go",
      "description": "Payment",
      "timeout": 120,
      "prefill": {
        "contact": PhoneNumber,
        "email": Email,
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void handlerPaymentSucess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Success:${response.paymentId}", timeInSecForIosWeb: 100);
    Navigator.pop(context, PaymentStatus.Success);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failure:${response.code}-${response.message}",
        timeInSecForIosWeb: 100);
    Navigator.pop(context, PaymentStatus.Failed);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'External_Wallet:${response.walletName}', timeInSecForIosWeb: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(82, 171, 152, 90),
        title: const Text(
          'Pay Now',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Lottie.asset('assets/wallet.json',height: 161,),
                  ),
                  Flexible(
                    child: Container(
                      child: Image.asset('assets/khalti.png',width: 170,height:160,),
                    ),
                  )
                ],
              ),
              // TextField(
              //   controller: textEditingController,
              //   maxLength: 4,
              //   decoration: InputDecoration(
              //     hintText: "Enter the amount",
              //   ),
              // ),
              //Text(PhoneNumber),
              const SizedBox(
                height: 12,
              ),
              RaisedButton(
                color: const Color.fromRGBO(82, 171, 152, 90),
                child: const Text(
                  'Pay now',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  KhaltiScope.of(context).pay(
      config: PaymentConfig(
  amount: 10000, // Amount should be in paisa
  productIdentity: 'dell-g5-g5510-2021',
  productName: 'Dell G5 G5510 2021',
  productUrl: 'https://www.khalti.com/#/bazaar',
  additionalData: { // Not mandatory; can be used for reporting purpose
    'vendor': 'Khalti Bazaar',
  },
),
      preferences: [
        PaymentPreference.khalti,
    PaymentPreference.eBanking,
      ],
      onSuccess: (event) async{
        // if transaction is successful
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> bookedData = [
          widget.bookingDetails.boardingpoint,
          widget.bookingDetails.droppingpoint,
          widget.bookingDetails.journeydate
        ];
        await prefs.setBool(BusBooked.busBooked, true);
        
         await prefs.setStringList(BusBooked.bookedSeats, selectedSeatNum).whenComplete(() {
          selectedSeatNum.clear();
          newSelectedSeatNum.clear();
         });
        await prefs.setStringList(BusBooked.bookedData, bookedData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
            content: Text("Successfully Booked!"))
        );
        bottomBar.changeIndex(1);
        Navigator.popUntil(context, ModalRoute.withName("/bottom"));
      },
      onFailure: (event){
        // if transaction is failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text("Booking failed"))
        );
      },
      onCancel: (){
        // if transaction is cancelled
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text("Booking Cancelled!"))
        );
      },
    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> readData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final String userID = auth.currentUser.uid;
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('track_n_go')
        .doc('user_info')
        .collection('user_details')
        .doc(userID);
    await docRef.get().then((querySnapshot) {
      PhoneNumber = querySnapshot.get('phone_number');
      Email = querySnapshot.get('email');
      Amount = querySnapshot.get('price');
    });

    setState(() {
      dataarrived = true;
    });
  }
}

