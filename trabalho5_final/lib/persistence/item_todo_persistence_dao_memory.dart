import 'dart:ffi';

import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/persistence/item_todo_persistence_adapter.dart';

class ItemTodoPersistenceDaoInMemory implements ItemTodoPersistenceAdapter {
  static int id = 1;
  static final Map<int, ItemTodo> _itemTodoMap = {};

  @override
  Future<List<ItemTodo>> buscarTodos() {
    return Future.value(_itemTodoMap.values.toList());
  }

  @override
  Future<void> excluir(int id) {
    _itemTodoMap.remove(id);
    return Future.value(null);
  }

  @override
  Future<ItemTodo> salvar(ItemTodo itemTodo) {
    if (itemTodo.hasNotId()) {
      itemTodo = ItemTodo(id++, itemTodo.titulo, itemTodo.descricao);
    }
    _itemTodoMap[itemTodo.id] = itemTodo;
    return Future.value(itemTodo);
  }
}
