class ItemTodo {
  int? _id;
  final String _titulo;
  final String _descricao;
  ItemTodo(this._id, this._titulo, this._descricao);
  String get titulo => _titulo;
  String get descricao => _descricao;
  int get id => _id!;
  set id(int value) {
    _id = value;
  }

  @override
  String toString() {
    return 'ItemTodo{_id: $_id, _titulo: $_titulo, _descricao: $_descricao}';
  }
}
