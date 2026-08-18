// Pantalla de Ranking — leaderboard semanal de amigos
// Spec: /specs/domains/gamification/spec.md — regla 7: "ranking de amigos
// solo muestra XP semanal (no histórico total) para mayor competitividad"

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/gamification_entities.dart';

// Mock — reemplazar con GamificationBloc + GET /v1/gamification/leaderboard
// cuando exista gamification-service (ver bloque 12.2 del backlog).
// Sofía en posición 4 con 140 XP semanales — coherente con
// `_MockParentData.children` en parent_dashboard_screen.dart.
class _MockLeaderboard {
  static const currentChildName = 'Sofía';

  static const entries = [
    LeaderboardEntry(
        position: 1, displayName: 'Mateo', avatarEmoji: '👦', xpThisWeek: 210),
    LeaderboardEntry(
        position: 2, displayName: 'Valentina', avatarEmoji: '👧', xpThisWeek: 195),
    LeaderboardEntry(
        position: 3, displayName: 'Juan', avatarEmoji: '👦', xpThisWeek: 160),
    LeaderboardEntry(
      position: 4,
      displayName: currentChildName,
      avatarEmoji: '👧',
      xpThisWeek: 140,
      isCurrentChild: true,
    ),
    LeaderboardEntry(
        position: 5, displayName: 'Camila', avatarEmoji: '👧', xpThisWeek: 125),
    LeaderboardEntry(
        position: 6, displayName: 'Andrés', avatarEmoji: '👦', xpThisWeek: 110),
    LeaderboardEntry(
        position: 7, displayName: 'Isabella', avatarEmoji: '👧', xpThisWeek: 95),
    LeaderboardEntry(
        position: 8, displayName: 'Samuel', avatarEmoji: '👦', xpThisWeek: 80),
  ];
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Ranking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          const _WeekBanner().animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 16),
          ..._MockLeaderboard.entries.asMap().entries.map((entry) {
            return _LeaderboardRow(entry: entry.value)
                .animate(delay: Duration(milliseconds: entry.key * 60))
                .fadeIn(duration: 300.ms)
                .slideX(begin: 0.05, end: 0);
          }),
        ],
      ),
    );
  }
}

class _WeekBanner extends StatelessWidget {
  const _WeekBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1CB0F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Text('🏆', style: TextStyle(fontSize: 30)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ranking semanal de amigos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  ),
                ),
                Text(
                  'Se reinicia cada lunes · basado en XP de esta semana',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  const _LeaderboardRow({required this.entry});

  static const _medals = {1: '🥇', 2: '🥈', 3: '🥉'};

  @override
  Widget build(BuildContext context) {
    final highlight = entry.isCurrentChild;

    return Semantics(
      label:
          'Posición ${entry.position}: ${entry.displayName}, ${entry.xpThisWeek} XP esta semana'
          '${highlight ? ", tú" : ""}',
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: highlight ? EduPlayColors.primaryBlue.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: highlight
              ? Border.all(color: EduPlayColors.primaryBlue, width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: EduPlayColors.primaryBlue.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: _medals.containsKey(entry.position)
                  ? Text(_medals[entry.position]!, style: const TextStyle(fontSize: 22))
                  : Text(
                      '${entry.position}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: EduPlayColors.textMedium,
                        fontFamily: 'Nunito',
                      ),
                    ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: EduPlayColors.backgroundLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(entry.avatarEmoji, style: const TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Text(
                    entry.displayName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nunito',
                      color: highlight ? EduPlayColors.primaryBlue : EduPlayColors.textDark,
                    ),
                  ),
                  if (highlight) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: EduPlayColors.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Tú',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              '${entry.xpThisWeek} XP',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFFB45309),
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
