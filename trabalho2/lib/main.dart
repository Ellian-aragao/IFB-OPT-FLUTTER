import 'package:flutter/material.dart';
import 'package:trabalho2/view/lista_arquivo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ellian_Aragao_Dias_App',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.grey,
        ),
      ),
      home: const ViewArquivo(titulo: 'Lista de Disciplinas'),
    );
  }
}
