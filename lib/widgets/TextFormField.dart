import 'package:flutter/material.dart';

import 'package:wage_management/constants.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final String? Function(String?)  validate ;
//  final IconData icon;
  final TextInputType textInputType;

  const TextInputField({
    Key? key,
    required this.validate,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    //required this.icon,
    required this.textInputType,
  }) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: widget.controller,
      validator: widget.validate,

      
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        // prefixIcon: Icon(icon),
        labelStyle: const TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: borderColor),
        ),
      ),
      obscureText: widget.isObscure,
    );
  }
}

class CustomSearchField extends StatelessWidget {
  TextEditingController searchController;
  CustomSearchField({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
