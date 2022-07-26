import 'package:flutter/material.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/service/todo_service.dart';
import 'package:trabalho5_final/model/gasto_mensal.dart';
import 'package:trabalho5_final/view/cadastro_tarefa.dart';
import 'package:trabalho5_final/view/gasto_item.dart';

class ListaGastoMensal extends StatefulWidget {
  const ListaGastoMensal({Key? key}) : super(key: key);

  @override
  _ListaGastoMensalState createState() => _ListaGastoMensalState();
}

class _ListaGastoMensalState extends State<ListaGastoMensal> {
  final TodoService _todoService = TodoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("To-Do List"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<ItemTodo>>(
        initialData: const [],
        future: _todoService.findAll(),
        builder: listPresenter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cadastro(),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget listPresenter(context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        break;
      case ConnectionState.waiting:
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
      case ConnectionState.active:
        break;
      case ConnectionState.done:
        final List<ItemTodo> itensTodo = snapshot.data!;
        return ListView.builder(
          itemBuilder: (context, index) {
            var itemTodo = itensTodo[index];
            return Dismissible(
              key: Key(index.toString()),
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) => _todoService.excluir(itemTodo.id),
              direction: DismissDirection.startToEnd,
              child: ItemTodoView(itemTodo),
            );
          },
          itemCount: itensTodo.length,
        );
    }
    return const Text("Erro");
  }
}
