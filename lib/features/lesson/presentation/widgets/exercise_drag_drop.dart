// Widget de ejercicio arrastrar y soltar
// Spec: /specs/domains/learning/spec.md — ExerciseType.dragDrop
// content schema: { "instruction": str, "items": [str], "targets": [str], "correct_mapping": {item: target} }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/lesson.dart';
import '../bloc/lesson_bloc.dart';

// Fases del ejercicio
enum _Phase { filling, reviewing }

class ExerciseDragDrop extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDragDrop({super.key, required this.exercise});

  @override
  State<ExerciseDragDrop> createState() => _ExerciseDragDropState();
}

class _ExerciseDragDropState extends State<ExerciseDragDrop> {
  // target → item colocado
  final Map<String, String?> _placements = {};
  _Phase _phase = _Phase.filling;

  Map<String, dynamic> get _content => widget.exercise.content;
  String get _instruction => _content['instruction'] as String? ?? '';
  List<String> get _items =>
      (_content['items'] as List?)?.cast<String>() ?? [];
  List<String> get _targets =>
      (_content['targets'] as List?)?.cast<String>() ?? [];

  // correct_mapping: { item → target }
  Map<String, String> get _correctMapping =>
      Map<String, String>.from(_content['correct_mapping'] as Map);

  Set<String> get _placedItems =>
      _placements.values.whereType<String>().toSet();

  List<String> get _availableItems =>
      _items.where((i) => !_placedItems.contains(i)).toList();

  bool get _allPlaced => _availableItems.isEmpty;

  // Devuelve true/false cuando estamos en reviewing, null si aún llenando
  bool? _isTargetCorrect(String target) {
    if (_phase == _Phase.filling) return null;
    final correctItem = _correctItemFor(target);
    return correctItem != null && _placements[target] == correctItem;
  }

  // ¿Qué item debe ir en este target según correct_mapping?
  String? _correctItemFor(String target) {
    for (final e in _correctMapping.entries) {
      if (e.value == target) return e.key;
    }
    return null;
  }

  bool get _allCorrect =>
      _phase == _Phase.reviewing &&
      _targets.every((t) => _isTargetCorrect(t) == true);

  @override
  void initState() {
    super.initState();
    for (final t in _targets) {
      _placements[t] = null;
    }
  }

  void _removeFromTarget(String target) {
    if (_phase != _Phase.filling) return;
    setState(() => _placements[target] = null);
  }

  void _onItemDropped(String target, String item) {
    if (_phase != _Phase.filling) return;
    setState(() => _placements[target] = item);
  }

  void _onConfirm() {
    if (!_allPlaced || _phase != _Phase.filling) return;
    setState(() => _phase = _Phase.reviewing);
  }

  void _onContinue() {
    context.read<LessonBloc>().add(
          ExerciseAnswered(
            exerciseId: widget.exercise.id,
            answer: Map<String, String?>.from(_placements),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Etiqueta tipo
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: EduPlayColors.adventurePurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Arrastra y suelta',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: EduPlayColors.adventurePurple,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  _instruction,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: EduPlayColors.textDark,
                    fontFamily: 'Nunito',
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                // Zona de targets
                Expanded(
                  child: ListView.separated(
                    itemCount: _targets.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final target = _targets[i];
                      final placed = _placements[target];
                      final correctState = _isTargetCorrect(target);

                      return _DropTarget(
                        label: target,
                        placedItem: placed,
                        correctState: correctState,
                        correctItem: _phase == _Phase.reviewing
                            ? _correctItemFor(target)
                            : null,
                        isDisabled: _phase == _Phase.reviewing,
                        onAccept: (item) => _onItemDropped(target, item),
                        onRemove: () => _removeFromTarget(target),
                      )
                          .animate(delay: Duration(milliseconds: i * 80))
                          .fadeIn(duration: 300.ms);
                    },
                  ),
                ),

                // Pool de items disponibles (solo cuando llenando)
                if (_availableItems.isNotEmpty && _phase == _Phase.filling) ...[
                  const SizedBox(height: 14),
                  const Text(
                    'Elementos disponibles:',
                    style: TextStyle(
                      fontSize: 13,
                      color: EduPlayColors.textMedium,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _availableItems.map((item) {
                      return Draggable<String>(
                        data: item,
                        feedback: _DragChip(label: item, isDragging: true),
                        childWhenDragging:
                            _DragChip(label: item, isDragging: false, ghost: true),
                        child: _DragChip(label: item, isDragging: false),
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 16),

                // Botón Confirmar (solo cuando todos colocados y aún llenando)
                if (_allPlaced && _phase == _Phase.filling)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: EduPlayColors.adventurePurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Nunito',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 300.ms)
                      .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
              ],
            ),
          ),
        ),

        // Panel de resultado (aparece tras Confirmar)
        if (_phase == _Phase.reviewing)
          _ResultPanel(
            allCorrect: _allCorrect,
            onContinue: _onContinue,
          ).animate().slideY(begin: 0.3, end: 0, duration: 350.ms).fadeIn(duration: 350.ms),
      ],
    );
  }
}

