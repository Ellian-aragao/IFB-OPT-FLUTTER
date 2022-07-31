import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trabalho5_final/infrastructure/providers/firebase_provider.dart';
import 'package:trabalho5_final/infrastructure/providers/memory_provider.dart';
import 'package:trabalho5_final/infrastructure/providers/sqllite_provider.dart';

abstract class ProviderStatelessWidget extends StatelessWidget {
  final Widget child;

  const ProviderStatelessWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return providers(context, child);
  }

  Widget providers(BuildContext context, Widget child);
}

abstract class ProviderFactory {
  static ProviderStatelessWidget buildFirebaseProvider(
    Widget child,
  ) =>
      FirebasePersistence(
        child: child,
      );

  static ProviderStatelessWidget buildMemoryProvider(
    Widget child,
  ) =>
      InMemoryPersistence(
        child: child,
      );

  static ProviderStatelessWidget buildSqlliteProvider(
    Widget child,
  ) =>
      SqllitePersistence(
        child: child,
      );
}
