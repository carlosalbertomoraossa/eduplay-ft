import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/lumi_lion_mascot.dart';
import '../../../../shared/widgets/playful_world_background.dart';
import '../../../lesson/data/curriculum_data.dart';
import '../../../lesson/domain/entities/lesson.dart';
import '../../../lesson/presentation/widgets/exercise_visual_aid.dart';

/// Zona de Preparación Interactiva para cada unidad y período (Grados 1° a 5°).
/// Incluye:
/// 1. Muñeco/personaje animado por grado con consejos hablados interactivos.
/// 2. Explicación visual e ilustrada de cada temario de la unidad (adaptada a la edad).
/// 3. Tablitas mágicas interactivas para tocar y descubrir equivalencias/fórmulas.
/// 4. Mesa Interactiva Manipulable ("¡Mueve, arrastra y acomoda!") con soporte de
///    arrastre libre de piezas y exploración del lienzo.
class UnitPrepZone extends StatefulWidget {
  final String unitId;
  final VoidCallback onStartExercises;
  final int initialLessonIdx;

  const UnitPrepZone({
    super.key,
    required this.unitId,
    required this.onStartExercises,
    this.initialLessonIdx = 0,
  });

  @override
  State<UnitPrepZone> createState() => _UnitPrepZoneState();
}

class _UnitPrepZoneState extends State<UnitPrepZone> {
  late int _selectedLessonIdx;
  int _selectedTableRow = 0;
  int _mascotSpeechIdx = 0;
  bool _panZoomCanvasMode = false;

  // Piezas móviles para la Mesa Interactiva ("Arrastra y acomoda")
  late List<_DraggableBoardItem> _boardItems;
  final TransformationController _canvasController = TransformationController();

  int get _grade {
    if (widget.unitId.startsWith('unit-00')) return 1;
    if (widget.unitId.startsWith('unit-20')) return 2;
    if (widget.unitId.startsWith('unit-30')) return 3;
    if (widget.unitId.startsWith('unit-40')) return 4;
    if (widget.unitId.startsWith('unit-50')) return 5;
    return 4;
  }

  @override
  void initState() {
    super.initState();
    _selectedLessonIdx = widget.initialLessonIdx;
    _resetBoardItems();
  }

