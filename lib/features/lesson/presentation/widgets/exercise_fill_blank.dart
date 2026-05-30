// Widget de ejercicio completar el espacio en blanco
// Spec: /specs/domains/learning/spec.md — ExerciseType.fillBlank
// content schema: { "sentence": str, "blank_placeholder": str, "options": [str], "correct_answer": str }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/lesson.dart';
import '../bloc/lesson_bloc.dart';

class ExerciseFillBlank extends StatefulWidget {
  final Exercise exercise;
  const ExerciseFillBlank({super.key, required this.exercise});

  @override
  State<ExerciseFillBlank> createState() => _ExerciseFillBlankState();
}

class _ExerciseFillBlankState extends State<ExerciseFillBlank> {
  String? _selectedAnswer;

  Map<String, dynamic> get _content => widget.exercise.content;
  String get _sentence => _content['sentence'] as String? ?? '';
  List<String> get _options =>
      (_content['options'] as List?)?.cast<String>() ?? [];

  // La oración se divide en partes: antes y después del blank (___)
  List<String> get _sentenceParts => _sentence.split('___');

  void _onSelect(String answer) {
    if (_selectedAnswer != null) return;
    setState(() => _selectedAnswer = answer);
    context.read<LessonBloc>().add(
          ExerciseAnswered(
            exerciseId: widget.exercise.id,
            answer: answer,
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
              color: EduPlayColors.energyYellow.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Completa el espacio',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFB45309),
                fontFamily: 'Nunito',
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Oración con hueco visual
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 8,
              children: [
                if (_sentenceParts.isNotEmpty)
                  Text(
                    _sentenceParts[0],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: EduPlayColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                _BlankSlot(filledWith: _selectedAnswer),
                if (_sentenceParts.length > 1)
                  Text(
                    _sentenceParts[1],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: EduPlayColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          const Text(
            'Elige una palabra:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: EduPlayColors.textMedium,
              fontFamily: 'Nunito',
            ),
          ),

          const SizedBox(height: 16),

          // Opciones como chips
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _options.asMap().entries.map((e) {
              final i = e.key;
              final option = e.value;
              final isSelected = _selectedAnswer == option;
              final isDisabled = _selectedAnswer != null && !isSelected;

              return GestureDetector(
                onTap: isDisabled ? null : () => _onSelect(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? EduPlayColors.energyYellow.withOpacity(0.2)
                        : isDisabled
                            ? EduPlayColors.backgroundLight
                            : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? EduPlayColors.energyYellow
                          : isDisabled
                              ? const Color(0xFFE2E8F0)
                              : const Color(0xFFCBD5E1),
                      width: isSelected ? 2 : 1.5,
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDisabled
                          ? EduPlayColors.textMedium
                          : EduPlayColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              )
                  .animate(delay: Duration(milliseconds: i * 80))
                  .fadeIn(duration: 300.ms)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                  );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _BlankSlot extends StatelessWidget {
  final String? filledWith;
  const _BlankSlot({this.filledWith});

  @override
  Widget build(BuildContext context) {
    final filled = filledWith != null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      constraints: const BoxConstraints(minWidth: 80),
      decoration: BoxDecoration(
        color: filled
            ? EduPlayColors.energyYellow.withOpacity(0.2)
            : EduPlayColors.backgroundLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: filled ? EduPlayColors.energyYellow : const Color(0xFFCBD5E1),
          width: filled ? 2 : 1.5,
        ),
      ),
      child: Center(
        child: Text(
          filled ? filledWith! : '  ____  ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: filled ? EduPlayColors.textDark : EduPlayColors.textMedium,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}
