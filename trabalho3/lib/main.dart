import 'package:flutter/material.dart';
import 'package:trabalho3/controller/gasto_controller.dart';
import 'package:trabalho3/model/gasto_mensal.dart';
import 'package:trabalho3/view/cadastro_gasto_mensal.dart';
import 'package:trabalho3/view/lista_gasto_mensal.dart';

Future<void> main() async {
  runApp(MaterialApp(
    home: ListaGastoMensal(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber)),
          hintStyle: const TextStyle(color: Colors.amber),
        )),
  ));
}
