import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho5_final/infrastructure/provider.dart';
import 'package:trabalho5_final/persistence/impl/item_todo_persistence_dao_memory.dart';
import 'package:trabalho5_final/persistence/impl/item_todo_persistence_dao_sqlite.dart';
import 'package:trabalho5_final/service/todo_service.dart';
import 'package:trabalho5_final/view/pagina_inicial/pagina_inicial.dart';

class SqllitePersistence extends ProviderStatelessWidget {
  const SqllitePersistence({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  Widget providers(BuildContext context, Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoService>.value(
          value: TodoService(ItemTodoPersistenceDaoSqlite.instance),
        ),
      ],
      child: child,
    );
  }
}
