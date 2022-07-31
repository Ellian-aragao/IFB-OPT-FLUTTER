import 'package:trabalho5_final/model/item_todo.dart';

Map<String, dynamic> itemTodotoMap(ItemTodo itemTodo) {
  if (itemTodo.hasNotId()) {
    return {
      'titulo': itemTodo.titulo,
      'descricao': itemTodo.descricao,
    };
  }

  return {
    "_id": itemTodo.id,
    "titulo": itemTodo.titulo,
    "descricao": itemTodo.descricao
  };
}
