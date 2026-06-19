// EduPlay Flutter App
// Spec: /specs/frontend/flutter-arch.md
// UX Spec: /specs/product/ux-children.md

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injection.dart';
import 'core/providers/selected_grade_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        selectedGradeProvider.overrideWith(
          (_) => SelectedGradeNotifier(prefs),
        ),
      ],
      child: const EduPlayApp(),
    ),
  );
}

class EduPlayApp extends ConsumerWidget {
  const EduPlayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: MaterialApp.router(
        title: 'EduPlay',
        theme: EduPlayTheme.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
