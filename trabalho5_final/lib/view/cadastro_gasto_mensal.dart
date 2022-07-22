import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trabalho5_final/component/criar_textfield.dart';

import 'package:flutter/material.dart';
import 'package:trabalho5_final/controller/gasto_controller.dart';
import 'package:trabalho5_final/model/gasto_mensal.dart';
import 'package:trabalho5_final/view/gasto_item.dart';
import 'package:trabalho5_final/view/lista_gasto_mensal.dart';

class Cadastro extends StatefulWidget {
  GastoMensal? gastoMensal;

  Cadastro({Key? key, this.gastoMensal}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _tipoGasto = ["Fixo", "Variável", "Eventual", "Emergencial"];
  var _tipoGastoSelecionado = 'Fixo';
  final _mes = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  var _mesSelecionado = 'Janeiro';
  final _anoController = TextEditingController();
  final _mesController = TextEditingController();
  final _finalidadeController = TextEditingController();
  final _valorController = TextEditingController();
  final _tipoGastoController = TextEditingController();
  final _gastoController = GastoController();
  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _inserir(BuildContext context) {
    GastoMensal gastoMensal = GastoMensal(
        widget.gastoMensal?.id,
        int.parse(_anoController.text),
        _mesSelecionado,
        _finalidadeController.text,
        double.parse(_valorController.text),
        _tipoGastoSelecionado);
    setState(() {
      _gastoController.salvar(gastoMensal).then((res) {
        setState(() {
          _displaySnackBar(context, res);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.gastoMensal != null) {
      setState(() {
        _anoController.text = widget.gastoMensal!.ano.toString();
        _mesSelecionado = widget.gastoMensal!.mes;
        _finalidadeController.text = widget.gastoMensal!.finalidade;
        _valorController.text = widget.gastoMensal!.valor.toString();
        _tipoGastoSelecionado = widget.gastoMensal!.tipoGasto;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Gasto mensal \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListaGastoMensal()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  criarTextField("Ano", _anoController, TextInputType.number),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text(
                    "Mês:",
                    style: TextStyle(color: Colors.amber),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: DropdownButton(
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                      dropdownColor: Colors.black,
                      focusColor: Colors.black,
                      value: _mesSelecionado,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: _mes.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? novoMes) {
                        setState(() {
                          _mesSelecionado = novoMes!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criarTextField(
                  "Finalidade", _finalidadeController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criarTextField("Valor", _valorController,
                  TextInputType.numberWithOptions(decimal: true)),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  const Text(
                    "Tipo da despesa:",
                    style: TextStyle(color: Colors.amber),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: DropdownButton(
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                      dropdownColor: Colors.black,
                      focusColor: Colors.black,
                      value: _tipoGastoSelecionado,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: _tipoGasto.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? novoTipo) {
                        setState(() {
                          _tipoGastoSelecionado = novoTipo!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  onPressed: () => _inserir(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPrimary: Colors.green,
                  ),
                  label: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
