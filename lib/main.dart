// EduPlay Flutter App
// Spec: /specs/frontend/flutter-arch.md
// UX Spec: /specs/product/ux-children.md

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/mock_auth_repository.dart';
import 'features/auth/presentation/bloc/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const ProviderScope(child: EduPlayApp()));
}

class EduPlayApp extends ConsumerWidget {
  const EduPlayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    // AuthCubit al nivel raíz para que persista en toda la navegación
    return BlocProvider(
      create: (_) => AuthCubit(MockAuthRepository()),
      child: MaterialApp.router(
        title: 'EduPlay',
        theme: EduPlayTheme.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
