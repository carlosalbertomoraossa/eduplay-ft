// Controles parentales — límite de tiempo, horario permitido, privacidad
// Spec: /specs/domains/parents/spec.md — sección "Controles parentales"
// Ruta: /parent/settings. UI-only, sin persistencia real todavía
// (12.7 depende de 9.5 — backend parent-service — para persistir).

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class ParentSettingsScreen extends StatefulWidget {
  const ParentSettingsScreen({super.key});

  @override
  State<ParentSettingsScreen> createState() => _ParentSettingsScreenState();
}

class _ParentSettingsScreenState extends State<ParentSettingsScreen> {
  // Estado local — controles parentales UI-only (spec: /specs/domains/parents/spec.md).
  // Valores por defecto coherentes con la tabla "Controles parentales" de la spec.
  int _dailyLessonLimit = 0; // 0 = sin límite
  RangeValues _allowedHours = const RangeValues(7, 20); // sin restricción real
  bool _showInLeaderboard = false; // default: desactivado (privacidad)
  bool _parentNotifications = true; // default: activado

  String _hourLabel(double h) => '${h.round().toString().padLeft(2, '0')}:00';

  Future<void> _confirmTemporaryBlock() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Bloquear la app temporalmente',
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w800),
        ),
        content: const Text(
          'Sofía no podrá usar EduPlay hasta que desactives el bloqueo. '
          '¿Deseas continuar?',
          style: TextStyle(fontFamily: 'Nunito'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar',
                style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Bloquear',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                color: EduPlayColors.softRed,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'App bloqueada para Sofía (simulado — sin persistencia real todavía)',
            style: TextStyle(fontFamily: 'Nunito'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Controles parentales'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/parent/dashboard'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Configura el uso de EduPlay para Sofía',
            style: TextStyle(
              fontSize: 14,
              color: EduPlayColors.textMedium,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ).animate().fadeIn(duration: 250.ms),
          const SizedBox(height: 16),

          _ControlCard(
            icon: Icons.timer_outlined,
            title: 'Límite de lecciones al día',
            subtitle: _dailyLessonLimit == 0
                ? 'Sin límite'
                : '$_dailyLessonLimit ${_dailyLessonLimit == 1 ? "lección" : "lecciones"} por día',
            child: Slider(
              value: _dailyLessonLimit.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              label: _dailyLessonLimit == 0 ? 'Sin límite' : '$_dailyLessonLimit',
              activeColor: EduPlayColors.primaryBlue,
              onChanged: (v) => setState(() => _dailyLessonLimit = v.round()),
            ),
          ).animate(delay: 60.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 14),

          _ControlCard(
            icon: Icons.schedule_rounded,
            title: 'Horario de uso permitido',
            subtitle:
                '${_hourLabel(_allowedHours.start)} – ${_hourLabel(_allowedHours.end)}',
            child: RangeSlider(
              values: _allowedHours,
              min: 0,
              max: 24,
              divisions: 24,
              labels: RangeLabels(
                _hourLabel(_allowedHours.start),
                _hourLabel(_allowedHours.end),
              ),
              activeColor: EduPlayColors.primaryBlue,
              onChanged: (v) => setState(() => _allowedHours = v),
            ),
          ).animate(delay: 120.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 14),

          _ControlCard(
            icon: Icons.emoji_events_outlined,
            title: 'Mostrar en ranking público',
            subtitle: _showInLeaderboard
                ? 'Sofía aparece en el ranking de amigos'
                : 'Sofía NO aparece en rankings públicos',
            child: Align(
              alignment: Alignment.centerLeft,
              child: Switch(
                value: _showInLeaderboard,
                activeThumbColor: EduPlayColors.primaryBlue,
                onChanged: (v) => setState(() => _showInLeaderboard = v),
              ),
            ),
          ).animate(delay: 180.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 14),

          _ControlCard(
            icon: Icons.notifications_outlined,
            title: 'Notificaciones al padre/madre',
            subtitle: _parentNotifications
                ? 'Recibirás alertas de actividad'
                : 'Notificaciones desactivadas',
            child: Align(
              alignment: Alignment.centerLeft,
              child: Switch(
                value: _parentNotifications,
                activeThumbColor: EduPlayColors.primaryBlue,
                onChanged: (v) => setState(() => _parentNotifications = v),
              ),
            ),
          ).animate(delay: 240.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 24),

          OutlinedButton.icon(
            onPressed: _confirmTemporaryBlock,
            icon: const Icon(Icons.lock_clock_rounded),
            label: const Text(
              'Bloquear app temporalmente',
              style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: EduPlayColors.softRed,
              side: const BorderSide(color: EduPlayColors.softRed),
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ).animate(delay: 300.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 12),

          const Text(
            'Estos controles son de la funcionalidad gratuita. Los cambios aún no '
            'se guardan en el servidor — es una vista previa de la interfaz.',
            style: TextStyle(
              fontSize: 11,
              color: EduPlayColors.textMedium,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  const _ControlCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: EduPlayColors.primaryBlue.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: EduPlayColors.primaryBlue, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Nunito',
                    color: EduPlayColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: EduPlayColors.textMedium,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
