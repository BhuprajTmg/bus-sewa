import 'package:flutter/material.dart';

class cardbtn extends StatelessWidget {
  final txt;
  final icon;

  const cardbtn({Key key, this.txt, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 120,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.5),

          blurRadius: 2,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ], color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30,
            child: Icon(
              icon,
              size: 40,
              color: Color.fromARGB(255, 193, 193, 193),
            ),
          ),  
          const SizedBox(
            height: 7,
          ),
          Text(
            txt,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
