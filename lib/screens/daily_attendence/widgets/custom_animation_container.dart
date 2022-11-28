import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAnimationContainer extends StatefulWidget {
  const CustomAnimationContainer({super.key});

  @override
  State<CustomAnimationContainer> createState() => _CustomAnimationContainerState();
}

class _CustomAnimationContainerState extends State<CustomAnimationContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceOut,
      
      height: 120,
      width: 80,
      color: Colors.black,
      

      duration: Duration(seconds: 20));
  }
}