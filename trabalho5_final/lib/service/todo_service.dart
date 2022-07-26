import 'package:trabalho5_final/model/item_todo.dart';

class TodoService {
  final _lista = [ItemTodo(1, "titulo", "Descrição")];

  list() => Future.delayed(const Duration(seconds: 2), () => _lista);

  Future<List<ItemTodo>> findAll() async {
    print("findAll");
    print(_lista);
    List<ItemTodo> gastos = await list();
    return gastos;
  }

  Future<String> salvar(ItemTodo itemTodo) async {
    int res = 0;
    try {
      itemTodo.id != null;
      print("update data base");
    } catch (e) {
      print("insert data base");
      _lista.insert(0, itemTodo);
      res = 1;
    }
    if (res == 0) {
      return "Erro ao salvar registro";
    } else {
      return "Salvo com sucesso.";
    }
  }

  Future<String> excluir(int id) async {
    int res = 0;
    print("delete $id from data base");
    // res = await GastoMensalDao.excluir(id);
    if (res == 0) {
      return "Erro ao excluir registro";
    } else {
      return "Excluído com sucesso.";
    }
  }
}
