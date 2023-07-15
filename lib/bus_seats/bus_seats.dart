import 'dart:developer' as logM;
import 'dart:math';

import 'package:bus_sewa/main.dart';
import 'package:flutter/material.dart';
import 'package:bus_sewa/Passenger_Details/passenger_details.dart';
import 'package:bus_sewa/uitls/staticVariables.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:shared_preferences/shared_preferences.dart';

List<String> selectedSeatNum = [];
List<String> newSelectedSeatNum = [];
class bus_seats extends StatefulWidget {
  static const routeName = '/bus_seats';
  String busname;
  String from;
  String to;
  String date;
  int price;
  int selectedCount = 0;
  String updateString = "";
  Map<String, bool> seatStatus;
  String path;
  BookingDetails bookingDetails;
  Map<int, SeatStatus> seatStatusMap = {};
  Map<SeatStatus, Color> seatColourMap = {
    SeatStatus.Available: Colors.grey,
    SeatStatus.Selected: Colors.lightGreenAccent,
    SeatStatus.Reserved: Colors.red,
  };

  bus_seats(
      {busname,
      from,
      to,
      date,
      price,
      Map<String, bool> seatStatus,
      String path}) {
    this.seatStatus = seatStatus;
    this.busname = busname;
    this.from = from;
    this.to = to;
    this.date = date;
    this.path = path;
    this.price = int.parse(price);
    if (seatStatus == null) {
      for (int i = 1; i < 38; i++) {
        seatStatusMap[i] = SeatStatus.Available;
      }
      Random random = Random();
      int randomNumber = random.nextInt(37);
      for (int i = 1; i < randomNumber; i++) {
        int randomSeatNo = random.nextInt(37);
        seatStatusMap[randomSeatNo] = SeatStatus.Reserved;
      }
    } else {
      for (int i = 1; i < 38; i++) {
        if (seatStatus.containsKey(i.toString()) && !seatStatus[i.toString()]) {
          seatStatusMap[i] = SeatStatus.Reserved;
        } else {
          seatStatusMap[i] = SeatStatus.Available;
        }
      }
    }
  }

  

  
  @override
  _bus_seatsState createState() => _bus_seatsState();
}

