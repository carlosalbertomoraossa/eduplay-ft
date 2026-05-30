// Inyección de dependencias — GetIt + Injectable
// Spec: /specs/frontend/flutter-arch.md
// MVP: registro manual hasta que build_runner genere injection.config.dart

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Repositorios registrados manualmente en el MVP (mock).
  // En producción, ejecutar: dart run build_runner build --delete-conflicting-outputs
  // para generar injection.config.dart con @InjectableInit.
}
