import 'package:bus_sewa/bus_list/bus_details/bus_detail2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bus_sewa/bus_list/bus_details/bus_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class busList2 extends StatefulWidget {
  
  
  static const routeName = '/bus_list2';
  final Color color;
  final String str1;
  final String str2;
  final String date;

  const busList2({Key key, this.color,this.str1,this.str2,this.date}) : super(key: key);
  @override
  State<busList2> createState() => _busList2State();
}

class _busList2State extends State<busList2> {
  CollectionReference busDetails =
      FirebaseFirestore.instance.collection("bus_final");
  List<BusBean> busList = [];

  Future<void> fetchDataFromCollectionsPatents(List dataList) async {
    await busDetails.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Map<String, dynamic> eachPatent = result.data();
        print(result.reference.id);
        BusBean bean = BusBean(
          path: result.reference.id,
          busName: eachPatent["busName"],
          from: eachPatent["from"],
          to: eachPatent["to"],
          ftime: eachPatent["ftime"],
          ttime: eachPatent["ttime"],
          price: eachPatent["price"],
          seatStatus: eachPatent["seatStatus"] == null
              ? null
              : Map<String, bool>.from(eachPatent["seatStatus"]),
        );
        dataList.add(bean);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    fetchDataFromCollectionsPatents(busList);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Results',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(82, 171, 152, 10),
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
        return Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.89,
                child: ListView(children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: busList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Column(
                              children: [
                                widget.str1 == busList[index].from &&
                                        widget.str2 == busList[index].to
                                    ? Column(
                                        children: [
                                          EachBus(
                                            date: widget.date,
                                            busbean: busList[index],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          )
                                        ],
                                      )
                                    : Container(),
                                //SizedBox(height: 10,),
                              ],
                            );
                            //return EachBus(
            
                            //busbean:busList[index],
                            //);
                          }),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  // FlatButton(
                  //   padding: const EdgeInsets.all(15),
                  //   child: _reservationsItem1(),
                  //   onPressed:(){
                  //     Navigator.of(context).pushNamed(srs.routeName);
                  //   },
                  // ),
                  // ignore: deprecated_member_use
                  // FlatButton(
                  //   padding: const EdgeInsets.all(15),
                  //   child: _reservationsItem2(),
                  //   onPressed:(){
                  //     Navigator.of(context).pushNamed(greenLine.routeName);
                  //   },
                  // ),
                  // // ignore: deprecated_member_use
                  // FlatButton(
                  //   padding: const EdgeInsets.all(15),
                  //   child: _reservationsItem3(),
                  //   onPressed:(){
                  //     Navigator.of(context).pushNamed(vrl.routeName);
                  //   },
                  // ),
                  // // ignore: deprecated_member_use
                  // FlatButton(
                  //   padding: const EdgeInsets.all(15),
                  //   child: _reservationsItem4(),
                  //   onPressed:(){
                  //     Navigator.of(context).pushNamed(volvo.routeName);
                  //   },
                  // ),
                ]),
              ),
            )
          ],
        );
      }),
    );
  }
}

class EachBus extends StatelessWidget {
  // final String busName;
  // final String from;
  // final String to;
  // final String ftime;
  // final String ttime;
  // final String price;
  final BusBean busbean;
  final String date;

  const EachBus({this.busbean, this.date});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: Container(
        width: 500,
        height: 215,
        margin: const EdgeInsets.only(bottom: 00),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.directions_bus_sharp,
                    color: Colors.black, size: 32),
                Text(
                  busbean.busName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 150),
                const Text(
                  '\u{20B9}',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(busbean.price,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                ),
              ],
            ),
            //SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Departure",
                          style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 10),
                      Text(busbean.ftime,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 1),
                      Text(
                        busbean.from,
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      // Row(
                      //   children: const <Widget>[
                      //     Icon(
                      //       Icons.star,
                      //       color: Colors.black,
                      //     ),
                      //     Text(
                      //       "4.1",
                      //       style: TextStyle(color: Colors.black54),
                      //     ),
                      //     //SizedBox(width: 10,),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Icon(Icons.directions_bus_sharp,
                              color: Colors.blue, size: 21),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.blue, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.fiber_manual_record,
                              color: Colors.green, size: 8),
                          Icon(Icons.location_on, color: Colors.blue, size: 21),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 9,
                      ),
                      const Text("Arrival", style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 10),
                      Text(busbean.ttime,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 1),
                      Text(busbean.to,
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => busDetails2(
                                            busname: busbean.busName,
                                            from: busbean.from,
                                            Price: busbean.price,
                                            to: busbean.to,
                                            ftime: busbean.ftime,
                                            ttime: busbean.ttime,
                                            date: date,
                                            seatStatus: busbean.seatStatus,
                                            path: busbean.path,
                                          )),
                                );
                                // //Navigator.of(context).pushNamed(volvo.routeName);
                                // Navigator.of(context).pushNamed('/bus_details');
                              },
                              child: const Text(
                                "BookNow",
                                style: TextStyle(color: Colors.white),
                              )),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class BusBean {
  final String busName;
  final String from;
  final String to;
  final String ftime;
  final String ttime;
  final String price;
  final String path;
  Map<String, bool> seatStatus;

  BusBean(
      {@required this.busName,
      @required this.path,
      @required this.from,
      @required this.to,
      @required this.ftime,
      @required this.ttime,
      @required this.price,
      @required this.seatStatus});
}