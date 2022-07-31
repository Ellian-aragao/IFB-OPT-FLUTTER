import 'package:flutter/material.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/view/pagina_cadastro/cadastro_tarefa.dart';

class ItemTodoView extends StatelessWidget {
  final ItemTodo _itemTodo;
  const ItemTodoView(this._itemTodo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.amber,
        child: ListTile(
          title: Text(
            _itemTodo.titulo,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          subtitle: Text(
            _itemTodo.descricao,
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
          onTap: () => _onTap(context),
        ));
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Cadastro(itemTodo: _itemTodo)));
  }
}
