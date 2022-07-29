import 'package:flutter/material.dart';

Widget loading() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text("Carregando..."),
      ],
    ),
  );
}
