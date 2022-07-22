import 'package:flutter/material.dart';
import 'package:trabalho5_final/view/lista_gasto_mensal.dart';

Future<void> main() async {
  runApp(MaterialApp(
    home: ListaGastoMensal(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}
