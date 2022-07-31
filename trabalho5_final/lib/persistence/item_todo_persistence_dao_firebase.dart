import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:trabalho5_final/firebase_options.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/persistence/item_todo_persistence_adapter.dart';
import 'package:firebase_database/firebase_database.dart';

class ItemTodoPersistenceDaoFirebase implements ItemTodoPersistenceAdapter {
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
    var event = await db.ref(rootKey).once(DatabaseEventType.value);
    if (event.snapshot.value == null) return List.empty();
    return _mapValueToListTodoItem(event.snapshot.value as LinkedHashMap);
  }

  @override
  Future<void> excluir(String id) async {
    await db.ref(rootKey).child(id).remove();
    return Future.value(null);
  }

  @override
  Future<ItemTodo> salvar(ItemTodo itemTodo) async {
    if (itemTodo.hasNotId()) {
      await db.ref(rootKey).push().set(itemTodo.toMap());
      return itemTodo;
    }
    await db.ref(rootKey).child(itemTodo.id).set(itemTodo.toMap());
    return itemTodo;
  }

  List<ItemTodo> _mapValueToListTodoItem(LinkedHashMap dataFromFirebase) {
    return dataFromFirebase.entries
        .map((entry) => ItemTodo(
            entry.key, entry.value['titulo'], entry.value['descricao']))
        .toList();
  }
}