// ─── Panel de resultado (verde/rojo con botón Continuar) ───────────
class _ResultPanel extends StatelessWidget {
  final bool allCorrect;
  final VoidCallback onContinue;

  const _ResultPanel({required this.allCorrect, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final bg = allCorrect
        ? EduPlayColors.successGreen
        : EduPlayColors.softRed;
    final label = allCorrect ? '¡Correcto!' : '¡Revisa las respuestas!';
    final icon = allCorrect ? Icons.star_rounded : Icons.close_rounded;

    return Container(
      color: bg,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: allCorrect
                    ? EduPlayColors.successGreen
                    : EduPlayColors.softRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Drop Target ──────────────────────────────────────────────────
class _DropTarget extends StatelessWidget {
  final String label;
  final String? placedItem;
  final bool? correctState; // null=not reviewed, true=correct, false=incorrect
  final String? correctItem; // hint when incorrect
  final bool isDisabled;
  final void Function(String) onAccept;
  final VoidCallback onRemove;

  const _DropTarget({
    required this.label,
    required this.placedItem,
    required this.correctState,
    required this.correctItem,
    required this.isDisabled,
    required this.onAccept,
    required this.onRemove,
  });

  Color get _borderColor {
    if (correctState == true) return EduPlayColors.successGreen;
    if (correctState == false) return EduPlayColors.softRed;
    if (placedItem != null) return EduPlayColors.successGreen;
    return const Color(0xFFCBD5E1);
  }

  Color get _bgColor {
    if (correctState == true) return EduPlayColors.successGreen.withOpacity(0.07);
    if (correctState == false) return EduPlayColors.softRed.withOpacity(0.07);
    return EduPlayColors.backgroundLight;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails:
          isDisabled ? null : (details) => onAccept(details.data),
      builder: (_, candidateData, __) {
        final isHovering = candidateData.isNotEmpty;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isHovering
                ? EduPlayColors.adventurePurple.withOpacity(0.06)
                : _bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovering ? EduPlayColors.adventurePurple : _borderColor,
              width: (correctState != null || placedItem != null) ? 2 : 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: EduPlayColors.textDark,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Item colocado (o slot vacío)
              if (placedItem != null)
                _PlacedChip(
                  item: placedItem!,
                  correctState: correctState,
                  correctItem: correctItem,
                  isDisabled: isDisabled,
                  onRemove: onRemove,
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isHovering
                          ? EduPlayColors.adventurePurple
                          : const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    isHovering ? '¡Aquí!' : 'Arrastra',
                    style: TextStyle(
                      fontSize: 13,
                      color: isHovering
                          ? EduPlayColors.adventurePurple
                          : EduPlayColors.textMedium,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Chip colocado (verde/rojo/neutro según correctState) ─────────
class _PlacedChip extends StatelessWidget {
  final String item;
  final bool? correctState;
  final String? correctItem;
  final bool isDisabled;
  final VoidCallback onRemove;

  const _PlacedChip({
    required this.item,
    required this.correctState,
    required this.correctItem,
    required this.isDisabled,
    required this.onRemove,
  });

  Color get _chipBg {
    if (correctState == true) return EduPlayColors.successGreen.withOpacity(0.15);
    if (correctState == false) return EduPlayColors.softRed.withOpacity(0.15);
    return EduPlayColors.successGreen.withOpacity(0.15);
  }

  Color get _chipBorder {
    if (correctState == true) return EduPlayColors.successGreen;
    if (correctState == false) return EduPlayColors.softRed;
    return EduPlayColors.successGreen;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: isDisabled ? null : onRemove,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _chipBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _chipBorder, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícono de estado
                if (correctState == true)
                  const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.check_circle_rounded,
                        size: 16, color: EduPlayColors.successGreen),
                  )
                else if (correctState == false)
                  const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.cancel_rounded,
                        size: 16, color: EduPlayColors.softRed),
                  ),

                Text(
                  item,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito',
                    color: correctState == false
                        ? EduPlayColors.softRed
                        : EduPlayColors.textDark,
                  ),
                ),

                if (!isDisabled) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.close, size: 14, color: EduPlayColors.textMedium),
                ],
              ],
            ),
          ),
        ),

        // Muestra la respuesta correcta debajo si está mal
        if (correctState == false && correctItem != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '→ $correctItem',
              style: const TextStyle(
                fontSize: 11,
                color: EduPlayColors.successGreen,
                fontWeight: FontWeight.w700,
                fontFamily: 'Nunito',
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Drag chip ────────────────────────────────────────────────────
class _DragChip extends StatelessWidget {
  final String label;
  final bool isDragging;
  final bool ghost;

  const _DragChip({
    required this.label,
    required this.isDragging,
    this.ghost = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: ghost
              ? EduPlayColors.backgroundLight
              : isDragging
                  ? EduPlayColors.adventurePurple.withOpacity(0.9)
                  : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ghost
                ? const Color(0xFFE2E8F0)
                : EduPlayColors.adventurePurple,
            width: 1.5,
          ),
          boxShadow: isDragging
              ? [
                  BoxShadow(
                    color: EduPlayColors.adventurePurple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ghost
                ? EduPlayColors.textMedium
                : isDragging
                    ? Colors.white
                    : EduPlayColors.textDark,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}
