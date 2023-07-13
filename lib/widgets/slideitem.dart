import 'package:flutter/material.dart';
import 'package:bus_sewa/widgets/model/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            
            image:
                DecorationImage(image: AssetImage(slideList[index].imageUrl)),
            //fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Center(
          child: Text(
            slideList[index].title,
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
