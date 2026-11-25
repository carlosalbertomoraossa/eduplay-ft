import 'package:flutter/material.dart';

import '../../g4_adventure_game.dart';

/// Controles táctiles multitouch estilo Hollow Knight / Well Dweller +
/// leyenda compacta de teclado en pantallas anchas.
class ControlsOverlay extends StatelessWidget {
  final G4AdventureGame game;

  const ControlsOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final showKeyHint = screenW >= 720;

    return SafeArea(
      child: Stack(
        children: [
          // ── Leyenda clara de teclado en escritorio / web ──
          if (showKeyHint)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: IgnorePointer(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.88),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.65),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      'A/D Mover  ·  Espacio Saltar (x2)  ·  Z/J Látigo (+S Pogo)  ·  Shift Dash',
                      style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // ── Botones de dirección estilo juguete (abajo izquierda) ──
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _HoldButton(
                    icon: Icons.arrow_back_rounded,
                    size: 56,
                    accent: const Color(0xFF0284C7),
                    onChanged: game.setTouchLeft,
                  ),
                  const SizedBox(width: 10),
                  _HoldButton(
                    icon: Icons.arrow_downward_rounded,
                    label: 'Pogo',
                    size: 46,
                    accent: const Color(0xFF06B6D4),
                    onChanged: game.setTouchDown,
                  ),
                  const SizedBox(width: 10),
                  _HoldButton(
                    icon: Icons.arrow_forward_rounded,
                    size: 56,
                    accent: const Color(0xFF0284C7),
                    onChanged: game.setTouchRight,
                  ),
                ],
              ),
            ),
          ),

          // ── Botones de acción estilo juguete: Dash, Látigo, Salto (abajo derecha) ──
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _TapActionButton(
                    icon: Icons.bolt_rounded,
                    label: 'Dash',
                    size: 52,
                    accent: const Color(0xFF8B5CF6),
                    onDown: game.pressDash,
                  ),
                  const SizedBox(width: 10),
                  _TapActionButton(
                    icon: Icons.gesture_rounded,
                    label: 'Látigo',
                    size: 58,
                    accent: const Color(0xFF10B981),
                    onDown: game.pressAttack,
                  ),
                  const SizedBox(width: 10),
                  _TapActionButton(
                    icon: Icons.arrow_upward_rounded,
                    label: 'Salto',
                    size: 64,
                    accent: const Color(0xFFF59E0B),
                    onDown: game.pressJump,
                    onUp: game.releaseJump,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoldButton extends StatefulWidget {
  final IconData icon;
  final String? label;
  final double size;
  final Color accent;
  final ValueChanged<bool> onChanged;

  const _HoldButton({
    required this.icon,
    this.label,
    required this.size,
    required this.accent,
    required this.onChanged,
  });

  @override
  State<_HoldButton> createState() => _HoldButtonState();
}

class _HoldButtonState extends State<_HoldButton> {
  bool _pressed = false;

  void _set(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.accent.withValues(alpha: _pressed ? 0.96 : 0.78),
          border: Border.all(
            color: Colors.white.withValues(alpha: _pressed ? 1.0 : 0.88),
            width: 2.6,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.accent.withValues(alpha: _pressed ? 0.50 : 0.30),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: Colors.white, size: widget.size * 0.46),
            if (widget.label != null)
              Text(
                widget.label!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nunito',
                  height: 0.9,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TapActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final double size;
  final Color accent;
  final VoidCallback onDown;
  final VoidCallback? onUp;

  const _TapActionButton({
    required this.icon,
    required this.label,
    required this.size,
    required this.accent,
    required this.onDown,
    this.onUp,
  });

  @override
  State<_TapActionButton> createState() => _TapActionButtonState();
}

class _TapActionButtonState extends State<_TapActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) {
        setState(() => _pressed = true);
        widget.onDown();
      },
      onPointerUp: (_) {
        setState(() => _pressed = false);
        widget.onUp?.call();
      },
      onPointerCancel: (_) {
        setState(() => _pressed = false);
        widget.onUp?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.accent.withValues(alpha: _pressed ? 0.98 : 0.84),
          border: Border.all(
            color: Colors.white.withValues(alpha: _pressed ? 1.0 : 0.90),
            width: 2.8,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.accent.withValues(alpha: _pressed ? 0.55 : 0.34),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: Colors.white, size: widget.size * 0.42),
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                fontFamily: 'Nunito',
                height: 0.95,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
