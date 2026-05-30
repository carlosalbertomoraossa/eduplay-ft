// Dashboard parental — vista del padre sobre sus hijos
// Spec: /specs/domains/parents/spec.md

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/parent_entities.dart';

// Mock — reemplazar con ParentDashboardBloc cuando exista parent-service
class _MockParentData {
  static const parentName = 'María';
  static final children = [
    ChildSummary(
      childId: 'child-001',
      displayName: 'Sofía',
      grade: 2,
      avatarEmoji: '👧',
      streakCurrent: 5,
      xpThisWeek: 140,
      lessonsThisWeek: 3,
      minutesThisWeek: 21,
      lastActive: DateTime.now().subtract(const Duration(hours: 2)),
      mathProgress: 0.33,
    ),
  ];
}

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Panel Familiar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/auth/select-child'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configuración',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _GreetingCard(parentName: _MockParentData.parentName)
              .animate()
              .fadeIn(duration: 350.ms),

          const SizedBox(height: 24),

          const Text(
            'Mis hijos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EduPlayColors.textDark,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(height: 12),

          ..._MockParentData.children.asMap().entries.map((entry) {
            return _ChildCard(child: entry.value)
                .animate(delay: Duration(milliseconds: entry.key * 80))
                .fadeIn(duration: 350.ms)
                .slideX(begin: 0.06, end: 0);
          }),

          const SizedBox(height: 24),
          _TipsBanner()
              .animate(delay: 200.ms)
              .fadeIn(duration: 400.ms),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ─── Greeting card ─────────────────────────────────────────────────
class _GreetingCard extends StatelessWidget {
  final String parentName;
  const _GreetingCard({required this.parentName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('👩‍👧', style: TextStyle(fontSize: 48)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola, $parentName!',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Aquí está el progreso de tus hijos esta semana.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
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

// ─── Child card ────────────────────────────────────────────────────
class _ChildCard extends StatelessWidget {
  final ChildSummary child;
  const _ChildCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/parent/child/${child.childId}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: EduPlayColors.primaryBlue.withValues(alpha: 0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: avatar + nombre + grado
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: EduPlayColors.backgroundLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(child.avatarEmoji,
                        style: const TextStyle(fontSize: 30)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: EduPlayColors.textDark,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      Text(
                        'Grado ${child.grade}° · Activa hace 2 horas',
                        style: const TextStyle(
                          fontSize: 12,
                          color: EduPlayColors.textMedium,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: EduPlayColors.textMedium),
              ],
            ),

            const SizedBox(height: 16),

            // Stats row
            Row(
              children: [
                _StatChip(
                  emoji: '🔥',
                  value: '${child.streakCurrent}',
                  label: 'racha',
                  color: const Color(0xFFFF6B35),
                ),
                const SizedBox(width: 10),
                _StatChip(
                  emoji: '⭐',
                  value: '${child.xpThisWeek}',
                  label: 'XP semana',
                  color: const Color(0xFFB45309),
                ),
                const SizedBox(width: 10),
                _StatChip(
                  emoji: '📚',
                  value: '${child.lessonsThisWeek}',
                  label: 'lecciones',
                  color: EduPlayColors.primaryBlue,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Barra de progreso Matemáticas
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '🔢 Matemáticas',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      '${(child.mathProgress * 100).round()}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.primaryBlue,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: child.mathProgress,
                    minHeight: 8,
                    backgroundColor: EduPlayColors.backgroundLight,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        EduPlayColors.primaryBlue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Ver detalle button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.push('/parent/child/${child.childId}'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: EduPlayColors.primaryBlue,
                  side: const BorderSide(color: EduPlayColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Ver progreso detallado',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color color;

  const _StatChip({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: color,
                fontFamily: 'Nunito',
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: EduPlayColors.textMedium,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tips banner ───────────────────────────────────────────────────
class _TipsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        border: Border.all(color: EduPlayColors.successGreen.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('💡', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consejo para esta semana',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF15803D),
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Sofía lleva 5 días seguidos. ¡Anímala a completar su lección de hoy para mantener la racha!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF166534),
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
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
