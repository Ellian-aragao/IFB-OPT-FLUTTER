import 'dart:ffi';

import 'package:trabalho5_final/model/item_todo.dart';

abstract class ItemTodoPersistenceAdapter {
  Future<List<ItemTodo>> buscarTodos();
  Future<ItemTodo> salvar(ItemTodo itemTodo);
  Future<void> excluir(int id);
}
