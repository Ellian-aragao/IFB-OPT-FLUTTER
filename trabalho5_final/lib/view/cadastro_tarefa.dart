import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trabalho5_final/component/criar_textfield.dart';

import 'package:flutter/material.dart';
import 'package:trabalho5_final/model/item_todo.dart';
import 'package:trabalho5_final/service/todo_service.dart';
import 'package:trabalho5_final/view/lista_gasto_mensal.dart';

class Cadastro extends StatefulWidget {
  ItemTodo? itemTodo;

  Cadastro({Key? key, this.itemTodo}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _todoService = TodoService();

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _inserir(BuildContext context) {
    setState(() {
      var itemTodo =
          ItemTodo(null, _titleController.text, _descriptionController.text);
      _todoService.salvar(itemTodo);
      _displaySnackBar(context, "Tarefa inserida com sucesso!");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ListaGastoMensal()));
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.itemTodo == null) {
      return;
    }
    setState(() {
      _titleController.text = widget.itemTodo!.titulo.toString();
      _descriptionController.text = widget.itemTodo!.descricao.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Adicionando tarefa"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _voltar,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criarTextField("Título", _titleController),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criarTextField(
                "Descrição",
                _descriptionController,
                maxLines: 5,
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
                    padding: const EdgeInsets.all(8.0),
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

  void _voltar() {
    Navigator.pop(context);
  }
}