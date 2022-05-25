import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DisciplinaArquivo {
  static const _fileName = 'disciplina.json';

  static Future<File> criaArquivo() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/$_fileName");
  }

  static Future<String> leArquivo() async {
    try {
      final file = await criaArquivo();
      return file.readAsString();
    } catch (e) {
      return "Erro ao ler o arquivo";
    }
  }

  static Future<File> escreveArquivo(Object data) async {
    final file = await criaArquivo();
    final encodedData = jsonEncode(data);
    return file.writeAsString(encodedData);
  }
}
