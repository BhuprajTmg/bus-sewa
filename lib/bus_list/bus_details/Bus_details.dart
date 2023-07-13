
import 'package:flutter/material.dart';
import 'package:bus_sewa/bus_seats/bus_seats.dart';

class volvo extends StatefulWidget {
  static const routeName = '/bus_details';
  final String busname;
  final String Price;
  final String ftime;
  final String ttime;
  final String from;
  final String to;
  final String date;
  final String path;
  final Map<String, bool> seatStatus;

  const volvo(
      {Key key,
      this.busname,
      this.Price,
      this.ftime,
      this.ttime,
      this.from,
      this.to,
      this.date,
      this.seatStatus,
      this.path})
      : super(key: key);

  @override
  _volvoState createState() => _volvoState();
}

class _volvoState extends State<volvo> {
  //
  // bool dataarrived=false;
  // @override
  // void initState() {
  //   readData();
  //   super.initState();
  // }

  final String image = 'assets/image_detail.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.busname,
          style: const TextStyle(color: Colors.black),
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
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: const BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.asset(image, fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.busname,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: const [
                                    Text(
                                      "Yatra aba ४ step ma",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue
                                      ),  
                                    )
                                  ],

                                  // children: <Widget>[
                                  //   Icon(
                                  //     Icons.star,
                                  //     color: Colors.purple[900],
                                  //   ),
                                  //   Icon(
                                  //     Icons.star,
                                  //     color: Colors.purple[900],
                                  //   ),
                                  //   Icon(
                                  //     Icons.star,
                                  //     color: Colors.purple[900],
                                  //   ),
                                  //   Icon(
                                  //     Icons.star,
                                  //     color: Colors.purple[900],
                                  //   ),
                                  //   const Icon(
                                  //     Icons.star_border,
                                  //     color: Colors.purple,
                                  //   ),
                                  // ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              //Text('\u{20B9}', style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                              Text(
                                '\u{20B9} ${widget.Price}',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              const Text(
                                "/per person",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.blue[300],
                          textColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bus_seats(
                                        from: widget.from,
                                        path: widget.path,
                                        to: widget.to,
                                        busname: widget.busname,
                                        date: widget.date,
                                        price: widget.Price,
                                        seatStatus: widget.seatStatus,
                                      )),
                            );
                          },
                          child: const Text(
                            "Book Now",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Description".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Started in 2015,we are proud to state that ${widget.busname} has made made an impactable field and currently grown of nearly 50 vehicles operating on 24/7 basis.\n Visit: www.${widget.busname}.com",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16.0),
                      ),
                      const SizedBox(height: 15.0),
                      Text.rich(
                        TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.directions_bus_sharp,
                            size: 20.0,
                            color: Colors.black,
                          )),
                          TextSpan(
                              text: "${widget.from} Bus Stand (${widget.ftime})")
                        ]),
                        style: const TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text.rich(
                        TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.directions_bus_sharp,
                            size: 20.0,
                            color: Colors.black,
                          )),
                          TextSpan(
                              text: "${widget.to} Bus Stand (${widget.ttime})")
                        ]),
                        style: const TextStyle(color: Colors.black, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
