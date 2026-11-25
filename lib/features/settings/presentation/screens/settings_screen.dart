// Configuración del niño — sonido, ayuda y salir
// Ruta: /settings (child route). Los controles parentales reales viven en
// ParentSettingsScreen (/parent/settings) — ver decisión en SPEC_BACKLOG.md F5.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/colombia_calendar_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../../shared/widgets/ep_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Estado local — UI-only, sin persistencia todavía.
  double _soundVolume = 0.8;
  bool _musicEnabled = true;

  Future<void> _confirmExit() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '¿Salir de EduPlay?',
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w800),
        ),
        content: const Text(
          'Vas a cerrar tu sesión. ¡Vuelve pronto para seguir tu racha!',
          style: TextStyle(fontFamily: 'Nunito'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(EduPlayStrings.cancel,
                style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              EduPlayStrings.exit,
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

    if (confirmed != true || !mounted) return;

    await context.read<AuthCubit>().logout();
    if (mounted) context.go('/onboarding');
  }

  ProviderContainer? _maybeContainer(BuildContext context) {
    try {
      return ProviderScope.containerOf(context, listen: false);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = _maybeContainer(context);
    final calendarState = container?.read(colombiaCalendarProvider);
    return Scaffold(
      backgroundColor: EduPlayColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Configuración'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionCard(
            title: 'Sonido',
            icon: Icons.volume_up_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.music_note_rounded,
                        color: EduPlayColors.textMedium, size: 20),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Música de fondo',
                        style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
                      ),
                    ),
                    Switch(
                      value: _musicEnabled,
                      activeThumbColor: EduPlayColors.primaryBlue,
                      onChanged: (v) => setState(() => _musicEnabled = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.graphic_eq_rounded,
                        color: EduPlayColors.textMedium, size: 20),
                    const SizedBox(width: 10),
                    const Text(
                      'Volumen de efectos',
                      style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Text(
                      '${(_soundVolume * 100).round()}%',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        color: EduPlayColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: _soundVolume,
                  activeColor: EduPlayColors.primaryBlue,
                  onChanged: (v) => setState(() => _soundVolume = v),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms),

          const SizedBox(height: 16),

          if (container != null && calendarState != null) ...[
            _SectionCard(
              title: 'Calendario Escolar Colombia 🇨🇴',
              icon: Icons.calendar_month_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Período activo: ${calendarState.summaryLabel()}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: EduPlayColors.textMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Text(
                            'Calendario A (Ene–Nov)',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          selected: calendarState.calendarType ==
                              SchoolCalendarType.calendarA,
                          onSelected: (_) {
                            container
                                .read(colombiaCalendarProvider.notifier)
                                .setCalendarType(SchoolCalendarType.calendarA);
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChoiceChip(
                          label: const Text(
                            'Calendario B (Sep–Jun)',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          selected: calendarState.calendarType ==
                              SchoolCalendarType.calendarB,
                          onSelected: (_) {
                            container
                                .read(colombiaCalendarProvider.notifier)
                                .setCalendarType(SchoolCalendarType.calendarB);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate(delay: 60.ms).fadeIn(duration: 300.ms),
            const SizedBox(height: 16),
          ],

          _SectionCard(
            title: 'Ayuda',
            icon: Icons.help_outline_rounded,
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Text('💬', style: TextStyle(fontSize: 22)),
                title: const Text(
                  '¿Necesitas ayuda?',
                  style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Pídele a un adulto que te acompañe',
                  style: TextStyle(fontFamily: 'Nunito', fontSize: 12),
                ),
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text('¿Necesitas ayuda?',
                          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w800)),
                      content: const Text(
                        'Pídele a tu papá, mamá o un adulto responsable que te ayude. '
                        'También puede revisar el Panel Familiar para ver tus controles.',
                        style: TextStyle(fontFamily: 'Nunito'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          child: const Text(EduPlayStrings.ok,
                              style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ).animate(delay: 80.ms).fadeIn(duration: 300.ms),

          const SizedBox(height: 32),

          EpButton(
            label: EduPlayStrings.exit,
            variant: EpButtonVariant.danger,
            icon: Icons.logout_rounded,
            onPressed: _confirmExit,
          ).animate(delay: 150.ms).fadeIn(duration: 300.ms),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                  color: EduPlayColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
