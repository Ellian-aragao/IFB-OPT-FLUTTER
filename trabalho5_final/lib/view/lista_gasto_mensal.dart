import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho5_final/component/loading.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/service/todo_service.dart';
import 'package:trabalho5_final/view/cadastro_tarefa.dart';
import 'package:trabalho5_final/view/gasto_item.dart';

class ListaGastoMensal extends StatefulWidget {
  const ListaGastoMensal({Key? key}) : super(key: key);

  @override
  _ListaGastoMensalState createState() => _ListaGastoMensalState();
}

class _ListaGastoMensalState extends State<ListaGastoMensal> {
  @override
  Widget build(BuildContext context) {
    var todoService = Provider.of<TodoService>(context);
    var futureListItemToDo = todoService.findAll();

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
        future: futureListItemToDo,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              return loading();
            case ConnectionState.done:
              var itensTodo = snapshot.data!;
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
                    onDismissed: (direction) =>
                        todoService.excluir(itemTodo.id),
                    direction: DismissDirection.startToEnd,
                    child: ItemTodoView(itemTodo),
                  );
                },
                itemCount: itensTodo.length,
              );
          }
          return const Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Cadastro(),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }
}
