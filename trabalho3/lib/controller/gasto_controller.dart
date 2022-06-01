import 'dart:developer';

import 'package:trabalho3/model/gasto_mensal.dart';
import 'package:trabalho3/persistence/gasto_mensal_dao.dart';

class GastoController {
  Future<List<GastoMensal>> findAll() async {
    List<GastoMensal> gastos = await GastoMensalDao.findAll();
    return gastos;
  }

  Future<String> salvar(GastoMensal gastoMensal) async {
    int res = 0;
    try {
      gastoMensal.id != null;
      res = await GastoMensalDao.alterar(gastoMensal);
    } catch (e) {
      res = await GastoMensalDao.inserir(gastoMensal);
    }
    if (res == 0) {
      return "Erro ao salvar registro";
    } else {
      return "Salvo com sucesso.";
    }
  }

  Future<String> excluir(int id) async {
    int res = 0;
    res = await GastoMensalDao.excluir(id);
    if (res == 0) {
      return "Erro ao excluir registro";
    } else {
      return "Excluído com sucesso.";
    }
  }
}
