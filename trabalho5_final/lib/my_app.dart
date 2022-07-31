import 'package:flutter/material.dart';
import 'package:trabalho5_final/infrastructure/provider.dart';
import 'package:trabalho5_final/view/pagina_inicial/pagina_inicial.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderFactory.buildMemoryProvider(const InitialPage());
  }
}
