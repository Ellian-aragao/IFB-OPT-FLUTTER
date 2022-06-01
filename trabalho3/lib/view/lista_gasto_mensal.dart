import 'package:flutter/material.dart';
import 'package:trabalho3/controller/gasto_controller.dart';
import 'package:trabalho3/model/gasto_mensal.dart';
import 'package:trabalho3/view/cadastro_gasto_mensal.dart';
import 'package:trabalho3/view/gasto_item.dart';

class ListaGastoMensal extends StatefulWidget {
  @override
  _ListaGastoMensalState createState() => _ListaGastoMensalState();
}

class _ListaGastoMensalState extends State<ListaGastoMensal> {
  final GastoController _gastoController = GastoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("\$ Gasto mensal \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<GastoMensal>>(
        initialData: const [],
        future: _gastoController.findAll(),
        builder: listPresenter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cadastro(),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget listPresenter(context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        break;
      case ConnectionState.waiting:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              CircularProgressIndicator(),
              Text("Carregando..."),
            ],
          ),
        );
      case ConnectionState.active:
        break;
      case ConnectionState.done:
        final List<GastoMensal> gastos = snapshot.data!;
        return ListView.builder(
          itemBuilder: (context, index) {
            final GastoMensal gastoMensal = gastos[index];
            return Dismissible(
              key: Key(index.toString()),
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) =>
                  _gastoController.excluir(gastoMensal.id),
              direction: DismissDirection.startToEnd,
              child: GastoItem(gastoMensal),
            );
          },
          itemCount: gastos.length,
        );
    }
    return const Text("Erro");
  }
}
