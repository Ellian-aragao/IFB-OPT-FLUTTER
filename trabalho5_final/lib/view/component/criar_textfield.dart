import 'package:flutter/material.dart';

Widget criarTextField(
  String label,
  TextEditingController controller, {
  TextInputType? textInputType = TextInputType.text,
  int? maxLines = 1,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      alignLabelWithHint: true,
      labelStyle: const TextStyle(color: Colors.amber),
      border: const OutlineInputBorder(),
    ),
    style: const TextStyle(color: Colors.amber, fontSize: 15.0),
    keyboardType: textInputType,
    maxLines: maxLines,
  );
}