class _bus_seatsState extends State<bus_seats> with TickerProviderStateMixin{
  bool _checkBoxVal = true;
  bool dataarrived = false;
  SharedPreferences prefs;
  List<String> bookedSeats= [];
  void getData() async {
    fetchReservedSeats();
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
    bookedSeats = List.from(selectedSeatNum);
    for(var seatNum in bookedSeats){
      widget.seatStatusMap[int.parse(seatNum)] = SeatStatus.Reserved;
    }
    });

   }

  Widget buildButton(int seatNum) {
    return Material(
      child: IconButton(
        padding: const EdgeInsets.all(2),
        icon: Image.asset(
          "assets/images/seat.png",
          color: widget.seatStatusMap[seatNum] == SeatStatus.Reserved
          ? Colors.red
          : widget.seatStatusMap[seatNum] == SeatStatus.Selected
          ? Colors.green
          : null
        ),
        onPressed: () {
          if (widget.seatStatusMap[seatNum] == SeatStatus.Reserved) {
          return;
          }
          if (widget.seatStatusMap[seatNum] == SeatStatus.Available) {
            
          newSelectedSeatNum.add(seatNum.toString());
          selectedSeatNum.add(seatNum.toString());
          logM.log(selectedSeatNum.toString());
          widget.selectedCount = selectedSeatNum.length;
          // logM.log(widget.selectedCount.toString());
          this.setState(() {
            widget.seatStatusMap[seatNum] = SeatStatus.Selected;
          });
          return;
          }
          if (widget.seatStatusMap[seatNum] == SeatStatus.Selected) {
            selectedSeatNum.remove(seatNum.toString());
            newSelectedSeatNum.remove(seatNum.toString());
            widget.selectedCount = selectedSeatNum.length;
            // logM.log(widget.selectedCount.toString());
            this.setState(() {
              widget.seatStatusMap[seatNum] = SeatStatus.Available;
            });
          }
        },
      ),
    );
  }

  void updateSummary() {
    widget.updateString = "";
    widget.selectedCount = 0;
    for (int i = 1; i < 38; i++) {
      if (widget.seatStatusMap[i] == SeatStatus.Selected) {
        widget.seatStatus[i.toString()] = false;
        widget.selectedCount++;
        widget.updateString += '$i, ';
      }
    }
    if (widget.selectedCount > 0) {
      widget.updateString =
          widget.updateString.substring(0, widget.updateString.length - 2);
    }
    this.setState(() {});
  }
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    tabController = TabController(length:1, vsync:this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.green,
        // ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(82, 171, 152, 10),
            title: const Text("Seat Selection"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  newSelectedSeatNum.clear();
                  Navigator.pop(context);
                }),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
            Card(
              child: Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.circle,
                                    color: Colors.lightGreenAccent)),
                            //SizedBox( width:1.0),
                            const Text(
                              "Selected",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),

                            const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.circle, color: Colors.grey)),
                            //SizedBox( width:1.0),
                            const Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),

                            const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.circle, color: Colors.red)),
                            //SizedBox( width:1.0),
                            const Text(
                              "Reserved",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1.0),
                        const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 320.0),
                        IconButton(
                            onPressed: null,
                            icon: Image.asset("assets/images/driver.png")),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(1),
                        const SizedBox(width: 20.0),
                        buildButton(2),
                        const SizedBox(width: 110.0),
                        buildButton(3),
                        const SizedBox(width: 20.0),
                        buildButton(4),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(5),
                        const SizedBox(width: 20.0),
                        buildButton(6),
                        const SizedBox(width: 110.0),
                        buildButton(7),
                        const SizedBox(width: 20.0),
                        buildButton(8),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(9),
                        const SizedBox(width: 20.0),
                        buildButton(10),
                        const SizedBox(width: 110.0),
                        buildButton(11),
                        const SizedBox(width: 20.0),
                        buildButton(12),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(13),
                        const SizedBox(width: 20.0),
                        buildButton(14),
                        const SizedBox(width: 110.0),
                        buildButton(15),
                        const SizedBox(width: 20.0),
                        buildButton(16),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(17),
                        const SizedBox(width: 20.0),
                        buildButton(18),
                        const SizedBox(width: 110.0),
                        buildButton(19),
                        const SizedBox(width: 20.0),
                        buildButton(20),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(21),
                        const SizedBox(width: 20.0),
                        buildButton(22),
                        const SizedBox(width: 110.0),
                        buildButton(23),
                        const SizedBox(width: 20.0),
                        buildButton(24),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(25),
                        const SizedBox(width: 20.0),
                        buildButton(26),
                        const SizedBox(width: 110.0),
                        buildButton(27),
                        const SizedBox(width: 20.0),
                        buildButton(28),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(29),
                        const SizedBox(width: 20.0),
                        buildButton(30),
                        const SizedBox(width: 110.0),
                        buildButton(31),
                        const SizedBox(width: 20.0),
                        buildButton(32),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20.0,
                        ),
                        buildButton(33),
                        const SizedBox(width: 20.0),
                        buildButton(34),
                        const SizedBox(width: 30.0),
                        buildButton(35),
                        const SizedBox(width: 30.0),
                        buildButton(36),
                        const SizedBox(width: 20.0),
                        buildButton(37),
                      ],
                    ),
                    Column(
                      children: const <Widget>[
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: <Widget>[
                              const SizedBox(width: 10.0),
                              Text(
                                "Seat no: $newSelectedSeatNum",
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ]),
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 10.0),
                                Text(
                                  "Amount: Rs.${widget.price * widget.selectedCount}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.black,
                                  onChanged: (bool value) {
                                    setState(() => _checkBoxVal = value);
                                  },
                                  value: _checkBoxVal,
                                ),
                                Text(
                                  widget.from != null
                                      ? "${widget.from} Bus Stand "
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.blue,
                                  onChanged: (bool value) {
                                    setState(() => _checkBoxVal = value);
                                  },
                                  value: _checkBoxVal,
                                ),
                                Text(
                                  widget.to != null
                                      ? "${widget.to} Bus Stand "
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:100,top: 73),
                          child: Row(
                            children: <Widget>[
                              FlatButton(
                                
                                  // icon: Icon(

                                  //   Icons.arrow_forward,
                                  //   color: Colors.purple[900],

                                  // ),
                                  color:  const Color.fromRGBO(82, 171, 152, 90),
                                  child: const Text("Confirm"),
                                  onPressed: () async {
                                    if (widget.selectedCount > 0) {
                                      //updateSeat(widget.path,widget.seatStatus);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => passenger(
                                                  bookingStatusPath:
                                                      widget.path,
                                                  price:
                                                      widget.price.toString(),
                                                  seatStatus: widget.seatStatus,
                                                  passegerCount:
                                                      widget.selectedCount,
                                                  bookingDetails: BookingDetails(
                                                      boardingpoint:
                                                          widget.from,
                                                      droppingpoint: widget.to,
                                                      journeydate: widget.date,
                                                      seatnumber:
                                                          widget.updateString,
                                                      totalamount: (widget
                                                                  .price *
                                                              widget
                                                                  .selectedCount)
                                                          .toString(),
                                                      travelsname:
                                                          widget.busname),
                                                )),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Select a minimum of one seat to continue"),
                                      ));
                                    }

                                    //Navigator.of(context).pushNamed(passenger.routeName);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
          ]),
        ));
  }
  

  Future<void> updateSeat(String path, var value) async {
    store.DocumentReference colRef =
        store.FirebaseFirestore.instance.collection('bus_final').doc(path);
    colRef.update(
      {
        'seatStatus': value,
      },
    );
  }
}

void setState(bool Function() param0) {}
