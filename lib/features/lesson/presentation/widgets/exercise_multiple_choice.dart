// Widget de ejercicio opción múltiple
// Spec: /specs/domains/learning/spec.md — ExerciseType.multipleChoice
// content schema: { "question": str, "options": [str], "correct_index": int }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/lesson.dart';
import '../bloc/lesson_bloc.dart';

class ExerciseMultipleChoice extends StatefulWidget {
  final Exercise exercise;
  const ExerciseMultipleChoice({super.key, required this.exercise});

  @override
  State<ExerciseMultipleChoice> createState() => _ExerciseMultipleChoiceState();
}

class _ExerciseMultipleChoiceState extends State<ExerciseMultipleChoice> {
  int? _selectedIndex;

  Map<String, dynamic> get _content => widget.exercise.content;
  String get _question => _content['question'] as String? ?? '';
  List<String> get _options =>
      (_content['options'] as List?)?.cast<String>() ?? [];

  void _onSelect(int index) {
    if (_selectedIndex != null) return; // ya respondió
    setState(() => _selectedIndex = index);
    context.read<LessonBloc>().add(
          ExerciseAnswered(
            exerciseId: widget.exercise.id,
            answer: index,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etiqueta de tipo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: EduPlayColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Selecciona la respuesta',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: EduPlayColors.primaryBlue,
                fontFamily: 'Nunito',
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Pregunta
          Text(
            _question,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: EduPlayColors.textDark,
              fontFamily: 'Nunito',
              height: 1.4,
            ),
          ),

          const SizedBox(height: 32),

          // Opciones
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                return _OptionTile(
                  label: _options[i],
                  index: i,
                  isSelected: _selectedIndex == i,
                  isDisabled: _selectedIndex != null && _selectedIndex != i,
                  onTap: () => _onSelect(i),
                )
                    .animate(delay: Duration(milliseconds: i * 80))
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: 0.06, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  static const _letters = ['A', 'B', 'C', 'D'];

  const _OptionTile({
    required this.label,
    required this.index,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isSelected
        ? EduPlayColors.primaryBlue
        : isDisabled
            ? const Color(0xFFE2E8F0)
            : const Color(0xFFCBD5E1);

    final Color bgColor = isSelected
        ? EduPlayColors.primaryBlue.withOpacity(0.08)
        : Colors.white;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1.5),
        ),
        child: Row(
          children: [
            // Letra identificadora
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? EduPlayColors.primaryBlue
                    : isDisabled
                        ? const Color(0xFFE2E8F0)
                        : EduPlayColors.backgroundLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  index < _letters.length ? _letters[index] : '${index + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? Colors.white : EduPlayColors.textMedium,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDisabled
                      ? EduPlayColors.textMedium
                      : EduPlayColors.textDark,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
