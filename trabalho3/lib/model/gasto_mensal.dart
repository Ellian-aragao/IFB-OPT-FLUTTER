class GastoMensal {
  int? _id;
  int _ano;
  String _mes;
  String _finalidade;
  double _valor;
  String _tipoGasto;
  GastoMensal(this._id, this._ano, this._mes, this._finalidade, this._valor,
      this._tipoGasto);
  double get valor => _valor;
  String get finalidade => _finalidade;
  String get mes => _mes;
  int get ano => _ano;
  int get id => _id!;
  set id(int value) {
    _id = value;
  }

  get tipoGasto => _tipoGasto;
  Map<String, Object> getGastoMensal() {
    return {
      "_id": id,
      "_ano": ano,
      "_mes": mes,
      "_finalidade": finalidade,
      "_valor": valor,
      "_tipoGasto": tipoGasto
    };
  }

  @override
  String toString() {
    return "Ano: $_ano \n Mês: $_mes \n Finalidade: $_finalidade \nValor: $_valor \n Tipo de Gasto: $_tipoGasto";
  }
}
