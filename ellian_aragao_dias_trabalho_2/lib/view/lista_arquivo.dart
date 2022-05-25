import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trabalho_henrique_aguiar/model/disciplina.dart';
import 'package:trabalho_henrique_aguiar/persistence/disciplina_arquivo.dart';

class ViewArquivo extends StatefulWidget {
  const ViewArquivo({Key? key, required this.titulo}) : super(key: key);

  final String titulo;

  @override
  State<ViewArquivo> createState() => ViewArquivoState();
}

class ViewArquivoState extends State<ViewArquivo> {
  final _formKey = GlobalKey<FormState>();

  final _disciplinaController = TextEditingController();
  final _cargaHorariaController = TextEditingController();
  final _codigoController = TextEditingController();

  final _disciplinas = <Disciplina>[];

  @override
  initState() {
    super.initState();
    fetchData() async {
      _disciplinas.clear();
      final _disciplinasArquivo = await DisciplinaArquivo.leArquivo();
      final disciplinasDoArquivo = List.from(jsonDecode(_disciplinasArquivo))
          .map((disciplinaJson) => Disciplina.fromJson(disciplinaJson));
      setState(() {
        _disciplinas.addAll(disciplinasDoArquivo);
      });
    }

    fetchData();
  }

  _adicionaDisciplina() {
    setState(() {
      _disciplinas.add(Disciplina(
        int.parse(_codigoController.text),
        _disciplinaController.text,
        int.parse(_cargaHorariaController.text),
      ));

      _codigoController.text = "";
      _disciplinaController.text = "";
      _cargaHorariaController.text = "";

      DisciplinaArquivo.escreveArquivo(_disciplinas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _codigoController,
                    decoration: const InputDecoration(
                      label: Text('Código da disciplina'),
                    ),
                    validator: _validaCodigoDaDisciplina,
                  ),
                  TextFormField(
                    controller: _disciplinaController,
                    decoration: const InputDecoration(
                      label: Text('Nome da disciplina'),
                    ),
                    validator: _validaNomeDaDisciplina,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _cargaHorariaController,
                    decoration: const InputDecoration(
                      label: Text('Carga Horária da disciplina'),
                    ),
                    validator: _validaCargaHorariaDaDisciplina,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: ElevatedButton(
                      onPressed: _noClickAdicionaDisciplina,
                      child: const Text("Adiciona disciplina"),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _disciplinas.length,
              itemBuilder: (BuildContext context, int index) {
                final disciplina = _disciplinas[index];
                return Container(
                  height: 50,
                  margin: const EdgeInsets.all(2),
                  // alignment: ,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          disciplina.descricao,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "(${disciplina.cargaHoraria} h/a - ${disciplina.transformCargaHoraria()}h)",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _noClickAdicionaDisciplina() {
    if (_formKey.currentState?.validate() == true) {
      _adicionaDisciplina();
    }
  }

  String? _validaCodigoDaDisciplina(String? codigo) {
    if (codigo == null || codigo.isEmpty) {
      return 'O código da disciplina é obrigatório';
    }
    if (codigo.length != 3) {
      return 'O código da disciplina deve ter 3 dígitos';
    }
    return null;
  }

  String? _validaNomeDaDisciplina(String? value) {
    if (value == null || value.isEmpty) {
      return "Nome não pode ser nulo";
    }
    return null;
  }

  String? _validaCargaHorariaDaDisciplina(value) {
    if (value == null || value.isEmpty) {
      return "Carga Horária não pode ser nulo";
    }
    if (int.tryParse(value) == null) {
      return "Valor inválido";
    }
    return null;
  }
}
