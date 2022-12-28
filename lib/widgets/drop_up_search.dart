import 'package:flutter/material.dart';

class DropUpSearchButton extends StatelessWidget {
  const DropUpSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Stack(
           children: [
             Container(
              height: 50,
              width: 100,
              alignment: Alignment.topLeft,
             ),
           ],
         );
      },
      child: Container(
        child: const Center(child: Text('Hello')),
      ),
    );
  }
}
