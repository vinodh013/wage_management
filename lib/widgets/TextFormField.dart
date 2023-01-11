import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final String? Function(String?) validate;
  final IconData? icon;
  final TextInputType textInputType;
  final Color color;
  int? minLines;

  void Function()? onTap;

  TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.validate,
    this.icon,
    required this.textInputType,
    this.color = const Color.fromARGB(255, 232, 224, 224),
    this.minLines,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onTap: onTap,
      maxLines: minLines ?? 1,
      controller: controller,
      validator: validate,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(width: 3)),

        filled: true,
        fillColor: color,
        // labelText: labelText,
        hintText: labelText,

        labelStyle: const TextStyle(fontSize: 16),
      ),
      obscureText: isObscure,
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

class LabelTextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final String? Function(String?) validate;
  final IconData? icon;
  final TextInputType textInputType;
  final Color color;
  int? minLines;

  void Function()? onTap;

  LabelTextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.validate,
    this.icon,
    required this.textInputType,
    this.color = const Color.fromARGB(255, 232, 224, 224),
    this.minLines,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: minLines ?? 1,
      controller: controller,
      validator: validate,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(width: 3)),

        filled: true,
        fillColor: color,
       labelText: labelText,
       // hintText: labelText,

        labelStyle: const TextStyle(fontSize: 16),
      ),
      obscureText: isObscure,
    );
  }
}
