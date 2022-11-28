import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    var x = 0.0;
    var y = 0.0;
    return Material(
      animationDuration: Duration(milliseconds: 100),
      elevation: 20,
      shape: OutlineInputBorder(),
      child: InkWell(
        autofocus: true,
        onHover: (value) {
           setState(() {
              
           });
        },
          onTap: () {

            setState(() {
              x = -4;
              y = 6;
            });
          },
          splashColor: Colors.blue,
          child: Container(
            
            transformAlignment: FractionalOffset(x, y),
            //alignment: Alignment(x, y),
            // margin: EdgeInsets.symmetric(vertical: 10),
            // padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(-5, 6),
              ),
            ]),
            height: 60,
            width: 80,
          )),
    );
  }
}
