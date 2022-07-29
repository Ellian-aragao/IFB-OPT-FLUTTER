import 'package:flutter/foundation.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/persistence/item_todo_persistence_adapter.dart';

class TodoService extends ChangeNotifier {
  final ItemTodoPersistenceAdapter _itemTodoPersistenceAdapter;

  TodoService(this._itemTodoPersistenceAdapter);

  Future<List<ItemTodo>> findAll() {
    return _itemTodoPersistenceAdapter.buscarTodos();
  }

  Future<String> salvar(ItemTodo itemTodo) async {
    if (itemTodo.hasId()) {
      print("update data base");
      await _itemTodoPersistenceAdapter.salvar(itemTodo);
      notifyListeners();
      return "Tarefa atualizada com sucesso!";
    }
    print("insert data base");
    await _itemTodoPersistenceAdapter.salvar(itemTodo);
    notifyListeners();
    return "Tarefa inserida com sucesso!";
  }

  Future<String> excluir(int id) async {
    print("delete $id from data base");
    await _itemTodoPersistenceAdapter.excluir(id);
    notifyListeners();
    return "Excluído com sucesso.";
  }
}
