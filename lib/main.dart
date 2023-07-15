import 'dart:developer';

import 'package:bus_sewa/app_list/profile.dart';
import 'package:bus_sewa/bus_list/bus_details/bus_detail.dart';
import 'package:bus_sewa/home/booked_detail.dart';
import 'package:bus_sewa/home/bottom_bar2.dart';
import 'package:bus_sewa/home/searchScreen2.dart';
import 'package:bus_sewa/payment/wallet_partners.dart';
import 'package:bus_sewa/screens/profile.dart';
import 'package:bus_sewa/screens/splash_screen.dart';
import 'package:bus_sewa/screens/user_profile.dart';
import 'package:bus_sewa/try/admin_add_bus.dart';
import 'package:bus_sewa/try/admin_home_try.dart';
import 'package:bus_sewa/try/admin_profile.dart';
import 'package:bus_sewa/widgets/serach_query.dart';
import 'package:flutter/material.dart';
import 'package:bus_sewa/Passenger_Details/passenger_details.dart';
import 'package:bus_sewa/bus_list/bus_details/greenLine_bus.dart';
import 'package:bus_sewa/bus_list/bus_details/srs_bus.dart';
import 'package:bus_sewa/bus_list/bus_details/vrl_bus.dart';
import 'package:bus_sewa/bus_seats/bus_seats.dart';
import 'package:bus_sewa/gift_card/gift_card.dart';
import 'package:bus_sewa/gift_card/offer_screen/offer_details.dart';
import 'package:bus_sewa/gift_card/offer_screen/offer_details2.dart';
import 'package:bus_sewa/gift_card/offer_screen/offer_details3.dart';
import 'package:bus_sewa/gift_card/offer_screen/offer_details4.dart';
import 'package:bus_sewa/home/bottom_bar.dart';
import 'package:bus_sewa/payment/Wallet.dart';
import 'package:bus_sewa/screens/details_screen.dart';
import 'package:bus_sewa/feedback/feedback_screen.dart';
import 'package:bus_sewa/home/searchscreen.dart';
import 'package:bus_sewa/payment/payment_screen.dart';
import 'package:bus_sewa/screens/login_screen.dart';
import 'package:bus_sewa/screens/signup_screen.dart';
import 'package:bus_sewa/support/support_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bus_sewa/bus_list/bus_details/Bus_details.dart';
import 'package:bus_sewa/bus_list/bus_list.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  fetchReservedSeats();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: "test_public_key_71c2c36a83f046358bc3eb0490982f14",
      builder: (context, navigatorKey) {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:   MyHomePage(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      localizationsDelegates: const [
        KhaltiLocalizations.delegate,
      ],
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignupScreen.routeName: (ctx) => SignupScreen(),
          SearchScreen.routeName: (ctx) => const SearchScreen(),
          profile.routeName: (ctx) => const profile(),
          payment.routeName: (ctx) => const payment(),
          feedback.routeName: (ctx) => feedback(),
          gift.routeName: (ctx) => const gift(),
          offer_details.routeName: (ctx) => const offer_details(),
          offer2.routeName: (ctx) => const offer2(),
          offer3.routeName: (ctx) => const offer3(),
          offer4.routeName: (ctx) => const offer4(),
          support.routeName: (ctx) => const support(),
          bottomBar.routeName: (ctx) => bottomBar(),
          details.routeName: (ctx) => details(),
          Reservations.routeName: (ctx) => const Reservations(),
          bus_seats.routeName: (ctx) => bus_seats(),
          passenger.routeName: (ctx) => passenger(),
          greenLine.routeName: (ctx) => const greenLine(),
          srs.routeName: (ctx) => const srs(),
          vrl.routeName: (ctx) => const vrl(),
          volvo.routeName: (ctx) => const volvo(),
          busDetails.routeName: (ctx) => const busDetails(),
          Wallet.routeName: (ctx) => const Wallet(),
          userProfile.routeName: (ctx) => const userProfile(),
          profilePage.routeName: (ctx) => const profilePage(),
          searchQuery.routeName: (ctx) => const searchQuery(),
          addBus.routeName: (ctx) => const addBus(),
          adminHome.routeName: (ctx) => const adminHome(),
          adminProfile.routeName: (ctx) => const adminProfile(),
          paymentPartner.routeName: (ctx) => const paymentPartner(),
          searchScreenWithoutUser.routeName: (ctx) => const searchScreenWithoutUser(),
          bottomBar2.routeName: (ctx) => const bottomBar2(),
          MyHomePage.routeName: (ctx) =>  MyHomePage() 
          
          
        },
      );},
    );
  }
}

void fetchReservedSeats() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> reservedSeats = prefs.getStringList(BusBooked.bookedSeats);
  if(reservedSeats != null) {
    log(reservedSeats.toString());
    selectedSeatNum = List.from(reservedSeats);
    log(selectedSeatNum.toString());
  }
}