import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:trabalho5_final/infrastructure/firebase/firebase_options.dart';
import 'package:trabalho5_final/infrastructure/logging.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trabalho5_final/service/adapters/item_todo_persistence_adapter.dart';

class ItemTodoPersistenceDaoFirebase implements ItemTodoPersistenceAdapter {
  final log = LoggerFactory.getLoggerFromClass(ItemTodoPersistenceDaoFirebase);
  final db = FirebaseDatabase.instance;
  final rootKey = "item-todo";

  static Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp(
      name: 'item-todo-app',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<List<ItemTodo>> buscarTodos() async {
    log.info('realizando busca em todos os itens');
    var event = await db.ref(rootKey).once(DatabaseEventType.value);
    log.info('busca realizada, dados encontrados: ${event.snapshot.value}');
    if (event.snapshot.value == null) return List.empty();
    return _mapValueToListTodoItem(event.snapshot.value as LinkedHashMap);
  }

  @override
  Future<void> excluir(String id) async {
    log.info('realizando exclusão de item com id: $id');
    await db.ref(rootKey).child(id).remove();
    log.info('exclusão realizada');
    return Future.value(null);
  }

  @override
  Future<ItemTodo> salvar(ItemTodo itemTodo) async {
    log.info('realizando salvar de item: $itemTodo');
    if (itemTodo.hasNotId()) {
      log.info('item ainda não possui id, realizando inserção');
      await db.ref(rootKey).push().set(itemTodo.toMap());
      log.info('inserção realizada');
      return itemTodo;
    }
    log.info('item já possui id, realizando atualização');
    await db.ref(rootKey).child(itemTodo.id).set(itemTodo.toMap());
    log.info('atualização realizada');
    return itemTodo;
  }

  List<ItemTodo> _mapValueToListTodoItem(LinkedHashMap dataFromFirebase) {
    return dataFromFirebase.entries
        .map((entry) => ItemTodo(
            entry.key, entry.value['titulo'], entry.value['descricao']))
        .toList();
  }
}