  @override
  void didUpdateWidget(covariant UnitPrepZone oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.unitId != widget.unitId ||
        oldWidget.initialLessonIdx != widget.initialLessonIdx) {
      _selectedLessonIdx = widget.initialLessonIdx;
      _selectedTableRow = 0;
      _mascotSpeechIdx = 0;
      _resetBoardItems();
    }
  }

  @override
  void dispose() {
    _canvasController.dispose();
    super.dispose();
  }

  _UnitPrepSpec get _spec => _buildUnitSpec(widget.unitId, _grade);

  void _resetBoardItems({bool ordered = false}) {
    final spec = _spec;
    final presets = spec.boardPresets;
    _boardItems = List.generate(presets.length, (i) {
      final p = presets[i];
      if (ordered) {
        // Acomodados dentro de la zona activa (mitad derecha del tablero)
        final col = i % 3;
        final row = i ~/ 3;
        return _DraggableBoardItem(
          id: 'item-$i',
          emoji: p.emoji,
          label: p.label,
          numericValue: p.numericValue,
          color: p.color,
          position: Offset(175.0 + col * 56.0, 44.0 + row * 58.0),
        );
      } else {
        // En la bandeja izquierda listos para arrastrar y acomodar
        final col = i % 2;
        final row = i ~/ 2;
        return _DraggableBoardItem(
          id: 'item-$i',
          emoji: p.emoji,
          label: p.label,
          numericValue: p.numericValue,
          color: p.color,
          position: Offset(14.0 + col * 62.0, 42.0 + row * 54.0),
        );
      }
    });
  }

  void _addExtraBoardItem() {
    if (_boardItems.length >= 10) return;
    final presets = _spec.boardPresets;
    final template = presets[_boardItems.length % presets.length];
    setState(() {
      _boardItems.add(
        _DraggableBoardItem(
          id: 'item-${DateTime.now().microsecondsSinceEpoch}',
          emoji: template.emoji,
          label: template.label,
          numericValue: template.numericValue,
          color: template.color,
          position: const Offset(210, 80),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final spec = _spec;
    final lessons = CurriculumData.getLessonsForUnit(widget.unitId);
    final period = CurriculumData.getUnitPeriod(widget.unitId);
    final activeLessonIdx = lessons.isEmpty
        ? 0
        : _selectedLessonIdx.clamp(0, lessons.length - 1);
    final activeLesson =
        lessons.isNotEmpty ? lessons[activeLessonIdx] : null;
    final fullLesson =
        activeLesson != null ? CurriculumData.getLesson(activeLesson.id) : null;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: PlayfulWorldBackground(
        theme: PlayfulWorldBackground.fromPeriod(period),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            // ── 1. Tarjeta del Muñeco Guía Animado (acorde al curso) ──────
            _MascotGuideBanner(
              grade: _grade,
              period: period,
              mascotName: spec.mascotName,
              mascotRole: spec.mascotRole,
              speeches: spec.mascotSpeeches,
              speechIdx: _mascotSpeechIdx,
              accentColor: spec.accentColor,
              onTapMascot: () {
                setState(() {
                  _mascotSpeechIdx =
                      (_mascotSpeechIdx + 1) % spec.mascotSpeeches.length;
                });
              },
            ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0),

            const SizedBox(height: 18),

            // ── 2. Selector de Temario de la Unidad (Lección por Lección) ─
            const _SectionHeader(
              icon: '📚',
              title: 'Temario de la Unidad (Toca cada tema)',
              subtitle:
                  'Explora la explicación antes de pasar a los ejercicios',
              color: Color(0xFF1E3A8A),
            ),
            const SizedBox(height: 10),

            if (lessons.isNotEmpty) ...[
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: lessons.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final isSel = i == activeLessonIdx;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedLessonIdx = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSel ? spec.accentColor : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: spec.accentColor,
                            width: isSel ? 2 : 1.2,
                          ),
                          boxShadow: isSel
                              ? [
                                  BoxShadow(
                                    color:
                                        spec.accentColor.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              i == lessons.length - 1 ? '🏆' : '📖',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Tema ${i + 1}: ${lessons[i].title}',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isSel
                                    ? Colors.white
                                    : const Color(0xFF1E3A8A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Estudio Súper Interactivo adaptado al niño para el tema seleccionado
              _TopicExplanationCard(
                unitId: widget.unitId,
                grade: _grade,
                topicOrder: activeLessonIdx + 1,
                topicTitle: activeLesson!.title,
                unitSpec: spec,
                fullLesson: fullLesson,
              ),
            ],

            const SizedBox(height: 20),

            // ── 3. Mesa Interactiva Manipulable ("¡Mueve, arrastra y acomoda!") ──
            const _SectionHeader(
              icon: '🖐️',
              title: 'Mesa Interactiva: ¡Arrastra y acomoda!',
              subtitle:
                  'Mueve las figuras con tu dedo o mouse hacia la Zona Mágica',
              color: Color(0xFF6D28D9),
            ),
            const SizedBox(height: 10),
            _buildManipulativeSandbox(spec),

            const SizedBox(height: 20),

            // ── 4. Tablita Mágica Interactiva de Consulta ─────────────────
            _SectionHeader(
              icon: '📊',
              title: spec.tableTitle,
              subtitle: 'Toca cada fila de la tablita para ver el ejemplo vivo',
              color: const Color(0xFF047857),
            ),
            const SizedBox(height: 10),
            _buildInteractiveReferenceTable(spec),

            const SizedBox(height: 24),

            // ── 5. Botón Grande para pasar a la Zona de Ejercicios ────────
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: widget.onStartExercises,
                style: ElevatedButton.styleFrom(
                  backgroundColor: EduPlayColors.successGreen,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Text('🎯', style: TextStyle(fontSize: 22)),
                label: const Text(
                  '¡Ya estoy listo! Ir a la Zona de Ejercicios',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  // ── Construye el Lienzo / Mesa Interactiva donde el niño mueve y acomoda cosas ──
  Widget _buildManipulativeSandbox(_UnitPrepSpec spec) {
    // Calculamos cuáles piezas están dentro de la "Zona Mágica" (x >= 145)
    final placedItems =
        _boardItems.where((item) => item.position.dx >= 145).toList();
    final totalPlacedValue = placedItems.fold<int>(
      0,
      (sum, item) => sum + item.numericValue,
    );

    final boardContent = SizedBox(
      width: 360,
      height: 215,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Fondo dividido en 2 zonas: "Bandeja de piezas" (izq) y "Zona Mágica" (der)
          Positioned.fill(
            child: CustomPaint(
              painter: _SandboxBackgroundPainter(
                accentColor: spec.accentColor,
              ),
            ),
          ),

          // Etiquetas de las dos zonas del tablero
          Positioned(
            left: 12,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '📦 Bandeja de piezas',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF475569),
                ),
              ),
            ),
          ),
          Positioned(
            left: 162,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: spec.accentColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '✨ ${spec.sandboxTargetLabel}',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Piezas arrastrables libremente
          for (int i = 0; i < _boardItems.length; i++)
            Positioned(
              left: _boardItems[i].position.dx,
              top: _boardItems[i].position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    final current = _boardItems[i].position;
                    final nextX =
                        (current.dx + details.delta.dx).clamp(6.0, 302.0);
                    final nextY =
                        (current.dy + details.delta.dy).clamp(32.0, 162.0);
                    _boardItems[i] = _boardItems[i].copyWith(
                      position: Offset(nextX, nextY),
                    );
                  });
                },
                onTap: () {
                  // Si el niño toca una pieza, la salta automáticamente a la otra zona
                  setState(() {
                    final item = _boardItems[i];
                    final inZone = item.position.dx >= 145;
                    _boardItems[i] = item.copyWith(
                      position: inZone
                          ? Offset(20.0 + (i % 2) * 58.0, 44.0 + (i ~/ 2) * 50.0)
                          : Offset(175.0 + (i % 3) * 54.0, 48.0 + (i ~/ 3) * 54.0),
                    );
                  });
                },
                child: _DraggablePieceWidget(
                  item: _boardItems[i],
                  isInsideTarget: _boardItems[i].position.dx >= 145,
                ),
              ),
            ),
        ],
      ),
    );

    return Playful3DCard(
      padding: const EdgeInsets.all(14),
      borderColor: const Color(0xFF8B5CF6),
      child: Column(
        children: [
          // Barra de herramientas del tablero interactivo
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _SandboxActionChip(
                icon: '✨',
                label: 'Acomodar todo',
                color: const Color(0xFF7C3AED),
                onTap: () => setState(() => _resetBoardItems(ordered: true)),
              ),
              _SandboxActionChip(
                icon: '🎲',
                label: 'Desordenar',
                color: const Color(0xFF2563EB),
                onTap: () => setState(() => _resetBoardItems(ordered: false)),
              ),
              _SandboxActionChip(
                icon: '➕',
                label: 'Más piezas',
                color: const Color(0xFF059669),
                onTap: _addExtraBoardItem,
              ),
              _SandboxActionChip(
                icon: _panZoomCanvasMode ? '🔒' : '🔍',
                label: _panZoomCanvasMode
                    ? 'Fijar pantalla'
                    : 'Mover/Zoom lienzo',
                color: const Color(0xFFD97706),
                active: _panZoomCanvasMode,
                onTap: () {
                  setState(() {
                    _panZoomCanvasMode = !_panZoomCanvasMode;
                    if (!_panZoomCanvasMode) {
                      _canvasController.value = Matrix4.identity();
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Lienzo interactivo (soporta arrastrar piezas y modo Zoom/Pan de pantalla)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              height: 215,
              color: const Color(0xFFF8FAFC),
              alignment: Alignment.center,
              child: _panZoomCanvasMode
                  ? InteractiveViewer(
                      transformationController: _canvasController,
                      panEnabled: true,
                      scaleEnabled: true,
                      minScale: 0.85,
                      maxScale: 2.2,
                      boundaryMargin: const EdgeInsets.all(60),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: boardContent,
                      ),
                    )
                  : FittedBox(
                      fit: BoxFit.contain,
                      child: boardContent,
                    ),
            ),
          ),
          const SizedBox(height: 10),

          // Contador en vivo de lo que el niño ha acomodado en la Zona Mágica
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: placedItems.isEmpty
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: placedItems.isEmpty
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF10B981),
              ),
            ),
            child: Row(
              children: [
                Text(
                  placedItems.isEmpty ? '👆' : '🎉',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    placedItems.isEmpty
                        ? 'Arrastra o toca las piezas de la izquierda para acomodarlas en la Zona Mágica.'
                        : '¡Acomodaste ${placedItems.length} ${placedItems.length == 1 ? "pieza" : "piezas"}! '
                            '${spec.sandboxSummaryBuilder(placedItems.length, totalPlacedValue)}',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: placedItems.isEmpty
                          ? const Color(0xFF475569)
                          : const Color(0xFF065F46),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Construye la Tablita Mágica Interactiva de la unidad ──────────────────
  Widget _buildInteractiveReferenceTable(_UnitPrepSpec spec) {
    final rows = spec.tableRows;
    final selRow = _selectedTableRow.clamp(0, rows.length - 1);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Encabezado de la tablita
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF10B981)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                const Text('📋', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    spec.tableColumnsHeader.$1,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    spec.tableColumnsHeader.$2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    spec.tableColumnsHeader.$3,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filas interactivas
          ...List.generate(rows.length, (i) {
            final r = rows[i];
            final isSel = i == selRow;
            return GestureDetector(
              onTap: () => setState(() => _selectedTableRow = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSel
                      ? const Color(0xFFECFDF5)
                      : (i.isEven ? Colors.white : const Color(0xFFF8FAFC)),
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFFE2E8F0),
                      width: i == rows.length - 1 ? 0 : 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(r.emoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        r.col1,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: isSel
                              ? const Color(0xFF065F46)
                              : EduPlayColors.textDark,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isSel
                              ? const Color(0xFF10B981)
                              : const Color(0xFFE2E8F0).withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          r.col2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w900,
                            color: isSel
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        r.col3,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSel
                              ? const Color(0xFF047857)
                              : EduPlayColors.textMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Explicación infantil de la fila seleccionada
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFF0FDF4),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Text(
                  rows[selRow].emoji,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '🔍 ${rows[selRow].kidExplanation}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF065F46),
                    ),
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

// ─── Banner con Muñeco Animado en Canvas y Globo de Diálogo ──────────────────

class _MascotGuideBanner extends StatelessWidget {
  final int grade;
  final int period;
  final String mascotName;
  final String mascotRole;
  final List<String> speeches;
  final int speechIdx;
  final Color accentColor;
  final VoidCallback onTapMascot;

  const _MascotGuideBanner({
    required this.grade,
    required this.period,
    required this.mascotName,
    required this.mascotRole,
    required this.speeches,
    required this.speechIdx,
    required this.accentColor,
    required this.onTapMascot,
  });

  @override
  Widget build(BuildContext context) {
    final currentSpeech = speeches[speechIdx % speeches.length];

    return Playful3DCard(
      padding: const EdgeInsets.all(16),
      borderColor: accentColor,
      gradient: LinearGradient(
        colors: [
          accentColor.withValues(alpha: 0.14),
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Muñeco dibujado en Canvas y animado continuamente
          GestureDetector(
            onTap: onTapMascot,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LumiLionMascot(
                  size: 86,
                  grade: grade,
                  accentColor: accentColor,
                  expressionVariant: speechIdx % 4,
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: -3,
                      end: 4,
                      duration: 1100.ms,
                      curve: Curves.easeInOut,
                    ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '👆 ¡Tócame!',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Globo de diálogo del personaje
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      mascotName,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: accentColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Grado $grade° · Período $period',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  mascotRole,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: EduPlayColors.textMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    '«$currentSpeech»',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: EduPlayColors.textDark,
                      height: 1.32,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onTapMascot,
                    child: Text(
                      '💬 Consejo ${(speechIdx % speeches.length) + 1}/${speeches.length} · Ver otro →',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: accentColor,
                      ),
                    ),
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

// ─── Estudio Súper Interactivo del Tema Seleccionado ─────────────────────────

class _TopicExplanationCard extends StatefulWidget {
  final String unitId;
  final int grade;
  final int topicOrder;
  final String topicTitle;
  final _UnitPrepSpec unitSpec;
  final Lesson? fullLesson;

  const _TopicExplanationCard({
    required this.unitId,
    required this.grade,
    required this.topicOrder,
    required this.topicTitle,
    required this.unitSpec,
    this.fullLesson,
  });

  @override
  State<_TopicExplanationCard> createState() => _TopicExplanationCardState();
}

class _TopicExplanationCardState extends State<_TopicExplanationCard> {
  // Paso activo de la historieta interactiva (0 = Idea Clave, 1 = Ejemplo Vivo, 2 = Secreto Mágico)
  int _activeComicStep = 0;

  // Fase interactiva del lienzo gráfico de la explicación (0, 1 o 2)
  int _storyScenePhase = 0;

  // Modo activo de Juego en la Explicación (0 = Completar, 1 = Armar, 2 = Buscar)
  int _activePlayMode = 0;

  // 1. Estado del juego "🧩 Completar la explicación"
  final Map<int, String> _filledStorySlots = {};
  int _activeSlotIdx = 0;

  // 2. Estado del juego "🏗️ Armar el concepto en el lienzo"
  final List<int> _builtPieces = [];

  // 3. Estado del juego "🔍 Buscar con lupa de detective"
  final Set<int> _inspectedTileIndices = {};

  // Índice del ejemplo dinámico del tema
  int _exampleVariantIdx = 0;

  // Controles de la Máquina Matemática en Vivo (valores A y B + operación)
  int _liveValA = 4;
  int _liveValB = 3;
  int _liveOpIdx = 0; // 0: +, 1: -, 2: ×, 3: ÷

  // Estado de las Tarjetas Mágicas Giratorias (índices volteados)
  final Set<int> _flippedCardIndices = {};

  // Estado del Mini-Reto de Entrenamiento en Vivo (sin perder vidas)
  int _practiceExIdx = 0;
  String? _selectedPracticeOption;
  bool? _isPracticeCorrect;
  final Set<int> _solvedExerciseIndices = {};

  @override
  void initState() {
    super.initState();
    _initDefaultsForTopic();
  }

  @override
  void didUpdateWidget(covariant _TopicExplanationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.unitId != widget.unitId ||
        oldWidget.topicOrder != widget.topicOrder ||
        oldWidget.topicTitle != widget.topicTitle) {
      _activeComicStep = 0;
      _storyScenePhase = 0;
      _filledStorySlots.clear();
      _activeSlotIdx = 0;
      _builtPieces.clear();
      _inspectedTileIndices.clear();
      _exampleVariantIdx = 0;
      _flippedCardIndices.clear();
      _practiceExIdx = 0;
      _selectedPracticeOption = null;
      _isPracticeCorrect = null;
      _solvedExerciseIndices.clear();
      _initDefaultsForTopic();
    }
  }

  String get _topicFamily {
    final lower =
        '${CurriculumData.unitTitles[widget.unitId] ?? ''} ${widget.topicTitle}'
            .toLowerCase();
    if (lower.contains('fracci') ||
        lower.contains('decimal') ||
        lower.contains('porcentaje') ||
        lower.contains('razón') ||
        lower.contains('razones') ||
        lower.contains('proporci') ||
        lower.contains('mcm')) {
      return 'fractions';
    }
    if (lower.contains('ubicación') ||
        lower.contains('medición') ||
        lower.contains('figuras') ||
        lower.contains('tiempo') ||
        lower.contains('reloj') ||
        lower.contains('regla') ||
        lower.contains('cuerpos') ||
        lower.contains('perímetro') ||
        lower.contains('área') ||
        lower.contains('mapas') ||
        lower.contains('volumen') ||
        lower.contains('circunferencia') ||
        lower.contains('ángulo') ||
        lower.contains('radio') ||
        lower.contains('diámetro')) {
      return 'geometry';
    }
    if (lower.contains('álgebra') ||
        lower.contains('ecuaci') ||
        lower.contains('variable') ||
        widget.unitId == 'unit-508') {
      return 'algebra';
    }
    if (lower.contains('pictograma') ||
        lower.contains('barra') ||
        lower.contains('frecuencia') ||
        lower.contains('estadística') ||
        lower.contains('moda') ||
        lower.contains('mediana') ||
        lower.contains('promedio') ||
        lower.contains('probabilidad') ||
        lower.contains('seguro') ||
        lower.contains('moneda')) {
      return 'stats';
    }
    if (lower.contains('suma') ||
        lower.contains('resta') ||
        lower.contains('tabla') ||
        lower.contains('multiplic') ||
        lower.contains('divisi') ||
        lower.contains('reparto') ||
        lower.contains('operaciones') ||
        lower.contains('problemas')) {
      return 'operations';
    }
    return 'numbers';
  }

  void _initDefaultsForTopic() {
    final fam = _topicFamily;
    final tOrder = widget.topicOrder;
    if (fam == 'fractions') {
      _liveValA = (tOrder % 3) + 1; // Numerador (1..3)
      _liveValB = math.max(_liveValA + 1, (tOrder % 4) + 3); // Denominador (4..6)
    } else if (fam == 'geometry') {
      _liveValA = 3 + (tOrder % 4); // Base / Largo / Radio
      _liveValB = 2 + (tOrder % 3); // Altura / Ancho
    } else if (fam == 'algebra') {
      _liveValA = 3 + tOrder; // Valor secreto de x
      _liveValB = 2 + (tOrder % 4); // Valor que acompaña a x
    } else if (fam == 'stats') {
      _liveValA = 4 + (tOrder % 4); // Votos opción A
      _liveValB = 2 + (tOrder % 3); // Votos opción B
    } else if (fam == 'operations') {
      final isMult = widget.topicTitle.toLowerCase().contains('multiplic') ||
          widget.topicTitle.toLowerCase().contains('tabla') ||
          widget.topicTitle.toLowerCase().contains('divisi') ||
          widget.topicTitle.toLowerCase().contains('reparto');
      _liveOpIdx = isMult ? 2 : 0;
      _liveValA = isMult ? (2 + tOrder) : (5 + tOrder * 2);
      _liveValB = isMult ? 3 : (3 + tOrder);
    } else {
      // numbers / valor posicional
      if (widget.unitId == 'unit-501') {
        _liveValA = -4 + tOrder; // Posición inicial en recta entera
        _liveValB = 3 + (tOrder % 3); // Salto
      } else {
        _liveValA = (tOrder + 1) * (widget.grade <= 2 ? 12 : 124);
        _liveValB = widget.grade <= 2 ? 10 : 100;
      }
    }
  }

  // Extrae preguntas, respuestas y pistas reales de los ejercicios de la lección
  List<({String question, String answer, String explanation, String emoji})>
      _extractLessonCards(_LessonPrepExplanation baseExp) {
    final exercises = widget.fullLesson?.exercises ?? const <Exercise>[];
    final emojis = ['🔮', '🚀', '💎', '🌟', '🧩'];
    final results =
        <({String question, String answer, String explanation, String emoji})>[];

    for (int i = 0; i < exercises.length; i++) {
      final ex = exercises[i];
      final c = ex.content;
      String q = '';
      String ans = '';
      if (ex.type == ExerciseType.multipleChoice) {
        q = (c['question'] as String?) ?? '';
        final opts = (c['options'] as List?)?.cast<String>() ?? const [];
        final idx = (c['correct_index'] as int?) ?? 0;
        if (idx >= 0 && idx < opts.length) {
          ans = opts[idx];
        }
      } else if (ex.type == ExerciseType.fillBlank) {
        q = (c['sentence'] as String?) ?? '';
        ans = (c['correct_answer'] as String?) ?? '';
      } else if (ex.type == ExerciseType.dragDrop) {
        q = (c['instruction'] as String?) ?? 'Relaciona cada pareja';
        final mapping = c['correct_mapping'] as Map?;
        if (mapping != null && mapping.isNotEmpty) {
          ans = mapping.entries
              .take(3)
              .map((e) => '${e.key} → ${e.value}')
              .join(' · ');
        }
      }
      if (q.isNotEmpty && ans.isNotEmpty) {
        results.add((
          question: q,
          answer: ans,
          explanation: (ex.hint != null && ex.hint!.trim().isNotEmpty)
              ? ex.hint!
              : baseExp.secretTrick,
          emoji: emojis[i % emojis.length],
        ));
      }
    }

    if (results.isEmpty) {
      results.add((
        question: baseExp.visualPrompt,
        answer: '¡Paso completado!',
        explanation: baseExp.secretTrick,
        emoji: baseExp.exampleEmoji,
      ));
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final stepNotes = widget.unitSpec.lessonExplanations;
    final explanation =
        stepNotes[(widget.topicOrder - 1).clamp(0, stepNotes.length - 1)];
    final cards = _extractLessonCards(explanation);
    final activeExample = cards[_exampleVariantIdx % cards.length];

    // Estrellas de exploración del tema (máximo 3: Historieta/Juegos + Tarjetas + Mini-Reto)
    final hasPlayedExplanationGame = _filledStorySlots.isNotEmpty ||
        _builtPieces.isNotEmpty ||
        _inspectedTileIndices.isNotEmpty;
    final starsEarned = (_activeComicStep > 0 ||
                _exampleVariantIdx > 0 ||
                hasPlayedExplanationGame
            ? 1
            : 0) +
        (_flippedCardIndices.isNotEmpty ? 1 : 0) +
        (_solvedExerciseIndices.isNotEmpty ? 1 : 0);

    return Playful3DCard(
      padding: const EdgeInsets.all(16),
      borderColor: widget.unitSpec.accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Encabezado del Tema + Medidor de Interactividad ──────────────
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: widget.unitSpec.accentColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${widget.topicOrder}',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.topicTitle,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16.5,
                        fontWeight: FontWeight.w900,
                        color: EduPlayColors.textDark,
                      ),
                    ),
                    Text(
                      'Explicación para niños de ${widget.grade}° de primaria',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
              // Medallas interactivas ganadas en este tema
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFF59E0B)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      starsEarned >= 3
                          ? '⭐⭐⭐'
                          : starsEarned == 2
                              ? '⭐⭐☆'
                              : starsEarned == 1
                                  ? '⭐☆☆'
                                  : '☆☆☆',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$starsEarned/3',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── 1. Historieta Paso a Paso + Escena Gráfica Animada ───────────
          _buildInteractiveStorySteps(explanation, activeExample, cards.length),
          const SizedBox(height: 14),

          // ── 1B. Juegos de la Explicación: ¡Completa, Arma y Busca! ───────
          _buildPlayToLearnExplanationGames(explanation, cards),
          const SizedBox(height: 14),

          // ── 2. Máquina Matemática en Vivo (Controles +/- por Tema) ───────
          _buildLiveTopicPlayground(),
          const SizedBox(height: 14),

          // ── 3. Simulador Visual con Abaco/Gráfico + Pista de Lumi ────────
          ExerciseVisualAid(
            questionText: activeExample.question,
            hint: activeExample.explanation,
            compact: true,
          ),
          const SizedBox(height: 16),

          // ── 4. Tarjetas Mágicas Giratorias del Tema ──────────────────────
          _buildInteractiveFlipCards(cards),
          const SizedBox(height: 16),

          // ── 5. Mini-Reto de Práctica en Vivo ("¡Entrena sin perder ❤️!") ─
          _buildInteractivePracticeMiniGame(),
        ],
      ),
    );
  }

  // ── 1. Construye la Historieta Paso a Paso Interactiva ────────────────────
  Widget _buildInteractiveStorySteps(
    _LessonPrepExplanation explanation,
    ({String question, String answer, String explanation, String emoji})
        activeExample,
    int totalExamples,
  ) {
    final accent = widget.unitSpec.accentColor;
    final steps = [
      ('1️⃣ Idea Clave', '🌟'),
      ('2️⃣ Ejemplo Vivo', '🎯'),
      ('3️⃣ Truco Secreto', '🔮'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selector de pasos interactivos + botón para cambiar el ejemplo en vivo
        Wrap(
          spacing: 6,
          runSpacing: 6,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(steps.length, (i) {
                final isSel = _activeComicStep == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: GestureDetector(
                    onTap: () => setState(() => _activeComicStep = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isSel ? accent : accent.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: accent.withValues(alpha: isSel ? 1.0 : 0.35),
                        ),
                      ),
                      child: Text(
                        steps[i].$1,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w900,
                          color: isSel ? Colors.white : accent,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _exampleVariantIdx = (_exampleVariantIdx + 1) % totalExamples;
                  _activeComicStep = 1;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF8B5CF6)),
                ),
                child: Text(
                  '🎲 Otro ejemplo (${(_exampleVariantIdx % totalExamples) + 1}/$totalExamples)',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6D28D9),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Tarjeta 1: ¿Cómo funciona? (tocar la resalta y muestra la misión del tema)
        GestureDetector(
          onTap: () => setState(() => _activeComicStep = 0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _activeComicStep == 0
                  ? accent.withValues(alpha: 0.08)
                  : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _activeComicStep == 0
                    ? accent
                    : const Color(0xFFE2E8F0),
                width: _activeComicStep == 0 ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '🌟 ¿Cómo funciona?',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: accent,
                        ),
                      ),
                    ),
                    Text(
                      'Tema ${widget.topicOrder} de 5',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  explanation.storyExplanation,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: EduPlayColors.textDark,
                    height: 1.36,
                  ),
                ),
                const SizedBox(height: 10),
                // Escena Gráfica Interactiva en Canvas (Tocar para animar la explicación)
                _buildInteractiveStorySceneCanvas(accent),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Tarjeta 2: Ejemplo paso a paso dinámico (cambia con "Otro ejemplo")
        GestureDetector(
          onTap: () => setState(() => _activeComicStep = 1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _activeComicStep == 1
                  ? const Color(0xFFFEF3C7).withValues(alpha: 0.85)
                  : const Color(0xFFFEF3C7).withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFF59E0B)
                    .withValues(alpha: _activeComicStep == 1 ? 0.9 : 0.4),
                width: _activeComicStep == 1 ? 2 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activeExample.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🎯 Ejemplo paso a paso:',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFB45309),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _exampleVariantIdx == 0
                            ? '${explanation.stepByStepExample}\n'
                                '👉 Reto real de este tema: «${activeExample.question}» → Respuesta: ${activeExample.answer}.'
                            : 'Pregunta del tema: «${activeExample.question}»\n'
                                '✅ Respuesta paso a paso: ${activeExample.answer} (${activeExample.explanation}).',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF78350F),
                          height: 1.34,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tarjeta 3 desplegable o destacada cuando el niño toca "3️⃣ Truco Secreto"
        if (_activeComicStep == 2) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF10B981), width: 1.8),
            ),
            child: Row(
              children: [
                const Text('🔮', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '¡Súper Secreto de Lumi para «${widget.topicTitle}»!\n${explanation.secretTrick}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ── Escena Gráfica Interactiva dentro de la Explicación ───────────────────
  Widget _buildInteractiveStorySceneCanvas(Color accent) {
    final fam = _topicFamily;
    final phaseLabels = switch (fam) {
      'fractions' => [
          '1️⃣ Todo entero',
          '2️⃣ Partir igual',
          '3️⃣ Tomar partes',
        ],
      'geometry' => [
          '1️⃣ Borde (Perímetro)',
          '2️⃣ Piso (Área)',
          '3️⃣ Medida total',
        ],
      'algebra' => [
          '1️⃣ Misterio x',
          '2️⃣ Quitar parejo',
          '3️⃣ ¡Balanza igual!',
        ],
      'stats' => [
          '1️⃣ Recoger datos',
          '2️⃣ Subir barras',
          '3️⃣ ¡Ver la Moda!',
        ],
      'operations' => [
          '1️⃣ Ver grupos',
          '2️⃣ Unir / Repartir',
          '3️⃣ ¡Total listo!',
        ],
      _ => [
          '1️⃣ Fichas sueltas',
          '2️⃣ Agrupar de 10',
          '3️⃣ ¡Casilla nueva!',
        ],
    };

    final phaseCaptions = switch (fam) {
      'fractions' => [
          '🍕 Empezamos con 1 unidad completa (100% = todo el círculo y tubo lleno).',
          '🔪 Cortamos la figura en partes exactamente iguales (denominador).',
          '✨ Pintamos las partes que tomamos (numerador) y vemos subir la poción.',
        ],
      'geometry' => [
          '🏃‍♂️ El borde naranja que rodea la figura por fuera es el PERÍMETRO.',
          '🟩 Las baldosas cuadradas que rellenan por dentro forman el ÁREA.',
          '📐 ¡Tocando el dibujo comparas longitud (cm), superficie (cm²) y volumen!',
        ],
      'algebra' => [
          '🕵️ La caja misteriosa «x» guarda un peso secreto en el platillo izquierdo.',
          '⚖️ Si quitamos las mismas pesas a ambos lados, la balanza sigue igual.',
          '🎉 ¡Descubierto! La caja «x» queda solita y sabemos exactamente cuánto vale.',
        ],
      'stats' => [
          '📋 Primero contamos cuántos votos o datos tiene cada opción.',
          '📊 Cada voto hace crecer su barra de color hacia arriba.',
          '🏆 ¡La barra más alta gana la corona de la MODA!',
        ],
      'operations' => [
          '🧺 Miramos cuántas cajas tenemos y cuántas frutas hay en cada una.',
          '⚡ Las flechas mágicas juntan los grupos (o los reparten en partes iguales).',
          '🌟 ¡Obtenemos el resultado sin contar de uno en uno!',
        ],
      _ => [
          '🟩 Empezamos contando unidades sueltas en la casilla de la derecha.',
          '🔄 ¡Magia posicional! Cuando juntas 10 fichas iguales, hacen ¡puf! y se unen.',
          '🟪 Esas 10 fichas se transforman en 1 bloque más grande a la izquierda.',
        ],
    };

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎨', style: TextStyle(fontSize: 15)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Dibujo Interactivo: ¡Toca la imagen o las 3 fases!',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                    color: accent,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(
                  () => _storyScenePhase = (_storyScenePhase + 1) % 3,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '▶️ Animar dibujo',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(
              () => _storyScenePhase = (_storyScenePhase + 1) % 3,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                height: 118,
                color: const Color(0xFFF8FAFC),
                child: CustomPaint(
                  painter: _ExplanationConceptScenePainter(
                    family: fam,
                    phase: _storyScenePhase,
                    accentColor: accent,
                    topicOrder: widget.topicOrder,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(3, (i) {
              final isSel = _storyScenePhase == i;
              return GestureDetector(
                onTap: () => setState(() => _storyScenePhase = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSel ? accent : accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: accent.withValues(alpha: isSel ? 1.0 : 0.35),
                    ),
                  ),
                  child: Text(
                    phaseLabels[i],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: isSel ? Colors.white : accent,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            phaseCaptions[_storyScenePhase % 3],
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: EduPlayColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // ── 1B. Juegos de la Explicación: ¡Completa, Arma y Busca! ────────────────
  Widget _buildPlayToLearnExplanationGames(
    _LessonPrepExplanation explanation,
    List<({String question, String answer, String explanation, String emoji})>
        cards,
  ) {
    final modes = [
      ('🧩 1. Completar', const Color(0xFF7C3AED)),
      ('🏗️ 2. Armar', const Color(0xFF0D9488)),
      ('🔍 3. Buscar', const Color(0xFFEA580C)),
    ];
    final activeColor = modes[_activePlayMode % modes.length].$2;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            activeColor.withValues(alpha: 0.11),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: activeColor.withValues(alpha: 0.5), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🕹️', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Aprende Jugando! Completa, Arma y Busca',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: activeColor,
                      ),
                    ),
                    const Text(
                      'No es un libro aburrido: toca cada juego para descubrir el tema',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Pestañas de los 3 juegos de explicación
          Row(
            children: List.generate(modes.length, (i) {
              final isSel = _activePlayMode == i;
              final mColor = modes[i].$2;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < modes.length - 1 ? 6 : 0),
                  child: GestureDetector(
                    onTap: () => setState(() => _activePlayMode = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSel ? mColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: mColor, width: 1.6),
                        boxShadow: isSel
                            ? [
                                BoxShadow(
                                  color: mColor.withValues(alpha: 0.28),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        modes[i].$1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: isSel ? Colors.white : mColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          if (_activePlayMode == 0)
            _buildCompleteExplanationGame(explanation, cards)
          else if (_activePlayMode == 1)
            _buildConstructExplanationGame()
          else
            _buildSearchExplanationGame(cards),
        ],
      ),
    );
  }

  // ── JUEGO 1: 🧩 EXPLICACIÓN DE COMPLETAR ("¡Completa la historia!") ────────
  Widget _buildCompleteExplanationGame(
    _LessonPrepExplanation explanation,
    List<({String question, String answer, String explanation, String emoji})>
        cards,
  ) {
    final fam = _topicFamily;
    final card0 = cards.first;
    final card1 = cards.length > 1 ? cards[1] : cards.first;

    // 3 retos de completar dentro de la explicación del tema
    final slotsSpec = switch (fam) {
      'fractions' => [
          (
            prefix: '🍕 En una fracción, el número de abajo dice en cuántas ',
            target: 'partes iguales',
            suffix: ' cortamos todo.',
          ),
          (
            prefix: '✨ El número de arriba indica cuántas partes ',
            target: 'tomamos',
            suffix: ' o coloreamos.',
          ),
          (
            prefix: '🎯 En «${card0.question}», el resultado correcto es ',
            target: card0.answer,
            suffix: '.',
          ),
        ],
      'geometry' => [
          (
            prefix: '🏃 El borde que rodea una figura por fuera se llama ',
            target: 'Perímetro',
            suffix: '.',
          ),
          (
            prefix: '🟩 Los cuadritos que rellenan la figura por dentro son el ',
            target: 'Área',
            suffix: '.',
          ),
          (
            prefix: '🎯 En «${card0.question}», la respuesta es ',
            target: card0.answer,
            suffix: '.',
          ),
        ],
      'algebra' => [
          (
            prefix: '🕵️ En álgebra, la letra x representa un ',
            target: 'número secreto',
            suffix: ' escondido.',
          ),
          (
            prefix: '⚖️ Para despejar la balanza hacemos la ',
            target: 'operación contraria',
            suffix: '.',
          ),
          (
            prefix: '🎯 En «${card0.question}», el valor correcto es ',
            target: card0.answer,
            suffix: '.',
          ),
        ],
      'stats' => [
          (
            prefix: '🏆 El dato que más se repite en una encuesta se llama ',
            target: 'Moda',
            suffix: '.',
          ),
          (
            prefix: '📊 En la gráfica de barras, la opción ganadora tiene la ',
            target: 'barra más alta',
            suffix: '.',
          ),
          (
            prefix: '🎯 En «${card0.question}», la respuesta es ',
            target: card0.answer,
            suffix: '.',
          ),
        ],
      'operations' => [
          (
            prefix: '⚡ Para operar rápido agrupamos cantidades ',
            target: 'paso a paso',
            suffix: ' con orden.',
          ),
          (
            prefix: '🎯 En «${card0.question}», el resultado es ',
            target: card0.answer,
            suffix: '.',
          ),
          (
            prefix: '🌟 Y en «${card1.question}», nos da ',
            target: card1.answer,
            suffix: '.',
          ),
        ],
      _ => [
          (
            prefix: '🏠 Cada casilla posicional vale ',
            target: '10 veces más',
            suffix: ' que la de su derecha.',
          ),
          (
            prefix: '🎯 En «${card0.question}», la respuesta es ',
            target: card0.answer,
            suffix: '.',
          ),
          (
            prefix: '🌟 Y en «${card1.question}», el resultado es ',
            target: card1.answer,
            suffix: '.',
          ),
        ],
    };

    final tokenBank = <String>{
      for (final s in slotsSpec) s.target,
      '999',
    }.toList();

    final solvedCount = List.generate(
      slotsSpec.length,
      (i) => _filledStorySlots[i] == slotsSpec[i].target ? 1 : 0,
    ).fold<int>(0, (a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '🧩 ¡Toca un espacio [ ? ] y elige su ficha mágica abajo! ($solvedCount/${slotsSpec.length})',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5B21B6),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (solvedCount == slotsSpec.length) {
                    _filledStorySlots.clear();
                    _activeSlotIdx = 0;
                  } else {
                    for (int i = 0; i < slotsSpec.length; i++) {
                      _filledStorySlots[i] = slotsSpec[i].target;
                    }
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF8B5CF6)),
                ),
                child: Text(
                  solvedCount == slotsSpec.length
                      ? '🔄 Reiniciar'
                      : '🪄 Completar con Lumi',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6D28D9),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Barra gráfica de energía de la historia
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: solvedCount / slotsSpec.length,
            minHeight: 8,
            backgroundColor: const Color(0xFFEDE9FE),
            valueColor:
                const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
          ),
        ),
        const SizedBox(height: 10),

        // Las 3 oraciones interactivas con casillas [ ? ]
        ...List.generate(slotsSpec.length, (i) {
          final slot = slotsSpec[i];
          final currentVal = _filledStorySlots[i];
          final isCorrect = currentVal == slot.target;
          final isFocused = _activeSlotIdx == i;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () => setState(() => _activeSlotIdx = i),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCorrect
                      ? const Color(0xFFECFDF5)
                      : isFocused
                          ? const Color(0xFFF5F3FF)
                          : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isCorrect
                        ? const Color(0xFF10B981)
                        : isFocused
                            ? const Color(0xFF7C3AED)
                            : const Color(0xFFCBD5E1),
                    width: isFocused || isCorrect ? 1.8 : 1.2,
                  ),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      slot.prefix,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.textDark,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? const Color(0xFF10B981)
                            : currentVal != null
                                ? const Color(0xFFFEE2E2)
                                : const Color(0xFFDDD6FE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        currentVal != null
                            ? (isCorrect
                                ? '✅ $currentVal'
                                : '❌ $currentVal (toca otra)')
                            : '❓ Hueco ${i + 1}',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w900,
                          color: isCorrect
                              ? Colors.white
                              : currentVal != null
                                  ? const Color(0xFFB91C1C)
                                  : const Color(0xFF5B21B6),
                        ),
                      ),
                    ),
                    Text(
                      slot.suffix,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: EduPlayColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: 6),
        const Text(
          '👇 Fichas mágicas para colocar en el hueco seleccionado:',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            color: EduPlayColors.textMedium,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tokenBank.map((token) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  final idx = _activeSlotIdx.clamp(0, slotsSpec.length - 1);
                  _filledStorySlots[idx] = token;
                  if (token == slotsSpec[idx].target) {
                    // Avanzar automáticamente al siguiente hueco vacío
                    for (int next = 0; next < slotsSpec.length; next++) {
                      if (_filledStorySlots[next] != slotsSpec[next].target) {
                        _activeSlotIdx = next;
                        break;
                      }
                    }
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '✨ $token',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (solvedCount == slotsSpec.length) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF10B981)),
            ),
            child: const Text(
              '🎉 ¡Genial! Completaste toda la explicación jugando. ¡Ahora prueba «2. Armar» o «3. Buscar»!',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: Color(0xFF065F46),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ── JUEGO 2: 🏗️ EXPLICACIÓN DE ARMAR ("¡Constructor Visual en Lienzo!") ───
  Widget _buildConstructExplanationGame() {
    final fam = _topicFamily;
    final tOrder = widget.topicOrder;

    // Definir meta de construcción y piezas según el tema
    final ({
      String missionTitle,
      int targetValue,
      String unitName,
      List<({String label, int val, String emoji, Color color})> pieces,
    }) buildSpec = switch (fam) {
      'fractions' => (
          missionTitle:
              '🍕 ¡Arma un pedido del ${(tOrder.isOdd ? 75 : 50)}% en el molde circular y tubo de poción!',
          targetValue: tOrder.isOdd ? 75 : 50,
          unitName: '%',
          pieces: [
            (
              label: '+1 Cuarto (25%)',
              val: 25,
              emoji: '🍕',
              color: const Color(0xFFEA580C),
            ),
            (
              label: '+1 Medio (50%)',
              val: 50,
              emoji: '🌗',
              color: const Color(0xFF2563EB),
            ),
            (
              label: '+1 Décimo (10%)',
              val: 10,
              emoji: '🍫',
              color: const Color(0xFF7C3AED),
            ),
          ],
        ),
      'geometry' => (
          missionTitle:
              '📐 ¡Arma en el plano una figura con ${8 + tOrder * 2} baldosas de superficie (cm²)!',
          targetValue: 8 + tOrder * 2,
          unitName: 'cm²',
          pieces: [
            (
              label: '+Bloque de 4 cm²',
              val: 4,
              emoji: '🟦',
              color: const Color(0xFF0D9488),
            ),
            (
              label: '+Bloque de 2 cm²',
              val: 2,
              emoji: '🟩',
              color: const Color(0xFF10B981),
            ),
            (
              label: '+1 baldosa (1 cm²)',
              val: 1,
              emoji: '🟨',
              color: const Color(0xFFF59E0B),
            ),
          ],
        ),
      'algebra' || 'stats' => (
          missionTitle:
              '⚖️ ¡Arma un peso exacto de ${10 + tOrder * 2} en la balanza / gráfica para equilibrarla!',
          targetValue: 10 + tOrder * 2,
          unitName: 'pts',
          pieces: [
            (
              label: '+Pesa de 5',
              val: 5,
              emoji: '⚖️',
              color: const Color(0xFF7C3AED),
            ),
            (
              label: '+Pesa de 2',
              val: 2,
              emoji: '🧱',
              color: const Color(0xFF2563EB),
            ),
            (
              label: '+Pesa de 1',
              val: 1,
              emoji: '🪙',
              color: const Color(0xFFD97706),
            ),
          ],
        ),
      'operations' => (
          missionTitle:
              '🧺 ¡Arma exactamente ${12 + tOrder * 3} frutas combinando cajas iguales!',
          targetValue: 12 + tOrder * 3,
          unitName: 'frutas',
          pieces: [
            (
              label: '+Caja de 5',
              val: 5,
              emoji: '🍎',
              color: const Color(0xFFEF4444),
            ),
            (
              label: '+Caja de 3',
              val: 3,
              emoji: '🍊',
              color: const Color(0xFFF59E0B),
            ),
            (
              label: '+1 suelta',
              val: 1,
              emoji: '🍓',
              color: const Color(0xFFEC4899),
            ),
          ],
        ),
      _ => (
          missionTitle:
              '🏗️ ¡Arma el número ${widget.grade <= 2 ? (20 + tOrder * 4) : (120 + tOrder * 15)} con bloques en la torre!',
          targetValue:
              widget.grade <= 2 ? (20 + tOrder * 4) : (120 + tOrder * 15),
          unitName: 'unidades',
          pieces: [
            if (widget.grade >= 3)
              (
                label: '+1 Centena (100)',
                val: 100,
                emoji: '🟪',
                color: const Color(0xFF7C3AED),
              ),
            (
              label: '+1 Decena (10)',
              val: 10,
              emoji: '🟦',
              color: const Color(0xFF2563EB),
            ),
            (
              label: '+5 Unidades (5)',
              val: 5,
              emoji: '🟧',
              color: const Color(0xFFF59E0B),
            ),
            (
              label: '+1 Unidad (1)',
              val: 1,
              emoji: '🟩',
              color: const Color(0xFF10B981),
            ),
          ],
        ),
    };

    final currentTotal = _builtPieces.fold<int>(0, (a, b) => a + b);
    final isExactMatch = currentTotal == buildSpec.targetValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          buildSpec.missionTitle,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12.5,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F766E),
          ),
        ),
        const SizedBox(height: 8),

        // Lienzo gráfico de construcción (CustomPaint) — tocarlo agrega pieza automáticamente
        GestureDetector(
          onTap: () {
            if (_builtPieces.length < 18 &&
                currentTotal < buildSpec.targetValue) {
              setState(() => _builtPieces.add(buildSpec.pieces.last.val));
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              height: 122,
              decoration: BoxDecoration(
                color: isExactMatch
                    ? const Color(0xFFECFDF5)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isExactMatch
                      ? const Color(0xFF10B981)
                      : const Color(0xFF0D9488).withValues(alpha: 0.45),
                  width: 1.8,
                ),
              ),
              child: CustomPaint(
                painter: _ConceptBuilderCanvasPainter(
                  family: fam,
                  pieces: List<int>.from(_builtPieces),
                  currentTotal: currentTotal,
                  targetValue: buildSpec.targetValue,
                  unitName: buildSpec.unitName,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Botones de piezas para armar + quitar/limpiar
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final p in buildSpec.pieces)
              GestureDetector(
                onTap: () {
                  if (_builtPieces.length < 20) {
                    setState(() => _builtPieces.add(p.val));
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: p.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${p.emoji} ${p.label}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (_builtPieces.isNotEmpty)
              GestureDetector(
                onTap: () => setState(() => _builtPieces.removeLast()),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFEF4444)),
                  ),
                  child: const Text(
                    '↩️ Quitar 1',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFB91C1C),
                    ),
                  ),
                ),
              ),
            if (_builtPieces.isNotEmpty)
              GestureDetector(
                onTap: () => setState(() => _builtPieces.clear()),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF94A3B8)),
                  ),
                  child: const Text(
                    '🧹 Limpiar',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF475569),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isExactMatch
                ? const Color(0xFFECFDF5)
                : currentTotal > buildSpec.targetValue
                    ? const Color(0xFFFFFBEB)
                    : const Color(0xFFF0FDFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExactMatch
                  ? const Color(0xFF10B981)
                  : currentTotal > buildSpec.targetValue
                      ? const Color(0xFFF59E0B)
                      : const Color(0xFF14B8A6),
            ),
          ),
          child: Text(
            isExactMatch
                ? '🏆 ¡Construcción Perfecta! Armaste exactamente $currentTotal ${buildSpec.unitName} con ${_builtPieces.length} piezas.'
                : currentTotal > buildSpec.targetValue
                    ? '👀 Te pasaste un poquito ($currentTotal vs meta ${buildSpec.targetValue}). ¡Toca «↩️ Quitar 1»!'
                    : '🔨 Llevas $currentTotal de ${buildSpec.targetValue} ${buildSpec.unitName} (faltan ${buildSpec.targetValue - currentTotal}). ¡Sigue agregando piezas!',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: isExactMatch
                  ? const Color(0xFF065F46)
                  : currentTotal > buildSpec.targetValue
                      ? const Color(0xFF92400E)
                      : const Color(0xFF0F766E),
            ),
          ),
        ),
      ],
    );
  }

  // ── JUEGO 3: 🔍 EXPLICACIÓN DE BUSCAR ("¡Misión Detective con Lupa!") ──────
  Widget _buildSearchExplanationGame(
    List<({String question, String answer, String explanation, String emoji})>
        cards,
  ) {
    final fam = _topicFamily;
    final c0 = cards.first;
    final c1 = cards.length > 1 ? cards[1] : cards.first;
    final c2 = cards.length > 2 ? cards[2] : cards.first;

    // 6 casillas visuales de búsqueda: 3 verdaderas (tesoros del tema) + 3 distractores
    final List<({String emoji, String title, String clue, bool isTreasure})>
        searchTiles = switch (fam) {
      'fractions' => [
          (
            emoji: '🍕',
            title: '1/2 = 50% = 0,5',
            clue: '¡Correcto! Mitad, 50% y 0,5 valen lo mismo.',
            isTreasure: true,
          ),
          (
            emoji: '🎯',
            title: '${c0.question} → ${c0.answer}',
            clue: '¡Correcto! Es un reto verdadero del tema.',
            isTreasure: true,
          ),
          (
            emoji: '🚫',
            title: '1/4 = 40%',
            clue: '¡Intruso! 1/4 es 25%, no 40%.',
            isTreasure: false,
          ),
          (
            emoji: '🍰',
            title: '3/4 = 75% = 0,75',
            clue: '¡Lo encontraste! 3 cuartos equivalen a 75%.',
            isTreasure: true,
          ),
          (
            emoji: '🚫',
            title: '2/2 = La mitad',
            clue: '¡Intruso! 2/2 es la pizza entera (100%).',
            isTreasure: false,
          ),
          (
            emoji: '🚫',
            title: '1/10 = 100%',
            clue: '¡Intruso! 1/10 es apenas el 10%.',
            isTreasure: false,
          ),
        ],
      'geometry' => [
          (
            emoji: '🏡',
            title: 'Perímetro = Suma de lados',
            clue: '¡Correcto! El perímetro rodea toda la figura.',
            isTreasure: true,
          ),
          (
            emoji: '🌱',
            title: 'Área rectángulo = Base×Altura',
            clue: '¡Correcto! Así contamos los cuadritos de adentro.',
            isTreasure: true,
          ),
          (
            emoji: '🚫',
            title: 'Ángulo recto = 180°',
            clue: '¡Intruso! El ángulo recto mide exactamente 90°.',
            isTreasure: false,
          ),
          (
            emoji: '🎯',
            title: '${c0.question} → ${c0.answer}',
            clue: '¡Correcto! Cumple la regla geométrica del tema.',
            isTreasure: true,
          ),
          (
            emoji: '🚫',
            title: '1 metro = 10 cm',
            clue: '¡Intruso! 1 metro tiene 100 centímetros.',
            isTreasure: false,
          ),
          (
            emoji: '🚫',
            title: 'Triángulo = 4 lados',
            clue: '¡Intruso! El triángulo tiene 3 lados.',
            isTreasure: false,
          ),
        ],
      _ => [
          (
            emoji: '💎',
            title: '${c0.question} → ${c0.answer}',
            clue: '¡Tesoro encontrado! ${c0.explanation}',
            isTreasure: true,
          ),
          (
            emoji: '🚫',
            title: '1 Decena = 100 U',
            clue: '¡Intruso! 1 Decena vale 10 unidades, no 100.',
            isTreasure: false,
          ),
          (
            emoji: '🌟',
            title: '${c1.question} → ${c1.answer}',
            clue: '¡Tesoro encontrado! ${c1.explanation}',
            isTreasure: true,
          ),
          (
            emoji: '🚫',
            title: 'Orden no importa al restar',
            clue: '¡Intruso! En la resta el mayor siempre va primero.',
            isTreasure: false,
          ),
          (
            emoji: '🚀',
            title: '${c2.question} → ${c2.answer}',
            clue: '¡Tesoro encontrado! ${c2.explanation}',
            isTreasure: true,
          ),
          (
            emoji: '🚫',
            title: '5 Centenas = 50',
            clue: '¡Intruso! 5 Centenas valen 500 unidades.',
            isTreasure: false,
          ),
        ],
    };

    final foundTreasures = _inspectedTileIndices
        .where((idx) => idx < searchTiles.length && searchTiles[idx].isTreasure)
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '🕵️‍♀️ Misión Detective: ¡Busca y toca las 3 fichas verdaderas escondidas! ($foundTreasures/3 encontradas)',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFC2410C),
                ),
              ),
            ),
            if (_inspectedTileIndices.isNotEmpty)
              GestureDetector(
                onTap: () => setState(() => _inspectedTileIndices.clear()),
                child: const Text(
                  '🔄 Ocultar',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEA580C),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(searchTiles.length, (i) {
            final tile = searchTiles[i];
            final inspected = _inspectedTileIndices.contains(i);
            final bgColor = !inspected
                ? Colors.white
                : tile.isTreasure
                    ? const Color(0xFFECFDF5)
                    : const Color(0xFFFFFBEB);
            final borderColor = !inspected
                ? const Color(0xFFFDBA74)
                : tile.isTreasure
                    ? const Color(0xFF10B981)
                    : const Color(0xFFF59E0B);

            return GestureDetector(
              onTap: () => setState(() => _inspectedTileIndices.add(i)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 155,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 1.8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          inspected
                              ? (tile.isTreasure ? '✅' : '🕵️')
                              : '🔍',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            tile.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 11.5,
                              fontWeight: FontWeight.w900,
                              color: !inspected
                                  ? EduPlayColors.textDark
                                  : tile.isTreasure
                                      ? const Color(0xFF065F46)
                                      : const Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      inspected
                          ? tile.clue
                          : '👆 Toca con la lupa para investigar',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: !inspected
                            ? const Color(0xFFEA580C)
                            : tile.isTreasure
                                ? const Color(0xFF047857)
                                : const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        if (foundTreasures >= 3) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF10B981)),
            ),
            child: const Text(
              '🕵️‍♂️🏆 ¡Misión Detective Completada! Encontraste los 3 secretos verdaderos y descubriste a los intrusos.',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Color(0xFF065F46),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ── 2. Máquina Matemática en Vivo (Laboratorio Manipulable del Tema) ──────
  Widget _buildLiveTopicPlayground() {
    final fam = _topicFamily;
    final accent = widget.unitSpec.accentColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.09),
            const Color(0xFFF8FAFC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎛️', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '¡Laboratorio en Vivo de ${widget.topicTitle}!',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: accent,
                  ),
                ),
              ),
              const Text(
                'Toca + y −',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: EduPlayColors.textMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (fam == 'fractions')
            _buildLiveFractionsMachine(accent)
          else if (fam == 'geometry')
            _buildLiveGeometryMachine(accent)
          else if (fam == 'algebra')
            _buildLiveAlgebraMachine(accent)
          else if (fam == 'stats')
            _buildLiveStatsMachine(accent)
          else if (fam == 'operations')
            _buildLiveOperationsMachine(accent)
          else
            _buildLiveNumbersMachine(accent),
        ],
      ),
    );
  }

  Widget _buildLiveNumbersMachine(Color accent) {
    final isNeg = widget.unitId == 'unit-501';
    if (isNeg) {
      final result = _liveValA + _liveValB;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _NumberStepperControl(
                label: 'Punto inicial',
                value: _liveValA,
                color: const Color(0xFF2563EB),
                onChanged: (v) => setState(() => _liveValA = v.clamp(-15, 15)),
              ),
              _NumberStepperControl(
                label: 'Cambio / Salto',
                value: _liveValB,
                color: const Color(0xFF059669),
                onChanged: (v) => setState(() => _liveValB = v.clamp(-15, 15)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accent.withValues(alpha: 0.3)),
            ),
            child: Text(
              '🌡️ Empiezas en $_liveValA y das un salto de ${_liveValB >= 0 ? "+$_liveValB" : "$_liveValB"} → '
              '¡Llegas a $result! (${result < 0 ? "Bajo cero ❄️" : result > 0 ? "Sobre cero ☀️" : "En el origen ⚓"})',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: EduPlayColors.textDark,
              ),
            ),
          ),
        ],
      );
    }

    final n = _liveValA.clamp(1, 999999);
    final c = (n ~/ 100) % 10;
    final d = (n ~/ 10) % 10;
    final u = n % 10;
    final um = n ~/ 1000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final delta in [
              if (widget.grade >= 3) -100,
              -10,
              -1,
              1,
              10,
              if (widget.grade >= 3) 100,
            ])
              GestureDetector(
                onTap: () => setState(
                  () => _liveValA = (_liveValA + delta).clamp(1, 999999),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: delta > 0
                        ? const Color(0xFFDBEAFE)
                        : const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: delta > 0
                          ? const Color(0xFF2563EB)
                          : const Color(0xFFEF4444),
                    ),
                  ),
                  child: Text(
                    delta > 0 ? '+$delta' : '$delta',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: delta > 0
                          ? const Color(0xFF1D4ED8)
                          : const Color(0xFFB91C1C),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🔢 Número armado en vivo: $n',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '🧩 Descomposición: '
                '${um > 0 ? "$um UM (${um * 1000}) + " : ""}'
                '${c > 0 ? "$c C (${c * 100}) + " : ""}'
                '$d D (${d * 10}) + $u U ($u)',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: EduPlayColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${"🟪" * c.clamp(0, 9)} ${"🟦" * d.clamp(0, 9)} ${"🟩" * u.clamp(0, 9)}'
                    .trim(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLiveOperationsMachine(Color accent) {
    final ops = [
      ('➕ Sumar', '+'),
      ('➖ Restar', '−'),
      ('✖️ Multiplicar', '×'),
      ('➗ Repartir', '÷'),
    ];
    final a = _liveValA.clamp(1, 30);
    final b = _liveValB.clamp(1, 12);
    final String resultText;
    if (_liveOpIdx == 0) {
      resultText = '$a + $b = ${a + b} (Juntamos $a y $b)';
    } else if (_liveOpIdx == 1) {
      final big = math.max(a, b);
      final small = math.min(a, b);
      resultText = '$big − $small = ${big - small} (A $big le quitamos $small)';
    } else if (_liveOpIdx == 2) {
      final groups = a.clamp(1, 8);
      final perGroup = b.clamp(1, 8);
      resultText =
          '$groups × $perGroup = ${groups * perGroup} ($groups grupos de $perGroup)';
    } else {
      final divisor = b.clamp(1, 9);
      final total = divisor * a.clamp(1, 9);
      resultText =
          '$total ÷ $divisor = ${total ~/ divisor} (Repartimos $total en $divisor partes iguales)';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selector de operación
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: List.generate(ops.length, (i) {
            final isSel = _liveOpIdx == i;
            return GestureDetector(
              onTap: () => setState(() => _liveOpIdx = i),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: isSel ? accent : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accent),
                ),
                child: Text(
                  ops[i].$1,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: isSel ? Colors.white : accent,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _NumberStepperControl(
              label: 'Número A',
              value: a,
              color: const Color(0xFF7C3AED),
              onChanged: (v) => setState(() => _liveValA = v.clamp(1, 20)),
            ),
            _NumberStepperControl(
              label: 'Número B',
              value: b,
              color: const Color(0xFFEC4899),
              onChanged: (v) => setState(() => _liveValB = v.clamp(1, 12)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⚡ Resultado en vivo: $resultText',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _liveOpIdx == 2
                    ? List.generate(
                        a.clamp(1, 5),
                        (_) => '[${"🍓" * b.clamp(1, 5)}]',
                      ).join(' + ')
                    : '${"🍎" * a.clamp(1, 10)}   ${ops[_liveOpIdx].$2}   ${"🍏" * b.clamp(1, 10)}',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLiveFractionsMachine(Color accent) {
    final den = _liveValB.clamp(2, 10);
    final num = _liveValA.clamp(1, den);
    final pct = ((num / den) * 100).round();
    final dec = (num / den).toStringAsFixed(2).replaceAll('.', ',');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _NumberStepperControl(
              label: 'Partes que tomas (Arriba)',
              value: num,
              color: const Color(0xFFEA580C),
              onChanged: (v) =>
                  setState(() => _liveValA = v.clamp(1, _liveValB.clamp(2, 10))),
            ),
            _NumberStepperControl(
              label: 'Total partes (Abajo)',
              value: den,
              color: const Color(0xFF7C3AED),
              onChanged: (v) => setState(() {
                _liveValB = v.clamp(2, 10);
                if (_liveValA > _liveValB) _liveValA = _liveValB;
              }),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Barra de chocolatina/pizza interactiva (tocar cada bloque cambia el numerador)
        const Text(
          '👆 Toca los pedazos de la barra para colorearlos o quitarlos:',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            color: EduPlayColors.textMedium,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: List.generate(den, (i) {
            final active = i < num;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _liveValA = i + 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  height: 34,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color:
                        active ? const Color(0xFFEA580C) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFEA580C),
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    active ? '🍕' : '${i + 1}',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: active ? Colors.white : const Color(0xFFEA580C),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _EquivalenceBadge(
              label: 'Fracción',
              value: '$num/$den',
              color: const Color(0xFFEA580C),
            ),
            _EquivalenceBadge(
              label: 'Decimal',
              value: dec,
              color: const Color(0xFF2563EB),
            ),
            _EquivalenceBadge(
              label: 'Porcentaje',
              value: '$pct%',
              color: const Color(0xFF059669),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLiveGeometryMachine(Color accent) {
    final a = _liveValA.clamp(1, 12);
    final b = _liveValB.clamp(1, 10);
    final lower =
        '${CurriculumData.unitTitles[widget.unitId] ?? ''} ${widget.topicTitle}'
            .toLowerCase();
    final isCircle = lower.contains('circunferencia') ||
        lower.contains('radio') ||
        lower.contains('diámetro') ||
        lower.contains('pi');
    final isVolume = lower.contains('volumen') || lower.contains('cuerpos');
    final isClock = lower.contains('reloj') || lower.contains('tiempo');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _NumberStepperControl(
              label: isClock
                  ? 'Hora'
                  : isCircle
                      ? 'Radio (cm)'
                      : 'Base / Largo (cm)',
              value: a,
              color: const Color(0xFF0D9488),
              onChanged: (v) => setState(() => _liveValA = v.clamp(1, 12)),
            ),
            if (!isCircle)
              _NumberStepperControl(
                label: isClock
                    ? 'Media hora (0 o 30)'
                    : isVolume
                        ? 'Ancho / Alto (cm)'
                        : 'Altura (cm)',
                value: b,
                color: const Color(0xFF2563EB),
                onChanged: (v) => setState(() => _liveValB = v.clamp(1, 10)),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Text(
            isClock
                ? '🕒 Reloj en vivo: Marca las $a:${b.isEven ? "00 (en punto)" : "30 (y media)"} → ${a * 60 + (b.isEven ? 0 : 30)} minutos desde las 12:00.'
                : isCircle
                    ? '⭕ Si el Radio = $a cm → Diámetro = ${2 * a} cm · Circunferencia ≈ ${(2 * 3.14 * a).toStringAsFixed(2).replaceAll(".", ",")} cm.'
                    : isVolume
                        ? '🧊 Prisma de $a cm × $b cm × 2 cm → Volumen = $a × $b × 2 = ${a * b * 2} cm³ (${a * b * 2} cubitos).'
                        : '📐 Rectángulo de $a cm × $b cm:\n'
                            '• Perímetro (borde) = $a + $b + $a + $b = ${2 * (a + b)} cm\n'
                            '• Área (piso interior) = $a × $b = ${a * b} cm²',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: EduPlayColors.textDark,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveAlgebraMachine(Color accent) {
    final xVal = _liveValA.clamp(1, 15);
    final added = _liveValB.clamp(1, 12);
    final total = xVal + added;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _NumberStepperControl(
              label: 'Valor secreto (x)',
              value: xVal,
              color: const Color(0xFF7C3AED),
              onChanged: (v) => setState(() => _liveValA = v.clamp(1, 15)),
            ),
            _NumberStepperControl(
              label: 'Número sumado (+)',
              value: added,
              color: const Color(0xFFD97706),
              onChanged: (v) => setState(() => _liveValB = v.clamp(1, 12)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Text(
            '⚖️ Balanza en equilibrio:  x + $added = $total\n'
            '🕵️‍♂️ Si despejamos x haciendo la operación contraria: x = $total − $added = $xVal',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: EduPlayColors.textDark,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveStatsMachine(Color accent) {
    final votesA = _liveValA.clamp(1, 12);
    final votesB = _liveValB.clamp(1, 12);
    const votesC = 4;
    final total = votesA + votesB + votesC;
    final modeName = votesA >= votesB && votesA >= votesC
        ? '⚽ Fútbol ($votesA)'
        : votesB >= votesA && votesB >= votesC
            ? '🏀 Básquet ($votesB)'
            : '🚴 Ciclismo ($votesC)';
    final avg = (total / 3).toStringAsFixed(1).replaceAll('.', ',');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _NumberStepperControl(
              label: '⚽ Votos Fútbol',
              value: votesA,
              color: const Color(0xFF10B981),
              onChanged: (v) => setState(() => _liveValA = v.clamp(1, 12)),
            ),
            _NumberStepperControl(
              label: '🏀 Votos Básquet',
              value: votesB,
              color: const Color(0xFFF59E0B),
              onChanged: (v) => setState(() => _liveValB = v.clamp(1, 12)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Text(
            '📊 Encuesta en vivo: ⚽ $votesA · 🏀 $votesB · 🚴 $votesC (Total = $total votos)\n'
            '🏆 Moda (más votado): $modeName · 🤝 Promedio: $avg · 🎲 Probabilidad ⚽: $votesA/$total',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: EduPlayColors.textDark,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  // ── 4. Tarjetas Mágicas Giratorias del Tema ──────────────────────────────
  Widget _buildInteractiveFlipCards(
    List<({String question, String answer, String explanation, String emoji})>
        cards,
  ) {
    final visibleCards = cards.take(3).toList();
    final accent = widget.unitSpec.accentColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🃏', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            const Expanded(
              child: Text(
                'Tarjetas Mágicas: ¡Toca cada tarjeta para voltearla!',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: EduPlayColors.textDark,
                ),
              ),
            ),
            Text(
              '${_flippedCardIndices.length}/${visibleCards.length} descubiertas',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: List.generate(visibleCards.length, (i) {
            final card = visibleCards[i];
            final isFlipped = _flippedCardIndices.contains(i);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (isFlipped) {
                      _flippedCardIndices.remove(i);
                    } else {
                      _flippedCardIndices.add(i);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isFlipped
                        ? const Color(0xFFECFDF5)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isFlipped
                          ? const Color(0xFF10B981)
                          : accent.withValues(alpha: 0.4),
                      width: 1.6,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: isFlipped
                              ? const Color(0xFF10B981)
                              : accent.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          isFlipped ? '✅' : '❓',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isFlipped
                                  ? '✨ Respuesta: ${card.answer}'
                                  : 'Misterio #${i + 1}: ${card.question}',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: isFlipped
                                    ? const Color(0xFF065F46)
                                    : EduPlayColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isFlipped
                                  ? '💡 ${card.explanation} (Toca para volver a tapar)'
                                  : '👆 Toca esta tarjeta mágica para revelar el secreto',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: isFlipped
                                    ? const Color(0xFF047857)
                                    : accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ── 5. Mini-Reto de Práctica Interactiva del Tema (sin perder vidas) ─────
  Widget _buildInteractivePracticeMiniGame() {
    final exercises = widget.fullLesson?.exercises ?? const <Exercise>[];
    if (exercises.isEmpty) return const SizedBox.shrink();

    final exIdx = _practiceExIdx.clamp(0, exercises.length - 1);
    final ex = exercises[exIdx];
    final c = ex.content;
    final accent = widget.unitSpec.accentColor;

    // Convertir cualquier tipo de ejercicio en pregunta + opciones interactivas
    String prompt = '';
    List<String> options = [];
    String correctOption = '';

    if (ex.type == ExerciseType.multipleChoice) {
      prompt = (c['question'] as String?) ?? '';
      options = (c['options'] as List?)?.cast<String>() ?? const [];
      final idx = (c['correct_index'] as int?) ?? 0;
      if (idx >= 0 && idx < options.length) {
        correctOption = options[idx];
      }
    } else if (ex.type == ExerciseType.fillBlank) {
      prompt = (c['sentence'] as String?) ?? '';
      options = (c['options'] as List?)?.cast<String>() ?? const [];
      correctOption = (c['correct_answer'] as String?) ?? '';
    } else if (ex.type == ExerciseType.dragDrop) {
      final mapping = c['correct_mapping'] as Map?;
      final firstEntry =
          (mapping != null && mapping.isNotEmpty) ? mapping.entries.first : null;
      prompt =
          '${c['instruction'] ?? 'Relaciona'}: ¿Con cuál pareja va «${firstEntry?.key ?? ''}»?';
      options = (c['targets'] as List?)?.cast<String>() ?? const [];
      correctOption = '${firstEntry?.value ?? ''}';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF8B5CF6), width: 1.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎮', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Mini-Reto de Entrenamiento (${exIdx + 1}/${exercises.length})',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF5B21B6),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFC4B5FD)),
                ),
                child: const Text(
                  '❤️ Sin perder vidas',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6D28D9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            prompt,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: EduPlayColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((opt) {
              final isSelected = _selectedPracticeOption == opt;
              final isRight = opt == correctOption;
              Color bgColor = Colors.white;
              Color borderColor = const Color(0xFFC4B5FD);
              Color textColor = const Color(0xFF4C1D95);

              if (isSelected) {
                if (isRight) {
                  bgColor = const Color(0xFF10B981);
                  borderColor = const Color(0xFF059669);
                  textColor = Colors.white;
                } else {
                  bgColor = const Color(0xFFFEE2E2);
                  borderColor = const Color(0xFFEF4444);
                  textColor = const Color(0xFFB91C1C);
                }
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPracticeOption = opt;
                    _isPracticeCorrect = isRight;
                    if (isRight) {
                      _solvedExerciseIndices.add(exIdx);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 1.8),
                  ),
                  child: Text(
                    opt,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (_selectedPracticeOption != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isPracticeCorrect == true
                    ? const Color(0xFFECFDF5)
                    : const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isPracticeCorrect == true
                      ? const Color(0xFF10B981)
                      : const Color(0xFFF59E0B),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    _isPracticeCorrect == true ? '🎉' : '💡',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _isPracticeCorrect == true
                          ? '¡Súper bien! «$_selectedPracticeOption» es correcto. ${ex.hint ?? "¡Ya dominas este paso!"}'
                          : '¡Casi! Pista de Lumi: ${ex.hint ?? "Mira el laboratorio de arriba e intenta otra opción."}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: _isPracticeCorrect == true
                            ? const Color(0xFF065F46)
                            : const Color(0xFF92400E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _practiceExIdx = (_practiceExIdx + 1) % exercises.length;
                  _selectedPracticeOption = null;
                  _isPracticeCorrect = null;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '🔄 Otra pregunta de este tema →',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberStepperControl extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final ValueChanged<int> onChanged;

  const _NumberStepperControl({
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: EduPlayColors.textDark,
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(value - 1),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(7),
              ),
              alignment: Alignment.center,
              child: Text(
                '−',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$value',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(value + 1),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(7),
              ),
              alignment: Alignment.center,
              child: const Text(
                '+',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EquivalenceBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _EquivalenceBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }
}

// ─── Widgets Auxiliares ──────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: EduPlayColors.textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SandboxActionChip extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final bool active;
  final VoidCallback onTap;

  const _SandboxActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: active ? color : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: active ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DraggablePieceWidget extends StatelessWidget {
  final _DraggableBoardItem item;
  final bool isInsideTarget;

  const _DraggablePieceWidget({
    required this.item,
    required this.isInsideTarget,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: 52,
      height: 46,
      decoration: BoxDecoration(
        color: isInsideTarget ? item.color : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.color,
          width: isInsideTarget ? 2.5 : 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: item.color.withValues(alpha: isInsideTarget ? 0.35 : 0.18),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.emoji,
            style: const TextStyle(fontSize: 15, height: 1.0),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              color: isInsideTarget ? Colors.white : item.color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Painters del Tablero Manipulable y Escenas ────────────────────────────

class _SandboxBackgroundPainter extends CustomPainter {
  final Color accentColor;
  _SandboxBackgroundPainter({required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Cuadrícula suave de fondo
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Zona Mágica derecha resaltada
    final targetRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(150, 6, size.width - 156, size.height - 12),
      const Radius.circular(16),
    );
    canvas.drawRRect(
      targetRect,
      Paint()..color = accentColor.withValues(alpha: 0.09),
    );
    canvas.drawRRect(
      targetRect,
      Paint()
        ..color = accentColor.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _SandboxBackgroundPainter old) =>
      old.accentColor != accentColor;
}

class _ExplanationConceptScenePainter extends CustomPainter {
  final String family;
  final int phase;
  final Color accentColor;
  final int topicOrder;

  _ExplanationConceptScenePainter({
    required this.family,
    required this.phase,
    required this.accentColor,
    required this.topicOrder,
  });

  void _drawLabel(
    Canvas canvas,
    String text,
    Offset center, {
    Color color = const Color(0xFF1E293B),
    double fontSize = 11.5,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Fondo decorativo suave
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(4, 4, w - 8, h - 8),
        const Radius.circular(10),
      ),
      Paint()..color = accentColor.withValues(alpha: 0.06),
    );

    if (family == 'fractions') {
      // Pizza circular a la izquierda + Tubo de poción graduado a la derecha
      final cx = w * 0.30;
      final cy = h * 0.52;
      const r = 36.0;
      final slices = phase == 0 ? 1 : 4;
      final activeSlices = phase == 0
          ? 1
          : phase == 1
              ? 1
              : 3;

      for (int i = 0; i < slices; i++) {
        final startAngle = -math.pi / 2 + (i * 2 * math.pi / slices);
        final sweep = 2 * math.pi / slices;
        final isFilled = i < activeSlices;
        canvas.drawArc(
          Rect.fromCircle(center: Offset(cx, cy), radius: r),
          startAngle,
          sweep,
          true,
          Paint()
            ..color = isFilled
                ? const Color(0xFFEA580C)
                : const Color(0xFFFED7AA).withValues(alpha: 0.5),
        );
        canvas.drawArc(
          Rect.fromCircle(center: Offset(cx, cy), radius: r),
          startAngle,
          sweep,
          true,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.2,
        );
      }
      _drawLabel(
        canvas,
        phase == 0
            ? '1 Entero (100%)'
            : phase == 1
                ? 'Cortado en 4 (1/4)'
                : '3/4 = 0,75 = 75%',
        Offset(cx, h - 14),
        color: const Color(0xFF9A3412),
      );

      // Tubo de poción mágica a la derecha
      final tubeRect = Rect.fromLTWH(w * 0.65, 16, 44, h - 38);
      final fillRatio = phase == 0
          ? 1.0
          : phase == 1
              ? 0.25
              : 0.75;
      canvas.drawRRect(
        RRect.fromRectAndRadius(tubeRect, const Radius.circular(10)),
        Paint()..color = Colors.white,
      );
      final fillHeight = tubeRect.height * fillRatio;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            tubeRect.left,
            tubeRect.bottom - fillHeight,
            tubeRect.width,
            fillHeight,
          ),
          const Radius.circular(10),
        ),
        Paint()..color = const Color(0xFF10B981).withValues(alpha: 0.8),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(tubeRect, const Radius.circular(10)),
        Paint()
          ..color = const Color(0xFF047857)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      _drawLabel(
        canvas,
        '${(fillRatio * 100).round()}%',
        tubeRect.center,
        color: const Color(0xFF064E3B),
      );
      return;
    }

    if (family == 'geometry') {
      // Cuadrícula de arquitecto: Fase 0 resalta borde, Fase 1 rellena baldosas, Fase 2 muestra medidas
      const cols = 4;
      const rows = 3;
      const cell = 22.0;
      final startX = (w - cols * cell) / 2;
      final startY = (h - rows * cell) / 2 - 4;

      for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
          final rect = Rect.fromLTWH(
            startX + c * cell,
            startY + r * cell,
            cell,
            cell,
          );
          if (phase >= 1) {
            canvas.drawRect(
              rect,
              Paint()..color = const Color(0xFF14B8A6).withValues(alpha: 0.35),
            );
          }
          canvas.drawRect(
            rect,
            Paint()
              ..color = const Color(0xFFCBD5E1)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1,
          );
        }
      }

      // Borde exterior de perímetro
      final outerRect = Rect.fromLTWH(startX, startY, cols * cell, rows * cell);
      canvas.drawRect(
        outerRect,
        Paint()
          ..color = phase == 0
              ? const Color(0xFFEA580C)
              : const Color(0xFF0F766E)
          ..style = PaintingStyle.stroke
          ..strokeWidth = phase == 0 ? 3.5 : 2.5,
      );

      _drawLabel(
        canvas,
        phase == 0
            ? 'Perímetro (Borde) = 4+3+4+3 = 14 cm'
            : phase == 1
                ? 'Área (Adentro) = 4 × 3 = 12 cuadritos (cm²)'
                : 'Borde = 14 cm  ·  Piso = 12 cm²',
        Offset(w / 2, h - 13),
        color: const Color(0xFF0F766E),
      );
      return;
    }

    if (family == 'algebra' || family == 'stats') {
      // Balanza interactiva que se nivela o gráfica con podio
      final cx = w / 2;
      final baseBottom = h - 22;
      // Pedestal
      final stand = Path()
        ..moveTo(cx - 16, baseBottom)
        ..lineTo(cx + 16, baseBottom)
        ..lineTo(cx, baseBottom - 36)
        ..close();
      canvas.drawPath(stand, Paint()..color = const Color(0xFF64748B));

      final tilt = phase == 0
          ? -0.12
          : phase == 1
              ? 0.05
              : 0.0;
      canvas.save();
      canvas.translate(cx, baseBottom - 36);
      canvas.rotate(tilt);

      // Barra de la balanza
      canvas.drawLine(
        const Offset(-85, 0),
        const Offset(85, 0),
        Paint()
          ..color = phase == 2
              ? const Color(0xFF10B981)
              : const Color(0xFFD97706)
          ..strokeWidth = 4.5
          ..strokeCap = StrokeCap.round,
      );

      // Platillo izquierdo (Caja x)
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-98, -28, 36, 26),
          const Radius.circular(6),
        ),
        Paint()..color = const Color(0xFF7C3AED),
      );
      _drawLabel(
        canvas,
        phase == 2 ? 'x=6' : 'x+4',
        const Offset(-80, -15),
        color: Colors.white,
      );

      // Platillo derecho (Resultado)
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(62, -28, 38, 26),
          const Radius.circular(6),
        ),
        Paint()..color = const Color(0xFF10B981),
      );
      _drawLabel(
        canvas,
        phase == 2 ? '6' : '10',
        const Offset(81, -15),
        color: Colors.white,
      );
      canvas.restore();

      _drawLabel(
        canvas,
        phase == 0
            ? 'Balanza con misterio: x + 4 = 10'
            : phase == 1
                ? 'Quitamos 4 en ambos lados: x = 10 − 4'
                : '¡Equilibrio perfecto! x vale 6',
        Offset(cx, h - 11),
        color: const Color(0xFF92400E),
      );
      return;
    }

    if (family == 'operations') {
      // 3 Cajas visuales que se unen hacia un cofre de resultado
      const groups = 3;
      for (int g = 0; g < groups; g++) {
        final gx = 28.0 + g * 68.0;
        const gy = 22.0;
        final box = RRect.fromRectAndRadius(
          Rect.fromLTWH(gx, gy, 54, 48),
          const Radius.circular(10),
        );
        canvas.drawRRect(
          box,
          Paint()
            ..color = phase >= 1
                ? const Color(0xFFEDE9FE)
                : Colors.white,
        );
        canvas.drawRRect(
          box,
          Paint()
            ..color = const Color(0xFF7C3AED)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
        // 4 bolitas dentro de cada caja
        for (int d = 0; d < 4; d++) {
          final dx = gx + 16 + (d % 2) * 20;
          final dy = gy + 15 + (d ~/ 2) * 18;
          canvas.drawCircle(
            Offset(dx, dy),
            6,
            Paint()..color = const Color(0xFFEC4899),
          );
        }
      }
      if (phase >= 1) {
        _drawLabel(
          canvas,
          phase == 1 ? '4 + 4 + 4  →  3 × 4' : '🎉 ¡3 grupos de 4 = 12 en total!',
          Offset(w / 2, h - 18),
          color: const Color(0xFF5B21B6),
        );
      } else {
        _drawLabel(
          canvas,
          '3 cajas con 4 fichas en cada una',
          Offset(w / 2, h - 18),
          color: const Color(0xFF5B21B6),
        );
      }
      return;
    }

    // Por defecto: 'numbers' — 10 unidades que se agrupan en 1 decena y 1 centena
    final boxPaint = Paint()..color = const Color(0xFF10B981);
    if (phase == 0) {
      for (int i = 0; i < 10; i++) {
        final x = 28.0 + (i % 5) * 26.0;
        final y = 24.0 + (i ~/ 5) * 26.0;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, 20, 20),
            const Radius.circular(5),
          ),
          boxPaint,
        );
      }
      _drawLabel(
        canvas,
        '10 Unidades sueltas (10 fichitas de 1)',
        Offset(w / 2, h - 15),
        color: const Color(0xFF1D4ED8),
      );
    } else if (phase == 1) {
      for (int i = 0; i < 10; i++) {
        final x = 22.0 + i * 14.0;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, 36, 13, 28),
            const Radius.circular(4),
          ),
          Paint()..color = const Color(0xFF2563EB),
        );
      }
      _drawLabel(
        canvas,
        '¡Se pegan las 10 unidades formando 1 barra!',
        Offset(w / 2, h - 15),
        color: const Color(0xFF1D4ED8),
      );
    } else {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w / 2 - 70, 24, 140, 44),
          const Radius.circular(10),
        ),
        Paint()..color = const Color(0xFF7C3AED),
      );
      _drawLabel(
        canvas,
        '1 Decena = 10 U  ·  10 Decenas = 1 Centena (100)',
        Offset(w / 2, 46),
        color: Colors.white,
      );
      _drawLabel(
        canvas,
        '¡Cada casilla a la izquierda vale ×10!',
        Offset(w / 2, h - 15),
        color: const Color(0xFF5B21B6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ExplanationConceptScenePainter old) =>
      old.family != family ||
      old.phase != phase ||
      old.accentColor != accentColor ||
      old.topicOrder != topicOrder;
}

class _ConceptBuilderCanvasPainter extends CustomPainter {
  final String family;
  final List<int> pieces;
  final int currentTotal;
  final int targetValue;
  final String unitName;

  _ConceptBuilderCanvasPainter({
    required this.family,
    required this.pieces,
    required this.currentTotal,
    required this.targetValue,
    required this.unitName,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final ratio =
        targetValue > 0 ? (currentTotal / targetValue).clamp(0.0, 1.2) : 0.0;

    // Fondo de cuadrícula de construcción
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1;
    for (double x = 0; x <= w; x += 22) {
      canvas.drawLine(Offset(x, 0), Offset(x, h), gridPaint);
    }
    for (double y = 0; y <= h; y += 22) {
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    // Barra lateral derecha de progreso hacia la meta
    final meterRect = Rect.fromLTWH(w - 42, 12, 26, h - 24);
    canvas.drawRRect(
      RRect.fromRectAndRadius(meterRect, const Radius.circular(8)),
      Paint()..color = Colors.white,
    );
    final fillH = (meterRect.height * ratio.clamp(0.0, 1.0));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          meterRect.left,
          meterRect.bottom - fillH,
          meterRect.width,
          fillH,
        ),
        const Radius.circular(8),
      ),
      Paint()
        ..color = currentTotal == targetValue
            ? const Color(0xFF10B981)
            : currentTotal > targetValue
                ? const Color(0xFFF59E0B)
                : const Color(0xFF0D9488),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(meterRect, const Radius.circular(8)),
      Paint()
        ..color = const Color(0xFF0F766E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );

    // Dibujar cada pieza agregada por el niño como bloques gráficos en el lienzo
    final colors = [
      const Color(0xFF7C3AED),
      const Color(0xFF2563EB),
      const Color(0xFF10B981),
      const Color(0xFFEA580C),
      const Color(0xFFEC4899),
    ];

    for (int i = 0; i < pieces.length; i++) {
      final col = i % 6;
      final row = i ~/ 6;
      final bx = 14.0 + col * 42.0;
      final by = 14.0 + row * 34.0;
      final pieceColor = colors[i % colors.length];
      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(bx, by, 36, 28),
        const Radius.circular(8),
      );
      canvas.drawRRect(rrect, Paint()..color = pieceColor);

      final tp = TextPainter(
        text: TextSpan(
          text: '+${pieces[i]}',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 10.5,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(bx + 18 - tp.width / 2, by + 14 - tp.height / 2));
    }

    // Texto guía en la base del lienzo
    final statusText = pieces.isEmpty
        ? '👆 Toca los botones de abajo (o toca este lienzo) para empezar a armar'
        : 'Construido: $currentTotal / Meta: $targetValue $unitName';
    final statusTp = TextPainter(
      text: TextSpan(
        text: statusText,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 11.5,
          fontWeight: FontWeight.w900,
          color: Color(0xFF0F172A),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    statusTp.paint(canvas, Offset(14, h - 22));
  }

  @override
  bool shouldRepaint(covariant _ConceptBuilderCanvasPainter old) =>
      old.currentTotal != currentTotal ||
      old.targetValue != targetValue ||
      old.pieces.length != pieces.length ||
      old.family != family;
}

// ─── Modelos de Datos para la Zona de Preparación ───────────────────────────

class _DraggableBoardItem {
  final String id;
  final String emoji;
  final String label;
  final int numericValue;
  final Color color;
  final Offset position;

  const _DraggableBoardItem({
    required this.id,
    required this.emoji,
    required this.label,
    required this.numericValue,
    required this.color,
    required this.position,
  });

  _DraggableBoardItem copyWith({Offset? position}) {
    return _DraggableBoardItem(
      id: id,
      emoji: emoji,
      label: label,
      numericValue: numericValue,
      color: color,
      position: position ?? this.position,
    );
  }
}

class _BoardPreset {
  final String emoji;
  final String label;
  final int numericValue;
  final Color color;

  const _BoardPreset(this.emoji, this.label, this.numericValue, this.color);
}

class _TableRowData {
  final String emoji;
  final String col1;
  final String col2;
  final String col3;
  final String kidExplanation;

  const _TableRowData({
    required this.emoji,
    required this.col1,
    required this.col2,
    required this.col3,
    required this.kidExplanation,
  });
}

class _LessonPrepExplanation {
  final String storyExplanation;
  final String exampleEmoji;
  final String stepByStepExample;
  final String visualPrompt;
  final String secretTrick;

  const _LessonPrepExplanation({
    required this.storyExplanation,
    required this.exampleEmoji,
    required this.stepByStepExample,
    required this.visualPrompt,
    required this.secretTrick,
  });
}

class _UnitPrepSpec {
  final String mascotName;
  final String mascotRole;
  final Color accentColor;
  final List<String> mascotSpeeches;
  final List<_LessonPrepExplanation> lessonExplanations;
  final String sandboxTargetLabel;
  final List<_BoardPreset> boardPresets;
  final String Function(int count, int totalValue) sandboxSummaryBuilder;
  final String tableTitle;
  final (String, String, String) tableColumnsHeader;
  final List<_TableRowData> tableRows;

  const _UnitPrepSpec({
    required this.mascotName,
    required this.mascotRole,
    required this.accentColor,
    required this.mascotSpeeches,
    required this.lessonExplanations,
    required this.sandboxTargetLabel,
    required this.boardPresets,
    required this.sandboxSummaryBuilder,
    required this.tableTitle,
    required this.tableColumnsHeader,
    required this.tableRows,
  });
}

// ─── Generador de Contenido Pedagógico para las 39 Unidades (1° a 5°) ───────

_UnitPrepSpec _buildUnitSpec(String unitId, int grade) {
  final mascot = switch (grade) {
    1 => ('🦁 Lumi el Leoncito Explorador', 'Tu amigo guía de 1° de primaria'),
    2 => ('🦁 Lumi el Leoncito Constructor', 'Tu maestro de bloques de 2°'),
    3 => ('🦁 Lumi el Leoncito Aventurero', 'Tu compañero de retos de 3°'),
    4 => ('🦁 Capitán Lumi el Leoncito', 'Tu guía de la Aventura de 4°'),
    _ => ('🦁 Profesor Lumi el Leoncito', 'Tu mentor científico de 5°'),
  };

  final title = CurriculumData.unitTitles[unitId] ?? 'Unidad de Matemáticas';
  final lower = title.toLowerCase();
  final lessons = CurriculumData.getLessonsForUnit(unitId);

  // Clasificar la familia temática de la unidad para darle tablitas, fichas y explicaciones a medida
  if (lower.contains('número') ||
      lower.contains('enteros') ||
      unitId == 'unit-001' ||
      unitId == 'unit-201' ||
      unitId == 'unit-301' ||
      unitId == 'unit-404' ||
      unitId == 'unit-501') {
    final isNegatives = unitId == 'unit-501';
    final scale = grade == 1
        ? 10
        : grade == 2
            ? 100
            : grade == 3
                ? 1000
                : 100000;
    return _UnitPrepSpec(
      mascotName: mascot.$1,
      mascotRole: mascot.$2,
      accentColor: const Color(0xFF2563EB),
      mascotSpeeches: [
        isNegatives
            ? '¡Hola! En 5° descubrimos los números bajo cero (−). Imagina un ascensor con sótanos o un termómetro en el nevado del Ruiz 🏔️.'
            : '¡Hola! Los números se organizan en casillas como casitas: Unidades (1), Decenas (10), Centenas (100) y Miles 🏠.',
        '¡Cada vez que juntas 10 fichas en una casilla, se transforman en 1 ficha de la casilla de la izquierda! ✨',
        'En la Mesa Interactiva de abajo puedes arrastrar bloques de números para armar cantidades gigantes.',
      ],
      lessonExplanations: List.generate(math.max(lessons.length, 5), (i) {
        final lTitle = i < lessons.length ? lessons[i].title : title;
        if (isNegatives) {
          return _LessonPrepExplanation(
            storyExplanation:
                'En «$lTitle» aprendemos que el 0 es el punto de partida. A la derecha están los positivos (+) como cuando hace calor, y a la izquierda los negativos (−) como bajo el nivel del mar.',
            exampleEmoji: '🌡️',
            stepByStepExample:
                'Si estás en −3 °C y la temperatura sube 5 grados, das 5 saltos a la derecha y llegas a +2 °C.',
            visualPrompt: 'En la recta numérica, empieza en -3 y avanza 5',
            secretTrick:
                '¡Entre dos números negativos, es MAYOR el que está más cerquita del 0!',
          );
        }
        return _LessonPrepExplanation(
          storyExplanation:
              'En «$lTitle» aprendemos cómo leer, escribir y comparar números según el lugar donde vive cada dígito. ¡Un mismo número vale distinto según su casilla!',
          exampleEmoji: '🧮',
          stepByStepExample: grade <= 2
              ? 'En el número 347: el 3 vale 300 (3 centenas), el 4 vale 40 (4 decenas) y el 7 vale 7 unidades.'
              : 'En el número 45.320: mira de izquierda a derecha cada casilla para saber su valor o redondearlo.',
          visualPrompt: grade == 1
              ? 'En el número 48, ¿cuántas decenas y unidades hay?'
              : grade == 2
                  ? 'En el número 537, ¿cuánto vale el dígito 5?'
                  : grade == 3
                      ? 'En el número 24.500, ¿cuántas decenas de mil hay?'
                      : 'En el número 648.320, ¿qué valor representa el dígito 6?',
          secretTrick:
              '¡Mira primero la casilla de más a la izquierda: esa es la que manda al comparar dos números!',
        );
      }),
      sandboxTargetLabel:
          isNegatives ? 'Zona de Equilibrio' : 'Caja Armadora de Números',
      boardPresets: isNegatives
          ? const [
              _BoardPreset('❄️', '-10', -10, Color(0xFF3B82F6)),
              _BoardPreset('❄️', '-5', -5, Color(0xFF0284C7)),
              _BoardPreset('❄️', '-1', -1, Color(0xFF06B6D4)),
              _BoardPreset('☀️', '+1', 1, Color(0xFFF59E0B)),
              _BoardPreset('☀️', '+5', 5, Color(0xFFEA580C)),
              _BoardPreset('☀️', '+10', 10, Color(0xFFEF4444)),
            ]
          : [
              _BoardPreset('🟪', '+$scale', scale, const Color(0xFF7C3AED)),
              _BoardPreset('🟪', '+$scale', scale, const Color(0xFF7C3AED)),
              _BoardPreset(
                '🟦',
                '+${math.max(1, scale ~/ 10)}',
                math.max(1, scale ~/ 10),
                const Color(0xFF2563EB),
              ),
              _BoardPreset(
                '🟦',
                '+${math.max(1, scale ~/ 10)}',
                math.max(1, scale ~/ 10),
                const Color(0xFF2563EB),
              ),
              const _BoardPreset('🟩', '+1', 1, Color(0xFF10B981)),
              const _BoardPreset('🟩', '+1', 1, Color(0xFF10B981)),
            ],
      sandboxSummaryBuilder: (count, total) =>
          'Suma total dentro de la caja = $total',
      tableTitle: isNegatives
          ? 'Tablita de Enteros Positivos y Negativos'
          : 'Tablita Mágica de Valor Posicional',
      tableColumnsHeader: ('Posición / Símbolo', 'Valor en Unidades', 'Ejemplo'),
      tableRows: isNegatives
          ? const [
              _TableRowData(
                emoji: '🏔️',
                col1: 'Positivos (+)',
                col2: 'Mayores que 0',
                col3: '+5, +12, +100',
                kidExplanation:
                    'Están a la derecha del 0: representan ganancias, pisos hacia arriba o calor.',
              ),
              _TableRowData(
                emoji: '⚓',
                col1: 'Cero (0)',
                col2: 'Punto neutro',
                col3: '0 (nivel del mar)',
                kidExplanation:
                    'El 0 separa los positivos de los negativos. ¡No es positivo ni negativo!',
              ),
              _TableRowData(
                emoji: '🤿',
                col1: 'Negativos (−)',
                col2: 'Menores que 0',
                col3: '−3, −10, −25',
                kidExplanation:
                    'Están a la izquierda del 0: representan frío bajo cero, sótanos o deudas.',
              ),
            ]
          : const [
              _TableRowData(
                emoji: '🟩',
                col1: 'Unidad (U)',
                col2: 'Vale 1',
                col3: '7 U = 7',
                kidExplanation:
                    'Es una fichita suelta. Cuando juntas 10 unidades, formas 1 decena.',
              ),
              _TableRowData(
                emoji: '🟦',
                col1: 'Decena (D)',
                col2: 'Vale 10',
                col3: '4 D = 40',
                kidExplanation:
                    'Es un paquete de 10 unidades. ¡Contamos de 10 en 10: 10, 20, 30, 40...!',
              ),
              _TableRowData(
                emoji: '🟪',
                col1: 'Centena (C)',
                col2: 'Vale 100',
                col3: '5 C = 500',
                kidExplanation:
                    'Son 10 decenas juntas (100 unidades). ¡Como una caja grande de 100 fichas!',
              ),
              _TableRowData(
                emoji: '🟧',
                col1: 'Unidad de Mil (UM)',
                col2: 'Vale 1.000',
                col3: '3 UM = 3.000',
                kidExplanation:
                    'Son 10 centenas juntas. Se escribe con un puntico de mil: 1.000.',
              ),
              _TableRowData(
                emoji: '🟥',
                col1: 'Centena de Mil / Millón',
                col2: '100.000 / 1.000.000',
                col3: '6 CM = 600.000',
                kidExplanation:
                    'Para números gigantes como los habitantes de las ciudades de Colombia.',
              ),
            ],
    );
  }

  // 2. Unidades de Suma, Resta, Multiplicación y División
  if (lower.contains('suma') ||
      lower.contains('resta') ||
      lower.contains('tabla') ||
      lower.contains('multiplic') ||
      lower.contains('divisi') ||
      lower.contains('secuencia') ||
      lower.contains('patrones')) {
    final isMultDiv = lower.contains('tabla') ||
        lower.contains('multiplic') ||
        lower.contains('divisi');
    return _UnitPrepSpec(
      mascotName: mascot.$1,
      mascotRole: mascot.$2,
      accentColor: const Color(0xFF7C3AED),
      mascotSpeeches: [
        isMultDiv
            ? '¡Multiplicar es un súper poder para no sumar uno por uno! ⚡ Y dividir es repartir un tesoro en partes iguales.'
            : '¡Sumar es juntar cosas para tener más, y restar es quitar o descubrir cuánto falta! 🌟',
        'Arrastra las fichas en la Mesa Interactiva para armar grupos iguales y ver cuánto suman.',
        'Toca cada fila de la Tablita Mágica abajo para descubrir los trucos secretos de las operaciones.',
      ],
      lessonExplanations: List.generate(math.max(lessons.length, 5), (i) {
        final lTitle = i < lessons.length ? lessons[i].title : title;
        return _LessonPrepExplanation(
          storyExplanation: isMultDiv
              ? 'En «$lTitle» usamos grupos iguales: por ejemplo, 4 cajas con 6 colores cada una es 4 × 6 = 24. Y si repartimos 24 colores entre 4 amigos, a cada uno le tocan 6.'
              : 'En «$lTitle» aprendemos a operar paso a paso empezando siempre por las unidades (la derecha) y luego las decenas.',
          exampleEmoji: isMultDiv ? '🎁' : '🧮',
          stepByStepExample: isMultDiv
              ? 'Truco: Para multiplicar 12 × 3, multiplica primero 10 × 3 = 30, luego 2 × 3 = 6, y súmalos: 30 + 6 = 36.'
              : 'Si tienes 28 + 15: suma 8 + 5 = 13 (pones el 3 y llevas 1 decena). Luego 2 + 1 + 1 = 4 → ¡Da 43!',
          visualPrompt:
              isMultDiv ? '¿Cuánto es 6 × 4?' : '¿Cuánto es 28 + 15?',
          secretTrick: isMultDiv
              ? '¡El orden de los factores no cambia el resultado: 3 × 8 da lo mismo que 8 × 3!'
              : '¡Empieza siempre por la columna de las Unidades!',
        );
      }),
      sandboxTargetLabel:
          isMultDiv ? 'Zona de Grupos Iguales' : 'Canasta de Operaciones',
      boardPresets: isMultDiv
          ? const [
              _BoardPreset('🍓', 'Grupo ×2', 2, Color(0xFFEC4899)),
              _BoardPreset('🍓', 'Grupo ×2', 2, Color(0xFFEC4899)),
              _BoardPreset('🍊', 'Grupo ×3', 3, Color(0xFFF59E0B)),
              _BoardPreset('🍊', 'Grupo ×3', 3, Color(0xFFF59E0B)),
              _BoardPreset('🍇', 'Grupo ×5', 5, Color(0xFF8B5CF6)),
              _BoardPreset('🍇', 'Grupo ×5', 5, Color(0xFF8B5CF6)),
            ]
          : const [
              _BoardPreset('🍎', '+5', 5, Color(0xFFEF4444)),
              _BoardPreset('🍎', '+5', 5, Color(0xFFEF4444)),
              _BoardPreset('🍐', '+10', 10, Color(0xFF10B981)),
              _BoardPreset('🍐', '+10', 10, Color(0xFF10B981)),
              _BoardPreset('🍋', '+2', 2, Color(0xFFF59E0B)),
              _BoardPreset('🍋', '+3', 3, Color(0xFFF59E0B)),
            ],
      sandboxSummaryBuilder: (count, total) =>
          'En la canasta juntaste $count grupos = $total en total',
      tableTitle: isMultDiv
          ? 'Tablita Mágica de Multiplicación y División'
          : 'Tablita de Estrategias de Suma y Resta',
      tableColumnsHeader: ('Truco / Tabla', 'Cómo funciona', 'Ejemplo'),
      tableRows: isMultDiv
          ? const [
              _TableRowData(
                emoji: '✌️',
                col1: 'Tabla del 2',
                col2: 'El doble (suma igual)',
                col3: '2 × 7 = 14',
                kidExplanation:
                    'Multiplicar por 2 es sumar el número consigo mismo: 7 + 7 = 14.',
              ),
              _TableRowData(
                emoji: '🖐️',
                col1: 'Tabla del 5',
                col2: 'Termina en 0 o en 5',
                col3: '5 × 6 = 30',
                kidExplanation:
                    'Cuenta de 5 en 5 como los minutos del reloj: 5, 10, 15, 20, 25, 30.',
              ),
              _TableRowData(
                emoji: '🙌',
                col1: 'Tabla del 9',
                col2: 'Sus cifras suman 9',
                col3: '9 × 4 = 36 (3+6=9)',
                kidExplanation:
                    'En la tabla del 9, las decenas suben (0, 1, 2, 3...) y las unidades bajan (9, 8, 7, 6...).',
              ),
              _TableRowData(
                emoji: '🚀',
                col1: 'Por 10 o por 100',
                col2: 'Agrega ceros al final',
                col3: '15 × 10 = 150',
                kidExplanation:
                    'Para multiplicar por 10 solo pon un 0 a la derecha; por 100 pon dos ceros (00).',
              ),
              _TableRowData(
                emoji: '🍬',
                col1: 'Dividir (÷)',
                col2: 'Operación inversa',
                col3: '24 ÷ 6 = 4',
                kidExplanation:
                    'Pregúntate al revés: ¿qué número multiplicado por 6 da 24? ¡Es el 4!',
              ),
            ]
          : const [
              _TableRowData(
                emoji: '➕',
                col1: 'Amigos del 10',
                col2: 'Parejas que suman 10',
                col3: '7 + 3 = 10 · 8 + 2 = 10',
                kidExplanation:
                    'Si memorizas las parejas que dan 10, podrás sumar cualquier número rapidísimo.',
              ),
              _TableRowData(
                emoji: '🎒',
                col1: 'Suma llevando',
                col2: '10 U forman 1 D',
                col3: '18 + 7 → 8+7=15 (llevo 1)',
                kidExplanation:
                    'Cuando las unidades pasan de 9, dejas las unidades sueltas y subes 1 decena.',
              ),
              _TableRowData(
                emoji: '🎁',
                col1: 'Resta prestando',
                col2: '1 D se abre en 10 U',
                col3: '42 − 15 → 12 − 5 = 7',
                kidExplanation:
                    'Si al de arriba no le alcanza, el vecino de las decenas le presta 10 unidades.',
              ),
            ],
    );
  }

  // 3. Unidades de Fracciones, Decimales, Porcentajes y Razones
  if (lower.contains('fracci') ||
      lower.contains('decimal') ||
      lower.contains('porcentaje') ||
      lower.contains('razones')) {
    return _UnitPrepSpec(
      mascotName: mascot.$1,
      mascotRole: mascot.$2,
      accentColor: const Color(0xFFEA580C),
      mascotSpeeches: [
        '¡Las fracciones, los decimales y los porcentajes son 3 formas de contar partes de un mismo todo! 🍕',
        'Imagina una pizza o una chocolatina partida en pedazos exactamente iguales.',
        'En la Mesa Interactiva puedes arrastrar pedazos hacia el plato para armar tu propia fracción o porcentaje.',
      ],
      lessonExplanations: List.generate(math.max(lessons.length, 5), (i) {
        final lTitle = i < lessons.length ? lessons[i].title : title;
        return _LessonPrepExplanation(
          storyExplanation:
              'En «$lTitle» aprendemos a representar partes de una unidad completa. El número de abajo (denominador) dice en cuántas partes iguales se cortó, y el de arriba (numerador) cuántas tomamos.',
          exampleEmoji: '🍕',
          stepByStepExample:
              'Si cortas una pizza en 4 partes iguales y te comes 2, comiste 2/4, que es exactamente la mitad (1/2 = 0,5 = 50%).',
          visualPrompt: lower.contains('porcentaje')
              ? '¿Cuánto es el 50% de 100?'
              : '¿Qué fracción representa 3/4 de la pizza?',
          secretTrick:
              '¡Entre más pedazos cortes de la misma pizza, cada pedacito individual será más pequeño!',
        );
      }),
      sandboxTargetLabel: 'Plato de Partes (Suma de porciones)',
      boardPresets: const [
        _BoardPreset('🍕', '1 cuarto (25%)', 25, Color(0xFFEA580C)),
        _BoardPreset('🍕', '1 cuarto (25%)', 25, Color(0xFFEA580C)),
        _BoardPreset('🍕', '1 cuarto (25%)', 25, Color(0xFFEA580C)),
        _BoardPreset('🍕', '1 cuarto (25%)', 25, Color(0xFFEA580C)),
        _BoardPreset('🍫', '1 décimo (10%)', 10, Color(0xFF8B5CF6)),
        _BoardPreset('🍫', '1 décimo (10%)', 10, Color(0xFF8B5CF6)),
      ],
      sandboxSummaryBuilder: (count, total) =>
          'Tienes $total% de una unidad completa ($count porciones)',
      tableTitle: 'Tablita de Fracciones, Decimales y Porcentajes',
      tableColumnsHeader: ('Fracción', 'En Decimal', 'En Porcentaje'),
      tableRows: const [
        _TableRowData(
          emoji: '🌗',
          col1: '1/2 (Un medio)',
          col2: '0,5',
          col3: '50% (La mitad)',
          kidExplanation:
              'Partir algo en 2 partes iguales y tomar 1. ¡Para hallar el 50% solo divide entre 2!',
        ),
        _TableRowData(
          emoji: '🍕',
          col1: '1/4 (Un cuarto)',
          col2: '0,25',
          col3: '25% (Cuarta parte)',
          kidExplanation:
              'La mitad de la mitad. 4 cuartos (4/4) arman la pizza entera (100%).',
        ),
        _TableRowData(
          emoji: '🍰',
          col1: '3/4 (Tres cuartos)',
          col2: '0,75',
          col3: '75%',
          kidExplanation:
              'Son 3 pedazos de 4: es decir, 25% + 25% + 25% = 75%.',
        ),
        _TableRowData(
          emoji: '🍫',
          col1: '1/10 (Un décimo)',
          col2: '0,1',
          col3: '10%',
          kidExplanation:
              '1 parte de 10 iguales. ¡Para calcular el 10% de un precio solo quítale un cero!',
        ),
        _TableRowData(
          emoji: '🌕',
          col1: '4/4 o 10/10',
          col2: '1,0',
          col3: '100% (El todo)',
          kidExplanation:
              'Cuando el número de arriba y el de abajo son iguales, tienes la unidad completa.',
        ),
      ],
    );
  }

  // 4. Unidades de Geometría, Medición, Reloj, Coordenadas y Volumen
  if (lower.contains('ubicación') ||
      lower.contains('medición') ||
      lower.contains('figuras') ||
      lower.contains('tiempo') ||
      lower.contains('reloj') ||
      lower.contains('regla') ||
      lower.contains('cuerpos') ||
      lower.contains('perímetro') ||
      lower.contains('área') ||
      lower.contains('mapas') ||
      lower.contains('volumen') ||
      lower.contains('circunferencia')) {
    return _UnitPrepSpec(
      mascotName: mascot.$1,
      mascotRole: mascot.$2,
      accentColor: const Color(0xFF0D9488),
      mascotSpeeches: [
        '¡La geometría y las medidas están en todo lo que nos rodea: canchas de fútbol, relojes, cajas y bicicletas! 📐',
        'Recuerda: el PERÍMETRO es el borde de afuera (como una cerca) y el ÁREA es el piso de adentro.',
        'Mueve y acomoda las figuras en la Mesa Interactiva de abajo para explorar sus lados y medidas.',
      ],
      lessonExplanations: List.generate(math.max(lessons.length, 5), (i) {
        final lTitle = i < lessons.length ? lessons[i].title : title;
        return _LessonPrepExplanation(
          storyExplanation:
              'En «$lTitle» aprendemos a observar las formas, medir longitudes, superficies, ángulos o el tiempo con precisión.',
          exampleEmoji: '📐',
          stepByStepExample: lower.contains('reloj') || lower.contains('tiempo')
              ? 'En el reloj: cuando la aguja larga apunta al 12 es la hora "en punto"; cuando apunta al 6 son las "y media" (30 minutos).'
              : lower.contains('volumen')
                  ? 'Una caja de 4 cm de largo, 3 cm de ancho y 2 cm de alto tiene un volumen de 4 × 3 × 2 = 24 cm³.'
                  : 'Un rectángulo de 6 cm de base y 4 cm de altura tiene Perímetro = 6+4+6+4 = 20 cm, y Área = 6 × 4 = 24 cm².',
          visualPrompt: lower.contains('reloj') || lower.contains('tiempo')
              ? '¿Qué hora marca el reloj a las 3:30?'
              : lower.contains('ángulo')
                  ? '¿Cómo es un ángulo de 90°?'
                  : lower.contains('circunferencia')
                      ? '¿Cuánto mide el diámetro si el radio es 5 cm?'
                      : lower.contains('volumen') || lower.contains('cuerpos')
                          ? '¿Cuál es el volumen de un cubo de 3 cm?'
                          : lower.contains('mapa') || lower.contains('ubicación')
                              ? 'Ubica la coordenada (3, 2) en el plano cartesiano'
                              : 'Calcula el área y perímetro de un rectángulo de 5 cm por 4 cm',
          secretTrick:
              '¡Fíjate siempre en las unidades: cm es borde (longitud), cm² es piso (área) y cm³ es caja rellena (volumen)!',
        );
      }),
      sandboxTargetLabel: 'Zona de Construcción Geométrica',
      boardPresets: const [
        _BoardPreset('🔺', 'Triángulo (3)', 3, Color(0xFFEF4444)),
        _BoardPreset('🟦', 'Cuadrado (4)', 4, Color(0xFF2563EB)),
        _BoardPreset('🟩', 'Rectángulo (4)', 4, Color(0xFF10B981)),
        _BoardPreset('⬠', 'Pentágono (5)', 5, Color(0xFF8B5CF6)),
        _BoardPreset('📏', 'Regla 10 cm', 10, Color(0xFFF59E0B)),
        _BoardPreset('🧊', 'Cubo 6 caras', 6, Color(0xFF0D9488)),
      ],
      sandboxSummaryBuilder: (count, total) =>
          'Suma de lados/unidades de las figuras acomodadas = $total',
      tableTitle: 'Tablita de Figuras, Fórmulas y Equivalencias',
      tableColumnsHeader: ('Concepto / Figura', 'Regla Mágica', 'Equivalencia'),
      tableRows: const [
        _TableRowData(
          emoji: '🏡',
          col1: 'Perímetro',
          col2: 'Suma de todos los lados',
          col3: 'Borde exterior (cm, m)',
          kidExplanation:
              'Imagina que caminas por toda la línea del borde de una cancha y sumas cada lado.',
        ),
        _TableRowData(
          emoji: '🌱',
          col1: 'Área (Superficie)',
          col2: 'Base × Altura',
          col3: 'Cuadritos adentro (cm², m²)',
          kidExplanation:
              'En el triángulo es (Base × Altura) ÷ 2 porque un triángulo es la mitad de un rectángulo.',
        ),
        _TableRowData(
          emoji: '📐',
          col1: 'Ángulos',
          col2: 'Agudo < 90° · Recto = 90°',
          col3: 'Obtuso > 90° · Llano = 180°',
          kidExplanation:
              'La esquina de una hoja de cuaderno mide exactamente 90° (ángulo recto).',
        ),
        _TableRowData(
          emoji: '📏',
          col1: 'Medidas y Reloj',
          col2: '1 m = 100 cm · 1 km = 1.000 m',
          col3: '1 hora = 60 minutos',
          kidExplanation:
              '1 litro tiene 1.000 mililitros y 1 kilogramo tiene 1.000 gramos.',
        ),
        _TableRowData(
          emoji: '🚲',
          col1: 'Círculo y Volumen',
          col2: 'Diámetro = 2 × Radio',
          col3: 'Volumen = Largo×Ancho×Alto',
          kidExplanation:
              'El borde del círculo (circunferencia) mide aproximadamente 3,14 (π) veces su diámetro.',
        ),
      ],
    );
  }

  // 5. Unidades de Estadística, Probabilidad y Álgebra
  final isAlgebra = lower.contains('álgebra') || unitId == 'unit-508';
  return _UnitPrepSpec(
    mascotName: mascot.$1,
    mascotRole: mascot.$2,
    accentColor: const Color(0xFFD97706),
    mascotSpeeches: [
      isAlgebra
          ? '¡En álgebra jugamos a ser detectives! 🕵️‍♂️ La letra x es un número misterioso que descubrimos equilibrando la balanza.'
          : '¡Las tablas, pictogramas y gráficas de barras convierten muchos datos sueltos en dibujos súper fáciles de leer! 📊',
      'Arrastra las fichas en la Mesa Interactiva para organizar tus datos o equilibrar la balanza.',
      'Revisa la Tablita Mágica para no confundir nunca la Moda, la Mediana y el Promedio.',
    ],
    lessonExplanations: List.generate(math.max(lessons.length, 5), (i) {
      final lTitle = i < lessons.length ? lessons[i].title : title;
      return _LessonPrepExplanation(
        storyExplanation: isAlgebra
            ? 'En «$lTitle» usamos una letra (como x o n) para guardar el puesto de un número secreto en una igualdad.'
            : 'En «$lTitle» aprendemos a organizar encuestas, leer gráficas de barras y descubrir qué tan probable es ganar en un juego.',
        exampleEmoji: isAlgebra ? '⚖️' : '📊',
        stepByStepExample: isAlgebra
            ? 'Si x + 4 = 10, quitamos 4 en ambos lados de la balanza: x = 10 − 4 = 6. ¡El número secreto era 6!'
            : 'Si en una encuesta de frutas 8 niños eligen mango, 5 banano y 3 fresa, la barra más alta es Mango (¡esa es la Moda!).',
        visualPrompt: isAlgebra
            ? 'Resuelve la ecuación en la balanza: x + 4 = 10'
            : 'En una gráfica de barras con datos 4, 8, 6 y 5, ¿cuál es la moda?',
        secretTrick: isAlgebra
            ? '¡Para dejar solita la x, haz siempre la operación contraria al otro lado del igual (=)!'
            : '¡La MODA es el dato que más se repite (la barra más alta de la gráfica)!',
      );
    }),
    sandboxTargetLabel:
        isAlgebra ? 'Platillo de la Balanza' : 'Zona de Conteo de Votos',
    boardPresets: isAlgebra
        ? const [
            _BoardPreset('📦', 'x = 5', 5, Color(0xFF7C3AED)),
            _BoardPreset('⚖️', '+3', 3, Color(0xFF2563EB)),
            _BoardPreset('⚖️', '+2', 2, Color(0xFF10B981)),
            _BoardPreset('⚖️', '+4', 4, Color(0xFFF59E0B)),
            _BoardPreset('⚖️', '+1', 1, Color(0xFFEC4899)),
            _BoardPreset('⚖️', '+5', 5, Color(0xFFEF4444)),
          ]
        : const [
            _BoardPreset('⚽', 'Fútbol (4)', 4, Color(0xFF10B981)),
            _BoardPreset('🏀', 'Básquet (3)', 3, Color(0xFFF59E0B)),
            _BoardPreset('🚴', 'Ciclismo (5)', 5, Color(0xFF2563EB)),
            _BoardPreset('🏊', 'Natación (2)', 2, Color(0xFF06B6D4)),
            _BoardPreset('🎲', 'Dado (6)', 6, Color(0xFF8B5CF6)),
            _BoardPreset('🪙', 'Moneda (2)', 2, Color(0xFFEA580C)),
          ],
    sandboxSummaryBuilder: (count, total) =>
        'Total acumulado en la zona = $total puntos ($count fichas)',
    tableTitle: isAlgebra
        ? 'Tablita de Detectives de Ecuaciones (Álgebra)'
        : 'Tablita de Estadística y Probabilidad',
    tableColumnsHeader: ('Concepto', '¿Qué significa?', 'Truco rápido'),
    tableRows: isAlgebra
        ? const [
            _TableRowData(
              emoji: '🎭',
              col1: 'Incógnita (x, n)',
              col2: 'Número desconocido',
              col3: 'x + 3 = 8 → x = 5',
              kidExplanation:
                  'Es como una cajita sorpresa que esconde un número que debemos descubrir.',
            ),
            _TableRowData(
              emoji: '➕',
              col1: 'Si está sumando',
              col2: 'Pasa a restar',
              col3: 'x + 7 = 12 → 12 − 7 = 5',
              kidExplanation:
                  'La operación contraria de sumar (+) es restar (−).',
            ),
            _TableRowData(
              emoji: '✖️',
              col1: 'Si está multiplicando',
              col2: 'Pasa a dividir',
              col3: '3x = 15 → 15 ÷ 3 = 5',
              kidExplanation:
                  '3x significa "3 por x". Para despejarla, divides entre 3.',
            ),
          ]
        : const [
            _TableRowData(
              emoji: '🏆',
              col1: 'La Moda',
              col2: 'El dato que más se repite',
              col3: 'La barra más alta',
              kidExplanation:
                  'Como cuando algo "está de moda": es la respuesta con más votos.',
            ),
            _TableRowData(
              emoji: '🧍',
              col1: 'La Mediana',
              col2: 'El dato del centro',
              col3: 'Ordena de menor a mayor',
              kidExplanation:
                  'En 3, 5, 9: el número que queda justo en la mitad es el 5.',
            ),
            _TableRowData(
              emoji: '🤝',
              col1: 'El Promedio (Media)',
              col2: 'Repartir en partes iguales',
              col3: 'Suma todo ÷ Cantidad',
              kidExplanation:
                  'De 4, 6 y 8: sumas 4+6+8 = 18 y divides entre 3 datos = 6.',
            ),
            _TableRowData(
              emoji: '🎲',
              col1: 'Probabilidad',
              col2: 'Casos a favor / Total',
              col3: 'Moneda: 1/2 · Dado: 1/6',
              kidExplanation:
                  'Seguro = siempre pasa; Posible = puede pasar; Imposible = nunca pasa.',
            ),
          ],
  );
}
