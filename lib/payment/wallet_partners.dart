
import 'package:flutter/material.dart';

class paymentPartner extends StatefulWidget {
  const paymentPartner({Key key}) : super(key: key);
  static const routeName = '/adminprofilepage';
  @override
  State<paymentPartner> createState() => _paymentPartnerState();
}

class _paymentPartnerState extends State<paymentPartner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment partners"),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Image.asset(
                    'assets/khalti.png',
                    width: 170,
                    height: 160,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Text("Payment description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: RichText(
              text: const TextSpan(
                text: 'Hello,',
                style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold,),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Khalti is a mobile wallet, payment gateway & service provider in Nepal. Launched in January 2017, Khalti is an emerging online payment solution in Nepal. It allows users to pay for a range of services like basic utility payments, hotel bookings, movie and domestic flight tickets, events and many more.We offer payment solution to over hundreds of merchants across Nepal and provide seamless payments using ebanking, smart banking, cards, and wallet. Being not just limited to mobile app users, Khalti has more than 8000 POS and Agent Network providing Khalti services to end users.',
                      style: TextStyle(
                        fontWeight:FontWeight.normal
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    ); // TODO add content here later on when the page is ready to be displayed in
  }
}
