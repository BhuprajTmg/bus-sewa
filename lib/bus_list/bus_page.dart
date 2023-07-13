// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class bus_page extends StatefulWidget {
//   const bus_page({Key key}) : super(key: key);

//   @override
//   State<bus_page> createState() => _bus_pageState();
// }

// class _bus_pageState extends State<bus_page> {
//   String source = '';
//   String destination = '';

//   List<Map<String, dynamic>> displayList = List.from(busList);

//   void updateListBySource(String value) {
//     setState(() {
//       displayList = busList
//           .where((element) => element["source"]
//               .toString()
//               .toLowerCase()
//               .contains(value.toLowerCase()))
//           .toList();
//     });
//   }

//   void updateListByDest(String value) {
//     setState(() {
//       displayList = busList
//           .where((element) => element["destination"]
//               .toString()
//               .toLowerCase()
//               .contains(value.toLowerCase()))
//           .toList();
//     });
//   }

//   var bool = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         title: const Text('BUSES LIST'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//             setState(() {
//               dateNow = 'Date';
//             });
//           },
//         ),
//       ),
//       body: FractionallySizedBox(
//         widthFactor: 1.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             bool
//                 ? Container()
//                 : const SizedBox(
//                     height: 40,
//                   ),
//             bool
//                 ? Container()
//                 : FractionallySizedBox(
//                     widthFactor: 0.92,
//                     child: TextFormField(
//                       onChanged: (value) {
//                         setState(() {
//                           updateListBySource(value);
//                         });
//                       },
//                       cursorColor: Colors.grey,
//                       cursorHeight: 25,
//                       decoration: const InputDecoration(
//                           prefixIcon: Icon(
//                             Icons.start,
//                             color: Colors.black,
//                           ),
//                           hintText: 'eg: Mumbai',
//                           label: Text(
//                             'Enter Source',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15.0)),
//                           )),
//                     ),
//                   ),
//             bool
//                 ? Container()
//                 : const SizedBox(
//                     height: 20,
//                   ),
//             bool
//                 ? Container()
//                 : FractionallySizedBox(
//                     widthFactor: 0.92,
//                     child: TextFormField(
//                       onChanged: (value) {
//                         setState(() {
//                           updateListByDest(value);
//                         });
//                       },
//                       cursorColor: Colors.grey,
//                       cursorHeight: 25,
//                       decoration: const InputDecoration(
//                           prefixIcon: Icon(
//                             Icons.stop,
//                             color: Colors.black,
//                           ),
//                           hintText: 'eg: Mumbai',
//                           label: Text(
//                             'Enter Destination',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15.0)),
//                           )),
//                     ),
//                   ),
//             bool
//                 ? Container()
//                 : const SizedBox(
//                     height: 20,
//                   ),
//             bool
//                 ? Container()
//                 : FractionallySizedBox(
//                     widthFactor: 0.92,
//                     child: Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: TextFormField(
//                         onTap: () async {
//                           DateTime? date = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime.now(),
//                               lastDate: DateTime(2024));
//                           if (date != null) {
//                             dateNow =
//                                 DateFormat.yMMMMd().format(date).toString();
//                           }
//                         },
//                         onChanged: (value) {},
//                         cursorColor: Colors.grey,
//                         cursorHeight: 25,
//                         decoration: InputDecoration(
//                             prefixIcon: const Icon(
//                               Icons.calendar_today,
//                               color: Colors.black,
//                             ),
//                             hintText: dateNow,
//                             label: Text(
//                               dateNow,
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                             border: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             )),
//                       ),
//                     ),
//                   ),
//             bool
//                 ? Container()
//                 : const SizedBox(
//                     height: 30,
//                   ),
//             bool
//                 ? Container()
//                 : SizedBox(
//                     width: 150,
//                     height: 45,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             bool = true;
//                           });
//                         },
//                         child: const Text(
//                           'Search Buses',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ))),
//             bool
//                 ? Container()
//                 : const Divider(
//                     height: 50,
//                     thickness: 2,
//                     color: Colors.grey,
//                     indent: 15,
//                     endIndent: 15,
//                   ),
//             !bool
//                 ? Container()
//                 : SizedBox(
//                     height: 700,
//                     child: ListView.builder(
//                         itemCount: displayList.length,
//                         itemBuilder: (context, index) {
//                           return Bus(
//                               busNo: displayList[index]["busNo"],
//                               name: displayList[index]["busName"],
//                               source: displayList[index]['source'],
//                               destination: displayList[index]['destination'],
//                               time: displayList[index]['time'],
//                               price: displayList[index]['price']);
//                         }),
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }
