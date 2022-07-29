import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho5_final/persistence/item_todo_persistence_dao_memory.dart';
import 'package:trabalho5_final/persistence/item_todo_persistence_dao_sqlite.dart';
import 'package:trabalho5_final/service/todo_service.dart';
import 'package:trabalho5_final/view/lista_gasto_mensal.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoService>.value(
          value: TodoService(ItemTodoPersistenceDaoInMemory()),
        ),
      ],
      child: const InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ListaGastoMensal(),
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
    );
  }
}
