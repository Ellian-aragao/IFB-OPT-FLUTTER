import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/service/adapters/item_todo_persistence_adapter.dart';

class ItemTodoPersistenceDaoInMemory implements ItemTodoPersistenceAdapter {
  static int id = 1;
  static final Map<String, ItemTodo> _itemTodoMap = {};

  @override
  Future<List<ItemTodo>> buscarTodos() {
    return Future.value(_itemTodoMap.values.toList());
  }

  @override
  Future<void> excluir(String id) {
    _itemTodoMap.remove(id);
    return Future.value(null);
  }

  @override
  Future<ItemTodo> salvar(ItemTodo itemTodo) {
    if (itemTodo.hasNotId()) {
      itemTodo.id = setId();
    }
    _itemTodoMap[itemTodo.id] = itemTodo;
    return Future.value(itemTodo);
  }

  String setId() {
    var idString = id.toString();
    id++;
    return idString;
  }
}
