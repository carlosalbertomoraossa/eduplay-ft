// Spec: specs/games/g4-adventure-plan.md Fase 4 §4.4

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/game_question.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

/// Overlay Flutter para mostrar la pregunta activa y recibir la respuesta.
/// Reemplaza los componentes Flame de burbuja + bloques de respuesta.
class QuestionOverlay extends StatelessWidget {
  final GameBloc gameBloc;
  const QuestionOverlay({super.key, required this.gameBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      bloc: gameBloc,
      buildWhen: (prev, curr) {
        if (curr is! GameInProgress) return false;
        if (prev is! GameInProgress) return true;
        return prev.waitingForAnswer != curr.waitingForAnswer ||
            prev.activeQuestion != curr.activeQuestion;
      },
      builder: (context, state) {
        if (state is! GameInProgress ||
            !state.waitingForAnswer ||
            state.activeQuestion == null) {
          return const SizedBox.shrink();
        }
        return _QuestionCard(
          question: state.activeQuestion!,
          gameBloc: gameBloc,
        );
      },
    );
  }
}

class _QuestionCard extends StatefulWidget {
  final GameQuestion question;
  final GameBloc gameBloc;
  const _QuestionCard({required this.question, required this.gameBloc});

  @override
  State<_QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<_QuestionCard>
    with SingleTickerProviderStateMixin {
  int? _selected;
  bool _submitted = false;

  late final AnimationController _slideCtrl;
  late final Animation<Offset> _slideAnim;

  static const _optionColors = [
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFE65100),
  ];

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _slideCtrl.forward();
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // bloquear taps en el fondo
      child: Container(
        color: Colors.black.withValues(alpha: 0.52),
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: _slideAnim,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 28),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 28,
                  offset: Offset(0, -6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicador visual
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A237E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '¿Sabes la respuesta?',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                // Pregunta
                Text(
                  widget.question.question,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A237E),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Opciones
                ...List.generate(widget.question.options.length, (i) {
                  return _OptionButton(
                    text: widget.question.options[i],
                    baseColor: _optionColors[i % _optionColors.length],
                    selected: _selected == i,
                    submitted: _submitted,
                    isCorrect: i == widget.question.correctIndex,
                    onTap: _submitted ? null : () => _onTap(i),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (_submitted) return;
    setState(() {
      _selected = index;
      _submitted = true;
    });
    // Mostrar feedback brevemente antes de enviar al bloc
    Future.delayed(const Duration(milliseconds: 750), () {
      if (mounted) widget.gameBloc.add(AnswerBlockHit(index));
    });
  }
}

class _OptionButton extends StatelessWidget {
  final String text;
  final Color baseColor;
  final bool selected;
  final bool submitted;
  final bool isCorrect;
  final VoidCallback? onTap;

  const _OptionButton({
    required this.text,
    required this.baseColor,
    required this.selected,
    required this.submitted,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = baseColor;
    if (submitted && selected) {
      bgColor =
          isCorrect ? const Color(0xFF1B5E20) : const Color(0xFFB71C1C);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? Colors.white : Colors.transparent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: bgColor.withValues(alpha: 0.45),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              if (submitted && selected)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
