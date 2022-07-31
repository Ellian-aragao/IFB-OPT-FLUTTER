import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/persistence/item_todo_persistence_adapter.dart';

class ItemTodoPersistenceDaoSqlite extends ItemTodoPersistenceAdapter {
  static const _databaseName = "item_todo.db";
  static const _databaseVersion = 1;
  static const table = "item_todo";
  static const _id = "_id";
  static const _titulo = "titulo";
  static const _descricao = "descricao";

  static Database? _database;

  static final ItemTodoPersistenceDaoSqlite instance =
      ItemTodoPersistenceDaoSqlite._privateConstructor();

  ItemTodoPersistenceDaoSqlite._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $table (
      $_id INTEGER PRIMARY KEY,
      $_titulo TEXT NOT NULL,
      $_descricao TEXT NOT NULL
    )""");
  }

  static Future<int> inserir(ItemTodo itemTodo) async {
    var result = 0;
    try {
      Database db = await instance.database;
      result = await db.insert(table, Map.from(itemTodo.toMap()));
    } catch (e) {
      print("erro ao inserir: $e");
      return 0;
    }
    return result;
  }

  static Future<List<ItemTodo>> findAll() async {
    var db = await instance.database;
    var result = await db.query(table);
    return _toList(result);
  }

  static List<ItemTodo> _toList(List<Map<String, dynamic>> result) {
    return result
        .map((row) => ItemTodo(row[_id], row[_titulo], row[_descricao]))
        .toList();
  }

  static Future<int> alterar(ItemTodo itemTodo) async {
    var result = 0;
    try {
      Database db = await instance.database;
      result = await db.update(table, itemTodo.toMap(),
          where: "$_id = ?", whereArgs: [itemTodo.id]);
    } on Exception {
      return 0;
    }
    return result;
  }

  @override
  Future<void> excluir(String id) async {
    Database db = await instance.database;
    await db.delete(table, where: "$_id = ?", whereArgs: [id]);
  }

  @override
  Future<List<ItemTodo>> buscarTodos() {
    return ItemTodoPersistenceDaoSqlite.findAll();
  }

  @override
  Future<ItemTodo> salvar(ItemTodo itemTodo) async {
    if (itemTodo.hasNotId()) {
      await inserir(itemTodo);
      return itemTodo;
    }
    await alterar(itemTodo);
    return itemTodo;
  }
}
