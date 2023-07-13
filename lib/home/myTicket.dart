
import 'package:bus_sewa/home/booked_detail.dart';
import 'package:bus_sewa/uitls/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:bus_sewa/Passenger_Details/passenger_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myTicket extends StatefulWidget {
  BookingDetails bookingDetails;

  myTicket(this.bookingDetails);

  @override
  State<myTicket> createState() => _myTicketState();
}

class _myTicketState extends State<myTicket> {
  bool busBooked = false;
  List<String> bookedData = [];
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

   void getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
    busBooked = prefs.getBool(BusBooked.busBooked) ?? false;
    bookedData = List.from(prefs.getStringList(BusBooked.bookedData) ?? []) ?? [];
    });
    
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          leading: const SizedBox(),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: const Text(
            'Bus Tickets',
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
        ),),
        body: busBooked
         ? Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 810,
            width: 380,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0),
            ),
            //padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      bookedData[0],
                      // bookingDetails?.boardingpoint ?? "Davangere",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Icon(Icons.arrow_right_alt,
                        color: Colors.purple[900], size: 30),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      // bookingDetails?.droppingpoint ?? "Tumkuru",
                      bookedData[1],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Booking ID",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        widget.bookingDetails.bookingid,
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                                .copyWith(color: Colors.grey),
                      ),
                    )
                  ],
                ),
                divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Travels Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    Text(
                      widget.bookingDetails.travelsname,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Boarding Point",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    Text(
                      bookedData[0],
                      // bookingDetails.boardingpoint,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dropping Point",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    Text(
                      bookedData[1],
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name-Age-Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    const SizedBox(width: 10),
                    Text(
                      widget.bookingDetails.passengerdetails,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              .copyWith(color: Colors.grey, fontSize: 14),
                    ),
                    divider(),
                    const Text("Journey Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    Text(
                      bookedData[2],
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              .copyWith(color: Colors.grey, fontSize: 16),
                    ),
                    divider(),
                    const Text("Seat Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    Text(
                      widget.bookingDetails.seatnumber,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              .copyWith(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
                divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Amount",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    Text(
                      "\u{20B9}${widget.bookingDetails.totalamount}",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        :  Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(
                child: Image.asset("assets/images/empty_data.jpg")
              ),
              const Text("No any booked tickets.", style: 
              TextStyle(
                fontSize: 20
              ),),
            ],
          ),
        )
        );
  }

  Container divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 1,
      color: Colors.grey,
    );
  }
}


