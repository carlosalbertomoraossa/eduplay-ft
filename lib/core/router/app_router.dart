// EduPlay — Navegación
// Spec: /specs/frontend/flutter-arch.md — sección Navegación

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/auth/presentation/screens/child_selector_screen.dart';
import '../../features/auth/presentation/screens/parent_login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/lesson/domain/entities/lesson.dart';
import '../../features/lesson/presentation/screens/lesson_result_screen.dart';
import '../../features/lesson/presentation/screens/lesson_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/parent_dashboard/presentation/screens/child_progress_screen.dart';
import '../../features/parent_dashboard/presentation/screens/parent_dashboard_screen.dart';
import '../../features/games/g4_adventure/presentation/screens/game_play_screen.dart';
import '../../features/games/g4_adventure/presentation/screens/game_result_screen.dart';
import '../../features/games/g4_adventure/domain/entities/game_result.dart';
import '../../features/subjects/presentation/screens/lessons_screen.dart';
import '../../features/subjects/presentation/screens/units_screen.dart';

const _publicRoutes = {'/', '/onboarding', '/auth/login', '/auth/select-child'};
const _parentRoutes = {'/parent/dashboard'};
const _childRoutes = {'/home', '/achievements', '/leaderboard', '/settings'};

bool _isPublic(String location) => _publicRoutes.contains(location);
bool _isParent(String location) =>
    _parentRoutes.contains(location) || location.startsWith('/parent/');
bool _isChild(String location) =>
    _childRoutes.contains(location) ||
    location.startsWith('/subjects/') ||
    location.startsWith('/lessons/') ||
    location.startsWith('/lesson-result') ||
    location.startsWith('/games/');

// AuthCubit vive en main.dart (BlocProvider raíz) y es accesible desde todos los routes
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final auth = context.read<AuthCubit>().state;
      final location = state.uri.toString();

      // Rutas públicas siempre accesibles
      if (_isPublic(location)) return null;

      // Si no está autenticado, redirigir a onboarding
      if (auth is AuthInitial || auth is AuthUnauthenticated) {
        return '/onboarding';
      }

      // Padre autenticado solo puede ver rutas de padre
      if (auth is AuthParentLoggedIn && !_isParent(location)) {
        return '/parent/dashboard';
      }

      // Niño autenticado solo puede ver rutas de niño
      if (auth is AuthChildLoggedIn && !_isChild(location)) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (_, __) => const ParentLoginScreen(),
      ),
      GoRoute(
        path: '/auth/select-child',
        builder: (_, __) => const ChildSelectorScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: '/subjects/:subject_code/units',
        builder: (_, state) => UnitsScreen(
          subjectCode: state.pathParameters['subject_code']!,
        ),
      ),
      GoRoute(
        path: '/subjects/:unit_id/lessons',
        builder: (_, state) => LessonsScreen(
          unitId: state.pathParameters['unit_id']!,
        ),
      ),
      GoRoute(
        path: '/lessons/:lesson_id',
        builder: (_, state) => LessonScreen(
          lessonId: state.pathParameters['lesson_id']!,
        ),
      ),
      GoRoute(
        path: '/lesson-result',
        builder: (_, state) {
          final result = state.extra as LessonResult;
          return LessonResultScreen(result: result);
        },
      ),
      GoRoute(
        path: '/achievements',
        builder: (_, __) => const _ScreenPlaceholder('Logros'),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (_, __) => const _ScreenPlaceholder('Ranking'),
      ),
      GoRoute(
        path: '/parent/dashboard',
        builder: (_, __) => const ParentDashboardScreen(),
      ),
      GoRoute(
        path: '/parent/child/:child_id',
        builder: (_, state) => ChildProgressScreen(
          childId: state.pathParameters['child_id']!,
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const _ScreenPlaceholder('Configuración'),
      ),
      // ── Juegos ────────────────────────────────────────────────────────────
      GoRoute(
        path: '/games/g4-adventure',
        builder: (_, __) => const GamePlayScreen(level: 1),
      ),
      GoRoute(
        path: '/games/g4-adventure/play/:level',
        builder: (_, state) => GamePlayScreen(
          level: int.tryParse(state.pathParameters['level'] ?? '1') ?? 1,
        ),
      ),
      GoRoute(
        path: '/games/g4-adventure/result',
        builder: (_, state) {
          final result = state.extra as GameResult;
          return GameResultScreen(result: result);
        },
      ),
    ],
  );
});

class _ScreenPlaceholder extends StatelessWidget {
  final String name;
  const _ScreenPlaceholder(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text(name)),
    );
  }
}
