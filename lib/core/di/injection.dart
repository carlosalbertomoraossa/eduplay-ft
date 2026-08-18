// Inyección de dependencias — GetIt + Injectable
// Spec: /specs/frontend/flutter-arch.md
// MVP: registro manual hasta que build_runner genere injection.config.dart

import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/mock_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/games/g4_adventure/presentation/bloc/game_bloc.dart';
import '../../features/lesson/presentation/bloc/lesson_bloc.dart';
import '../network/api_client.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Repositorio de auth (singleton — mock hasta que backend esté listo)
  getIt.registerLazySingleton<AuthRepository>(() => MockAuthRepository());

  // API Client (pendiente de conectar)
  getIt.registerLazySingleton(() => ApiClient());

  // BLoCs / Cubits — factory: nueva instancia por pantalla
  getIt.registerFactory(() => AuthCubit(getIt<AuthRepository>()));
  getIt.registerFactory(() => LessonBloc());
  getIt.registerFactory(() => GameBloc());
}
