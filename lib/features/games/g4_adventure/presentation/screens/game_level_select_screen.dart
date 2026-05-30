// Spec: specs/games/g4-adventure-plan.md Fase 4 §4.1

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';

// Metadatos de cada nivel: nombre temático y dificultad (1-3 estrellas)
const List<_LevelMeta> _levels = [
  _LevelMeta(1, 'Fracciones\nBásicas', 1, Color(0xFF4CAF50)),
  _LevelMeta(2, 'Fracciones\nEquivalentes', 1, Color(0xFF4CAF50)),
  _LevelMeta(3, 'Multiplicación', 2, Color(0xFF2196F3)),
  _LevelMeta(4, 'División', 2, Color(0xFF2196F3)),
  _LevelMeta(5, 'Decimales\nIntro', 2, Color(0xFF9C27B0)),
  _LevelMeta(6, 'Decimales\nAvanzado', 3, Color(0xFF9C27B0)),
  _LevelMeta(7, 'Repaso\nMixto', 3, Color(0xFFFF5722)),
  _LevelMeta(8, '¡Boss!\nTodo el grado', 3, Color(0xFFE91E63)),
];

class GameLevelSelectScreen extends StatelessWidget {
  const GameLevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
        title: const Text(
          'La Aventura del Cuarto Grado',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: Text(
              'Elige tu nivel',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontFamily: 'Nunito',
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.1,
                ),
                itemCount: _levels.length,
                itemBuilder: (context, index) {
                  return _LevelCard(meta: _levels[index]);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final _LevelMeta meta;

  const _LevelCard({required this.meta});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/games/g4-adventure/play/${meta.level}'),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              meta.color.withValues(alpha: 0.85),
              meta.color.withValues(alpha: 0.55),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: meta.color.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Número de nivel
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${meta.level}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  // Icono especial para boss
                  if (meta.level == 8)
                    const Text('👑', style: TextStyle(fontSize: 20)),
                ],
              ),
              const Spacer(),
              // Nombre del nivel
              Text(
                meta.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  fontFamily: 'Nunito',
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              // Estrellas de dificultad
              Row(
                children: List.generate(3, (i) {
                  return Icon(
                    i < meta.stars ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: i < meta.stars
                        ? EduPlayColors.energyYellow
                        : Colors.white.withValues(alpha: 0.3),
                    size: 16,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelMeta {
  final int level;
  final String name;
  final int stars;
  final Color color;

  const _LevelMeta(this.level, this.name, this.stars, this.color);
}
