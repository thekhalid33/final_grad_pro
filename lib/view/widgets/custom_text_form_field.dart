import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Function onSave;
  final Function validator;

  CustomTextFormField({
    @required this.label,
    @required this.hint,
    @required this.onSave,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) => onSave(value),
      validator: (value) => validator(value),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        fillColor: Colors.white,
      ),
    );
  }
}
