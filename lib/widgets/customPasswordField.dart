import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  TextEditingController? controller;
  String text;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;
  bool obscureText;

  CustomPasswordField({
    required this.controller,
    required this.text,
    required this.validator,
    required this.obscureText,
    required this.onSaved,
  });
  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(
                widget.obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            }),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.text,
        enabled: true,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 15.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade700),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
