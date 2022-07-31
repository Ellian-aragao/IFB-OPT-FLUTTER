import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho5_final/infrastructure/persistence/item_todo_persistence_dao_firebase.dart';
import 'package:trabalho5_final/infrastructure/provider.dart';
import 'package:trabalho5_final/service/todo_service.dart';
import 'package:trabalho5_final/view/component/loading.dart';

class FirebasePersistence extends ProviderStatelessWidget {
  const FirebasePersistence({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  Widget providers(BuildContext context, Widget child) {
    return FutureBuilder(
      future: ItemTodoPersistenceDaoFirebase.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(home: loading());
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<TodoService>.value(
              value: TodoService(ItemTodoPersistenceDaoFirebase()),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
