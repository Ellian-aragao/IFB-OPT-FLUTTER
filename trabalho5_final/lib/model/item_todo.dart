class ItemTodo {
  String? _id;
  final String _titulo;
  final String _descricao;
  ItemTodo(this._id, this._titulo, this._descricao);
  String get titulo => _titulo;
  String get descricao => _descricao;
  String get id => _id!;

  set id(String value) {
    _id = value;
  }

  static ofTitleAndDescription(String title, String description) =>
      ItemTodo(null, title, description);

  bool hasId() => _id != null;
  bool hasNotId() => _id == null;

  @override
  String toString() {
    return 'ItemTodo{_id: $_id, _titulo: $_titulo, _descricao: $_descricao}';
  }
}
