// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class Bus extends StatefulWidget {
//   const Bus({Key key}) : super(key: key);
//   // const Bus({
//   //   super.key,
//   //   required this.busNo,
//   //   required this.name,
//   //   required this.source,
//   //   required this.destination,
//   //   required this.time,
//   //   required this.price,
//   // });
//   // final

//   final int busNo=0;
//   final String name="";
//   final String source="";
//   final String destination="";
//   final String time="";
//   final int price=0;

//   @override
//   State<Bus> createState() => _BusState();
// }

// class _BusState extends State<Bus> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           GestureDetector(
//             onTap: () {
//               price = widget.price;
//               busName = widget.name;
//               Navigator.push(context,
//                   MaterialPageRoute(builder: ((context) => const SeatsPage())));
//             },
//             child: Container(
//               // padding: const EdgeInsets.all(26),
//               margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(20),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                       margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
//                       height: 110,
//                       width: 90,
//                       decoration: BoxDecoration(
//                           image: const DecorationImage(
//                               image: AssetImage('lib/assets/busimg.jpg'),
//                               fit: BoxFit.fill),
//                           borderRadius: BorderRadius.circular(10))),
//                   Column(
//                     children: [
//                       Container(
//                         width: 247,
//                         margin: const EdgeInsets.fromLTRB(10, 15, 0, 0),
//                         child: Text(widget.name,
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
//                         child: Text('Source: ${widget.source}',
//                             style: const TextStyle(fontSize: 13)),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
//                         child: Text('Destination: ${widget.destination}',
//                             style: const TextStyle(fontSize: 13)),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
//                         child: Text('Price: ${widget.price} /-',
//                             style: const TextStyle(fontSize: 13)),
//                       ),
//                       Text('Time: ${widget.time}',
//                           style: const TextStyle(fontSize: 13)),
//                       const SizedBox(
//                         height: 10,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           )
//         ]
//       )
//     );
//   }
// }