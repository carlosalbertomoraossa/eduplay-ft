// Selector de niño con PIN de 4 dígitos
// UX Spec: /specs/product/ux-children.md
// Spec auth: /specs/domains/auth/spec.md — "PIN de 4 dígitos numéricos"

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/auth_entities.dart';
import '../bloc/auth_cubit.dart';

class ChildSelectorScreen extends StatelessWidget {
  const ChildSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listener al nivel raíz — persiste aunque el builder reconstruya
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthChildLoggedIn) context.go('/home');
        if (state is AuthUnauthenticated) context.go('/auth/login');
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthUnauthenticated || state is AuthInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/auth/login');
            });
            return const Scaffold(body: SizedBox.shrink());
          }
          if (state is! AuthParentLoggedIn) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            backgroundColor: EduPlayColors.backgroundLight,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    const Text(
                      '¿Quién va a jugar?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: EduPlayColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: -0.2, end: 0),

                    const SizedBox(height: 32),

                    // Grid de niños
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: state.children.length,
                        itemBuilder: (_, i) {
                          final child = state.children[i];
                          return _ChildCard(
                            child: child,
                            delay: Duration(milliseconds: i * 100),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Acceso al panel parental
                    TextButton.icon(
                      onPressed: () => context.push('/parent/dashboard'),
                      icon: const Icon(Icons.bar_chart_rounded, size: 18),
                      label: const Text('Ver mi panel de padre/madre'),
                      style: TextButton.styleFrom(
                        foregroundColor: EduPlayColors.textMedium,
                        textStyle: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    )
                        .animate(delay: 400.ms)
                        .fadeIn(duration: 350.ms),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChildCard extends StatelessWidget {
  final ChildProfile child;
  final Duration delay;

  const _ChildCard({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPinDialog(context, child),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: EduPlayColors.primaryBlue.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: EduPlayColors.backgroundLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(child.genderEmoji, style: const TextStyle(fontSize: 48)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              child.displayName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: EduPlayColors.textDark,
                fontFamily: 'Nunito',
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: (child.isGirl
                        ? const Color(0xFFEC4899)
                        : const Color(0xFF3B82F6))
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                child.genderLabel,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: child.isGirl
                      ? const Color(0xFFEC4899)
                      : const Color(0xFF3B82F6),
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ],
        ),
      )
          .animate(delay: delay)
          .fadeIn(duration: 400.ms)
          .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
    );
  }

  void _showPinDialog(BuildContext context, ChildProfile child) {
    final cubit = context.read<AuthCubit>();
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: _PinDialog(child: child),
      ),
    );
  }
}

class _PinDialog extends StatefulWidget {
  final ChildProfile child;
  const _PinDialog({required this.child});

  @override
  State<_PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<_PinDialog> {
  final _pinCtrl = TextEditingController();
  String _pin = '';
  bool _hasError = false;

  void _onDigit(String digit) {
    if (_pin.length >= 4) return;
    setState(() {
      _pin += digit;
      _hasError = false;
    });
    if (_pin.length == 4) _submit();
  }

  void _onDelete() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  void _submit() {
    context.read<AuthCubit>().loginChild(
          child: widget.child,
          pin: _pin,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          setState(() {
            _pin = '';
            _hasError = true;
          });
        } else if (state is AuthChildLoggedIn) {
          Navigator.of(context).pop();
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¡Hola, ${widget.child.displayName}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: EduPlayColors.textDark,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ingresa tu PIN de 4 dígitos',
                style: TextStyle(
                  fontSize: 16,
                  color: EduPlayColors.textMedium,
                  fontFamily: 'Nunito',
                ),
              ),

              const SizedBox(height: 24),

              // Indicadores de PIN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final filled = i < _pin.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hasError
                          ? EduPlayColors.softRed
                          : filled
                              ? EduPlayColors.primaryBlue
                              : EduPlayColors.backgroundLight,
                      border: Border.all(
                        color: _hasError
                            ? EduPlayColors.softRed
                            : filled
                                ? EduPlayColors.primaryBlue
                                : const Color(0xFFCBD5E1),
                        width: 2,
                      ),
                    ),
                  );
                }),
              ),

              if (_hasError) ...[
                const SizedBox(height: 8),
                const Text(
                  '¡PIN incorrecto! Intenta de nuevo',
                  style: TextStyle(
                    color: EduPlayColors.softRed,
                    fontSize: 14,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Teclado numérico
              _NumericKeypad(onDigit: _onDigit, onDelete: _onDelete),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: EduPlayColors.textMedium,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }
}

class _NumericKeypad extends StatelessWidget {
  final void Function(String) onDigit;
  final VoidCallback onDelete;

  const _NumericKeypad({required this.onDigit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
          ['', '0', '⌫'],
        ])
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              if (key.isEmpty) return const SizedBox(width: 72, height: 56);
              return GestureDetector(
                onTap: () {
                  if (key == '⌫') {
                    onDelete();
                  } else {
                    onDigit(key);
                  }
                },
                child: Container(
                  width: 72,
                  height: 56,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: EduPlayColors.backgroundLight,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      key,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
