import 'package:flutter/material.dart';


class updatelist extends InheritedWidget {
  const updatelist({super.key, required this.child}) : super(child: child);

  final Widget child;

  static updatelist? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<updatelist>();
    
  }

  @override
  bool updateShouldNotify(updatelist oldWidget) {
    return true;
  }


}