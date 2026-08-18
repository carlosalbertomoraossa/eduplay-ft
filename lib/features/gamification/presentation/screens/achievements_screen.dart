// Pantalla de Logros — grid de los 10 logros del catálogo MVP
// Spec: /specs/domains/gamification/spec.md — sección "Catálogo de logros (MVP)"

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/gamification_entities.dart';

// Mock — reemplazar con GamificationBloc + GET /v1/gamification/achievements/{child_id}
// cuando exista gamification-service (ver bloque 12.1 del backlog).
// 4 de 10 desbloqueados, coherente con el mock de Sofía (nivel 3, streak 5,
// unidad 1 completa) usado en home_screen y parent_dashboard.
class _MockAchievements {
  static const list = [
    Achievement(
      code: 'first_lesson',
      name: '¡Primera Lección!',
      description: 'Completa 1 lección',
      emoji: '🎯',
      unlocked: true,
    ),
    Achievement(
      code: 'streak_3',
      name: '3 Días Seguidos',
      description: 'Streak de 3 días',
      emoji: '🔥',
      unlocked: true,
    ),
    Achievement(
      code: 'streak_7',
      name: 'Una Semana Ganadora',
      description: 'Streak de 7 días',
      emoji: '🏅',
      unlocked: false,
    ),
    Achievement(
      code: 'perfect_lesson',
      name: '¡Sin Errores!',
      description: 'Completa una lección con 100%',
      emoji: '💯',
      unlocked: true,
    ),
    Achievement(
      code: 'level_5',
      name: 'Nivel 5',
      description: 'Alcanza el nivel 5',
      emoji: '⭐',
      unlocked: false,
    ),
    Achievement(
      code: 'first_unit',
      name: 'Unidad Completa',
      description: 'Completa tu primera unidad',
      emoji: '📘',
      unlocked: true,
    ),
    Achievement(
      code: 'early_bird',
      name: 'Madrugador',
      description: 'Completa una lección antes de las 8am',
      emoji: '🌅',
      unlocked: false,
    ),
    Achievement(
      code: 'night_owl',
      name: 'Búho Nocturno',
      description: 'Completa una lección después de las 8pm',
      emoji: '🦉',
      unlocked: false,
    ),
    Achievement(
      code: 'comeback',
      name: '¡Regresé!',
      description: 'Vuelve después de 7 días sin actividad',
      emoji: '👋',
      unlocked: false,
    ),
    Achievement(
      code: 'boss_slayer',
      name: 'Derroté al Jefe',
      description: 'Completa una boss lesson',
      emoji: '⚔️',
      unlocked: false,
    ),
  ];

  static int get unlockedCount => list.where((a) => a.unlocked).length;
}

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const achievements = _MockAchievements.list;
    final unlockedCount = _MockAchievements.unlockedCount;

    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            backgroundColor: EduPlayColors.adventurePurple,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () =>
                  context.canPop() ? context.pop() : context.go('/home'),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'Logros',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7B1FA2), Color(0xFFA855F7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Text(
                        '$unlockedCount de ${achievements.length} logros desbloqueados',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => _AchievementCard(achievement: achievements[i])
                    .animate(delay: Duration(milliseconds: i * 60))
                    .fadeIn(duration: 300.ms)
                    .scaleXY(begin: 0.9, end: 1.0),
                childCount: achievements.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;
  const _AchievementCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement.unlocked;

    return Semantics(
      label: unlocked
          ? '${achievement.name}: ${achievement.description}'
          : '${achievement.name}, bloqueado: ${achievement.description}',
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: unlocked
              ? const LinearGradient(
                  colors: [Color(0xFFFEF3C7), Color(0xFFFDE68A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.grey.shade200, Colors.grey.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: unlocked ? const Color(0xFFF59E0B) : Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: unlocked ? 1.0 : 0.4,
              child: Text(achievement.emoji, style: const TextStyle(fontSize: 38)),
            ),
            if (!unlocked)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(Icons.lock_rounded, size: 16, color: Color(0xFF94A3B8)),
              ),
            const SizedBox(height: 8),
            Text(
              achievement.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                fontFamily: 'Nunito',
                color: unlocked ? const Color(0xFF92400E) : EduPlayColors.textMedium,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              achievement.description,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Nunito',
                color: unlocked ? const Color(0xFFB45309) : EduPlayColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
