import 'package:flutter/foundation.dart';
import 'package:trabalho5_final/infrastructure/logging.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/service/adapters/item_todo_persistence_adapter.dart';

class TodoService extends ChangeNotifier {
  final ItemTodoPersistenceAdapter _itemTodoPersistenceAdapter;
  final log = LoggerFactory.getLoggerFromClass(TodoService);

  TodoService(this._itemTodoPersistenceAdapter);

  Future<List<ItemTodo>> findAll() async {
    log.info('buscando todos os itens todo');
    var todosOsItens = await _itemTodoPersistenceAdapter.buscarTodos();
    log.info('buscando todos os itens todo ok');
    return todosOsItens;
  }

  Future<String> salvar(ItemTodo itemTodo) async {
    if (itemTodo.hasId()) {
      log.info("update data base");
      await _itemTodoPersistenceAdapter.salvar(itemTodo);
      log.info("update data base ok");
      notifyListeners();
      return "Tarefa atualizada com sucesso!";
    }
    log.info("insert data base");
    await _itemTodoPersistenceAdapter.salvar(itemTodo);
    log.info("insert data base ok");
    notifyListeners();
    return "Tarefa inserida com sucesso!";
  }

  Future<String> excluir(String id) async {
    log.info("delete $id from data base");
    await _itemTodoPersistenceAdapter.excluir(id);
    log.info("delete $id from data base ok");
    notifyListeners();
    return "Excluído com sucesso.";
  }
}
