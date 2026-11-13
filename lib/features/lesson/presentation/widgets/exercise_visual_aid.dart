import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

enum _VisualTopic {
  placeValue,
  fraction,
  clock,
  angle,
  circle,
  solid3D,
  polygonAreaPerimeter,
  cartesian,
  statistics,
  measurement,
  percentDecimalMoney,
  algebra,
  numberLineSequence,
  arithmetic,
}

/// Laboratorio visual interactivo + Tip pedagógico que ilustra exactamente
/// los datos de la pregunta y permite al estudiante interactuar con el gráfico.
class ExerciseVisualAid extends StatefulWidget {
  final String questionText;
  final String? hint;
  final List<String> options;
  final bool compact;

  const ExerciseVisualAid({
    super.key,
    required this.questionText,
    this.hint,
    this.options = const [],
    this.compact = false,
  });

  @override
  State<ExerciseVisualAid> createState() => _ExerciseVisualAidState();
}

class _ExerciseVisualAidState extends State<ExerciseVisualAid> {
  late _VisualTopic _topic;

  // Estados interactivos según el tipo de gráfico
  int _selectedPlaceIdx = 1; // 0:M, 1:CM, 2:DM, 3:UM, 4:C, 5:D, 6:U
  int _activeSlices = 1;
  int _totalSlices = 4;
  int _extraMinutes = 0;
  double _interactiveAngle = 90;
  bool _showDiameter = false;
  bool _showAreaGrid = true;
  math.Point<int> _cartesianPoint = const math.Point(3, 2);
  int _selectedBarIdx = 0;
  int _selectedUnitIdx = 0;
  int _selectedPctCells = 5;
  bool _algebraStepRevealed = false;
  int _numberLineStep = 0;
  bool _arithmeticStepRevealed = false;

  @override
  void initState() {
    super.initState();
    _initFromQuestion();
  }

  @override
  void didUpdateWidget(covariant ExerciseVisualAid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionText != widget.questionText) {
      _initFromQuestion();
    }
  }

  void _initFromQuestion() {
    final q = widget.questionText;
    final lower = q.toLowerCase();
    _topic = _detectTopic(q, widget.options);

    // Inicializar estado coherente con los datos reales de la pregunta
    switch (_topic) {
      case _VisualTopic.placeValue:
        if (lower.contains('millón') || lower.contains('millon')) {
          _selectedPlaceIdx = 0;
        } else if (lower.contains('centena de mil') || lower.contains('centenas de mil')) {
          _selectedPlaceIdx = 1;
        } else if (lower.contains('decena de mil') || lower.contains('decenas de mil')) {
          _selectedPlaceIdx = 2;
        } else if (lower.contains('unidad de mil') || lower.contains('unidades de mil') || lower.contains('mil')) {
          _selectedPlaceIdx = 3;
        } else if (lower.contains('centena')) {
          _selectedPlaceIdx = 4;
        } else if (lower.contains('decena')) {
          _selectedPlaceIdx = 5;
        } else {
          _selectedPlaceIdx = 1;
        }

      case _VisualTopic.fraction:
        final parsed = _parseFractionFromQuestion(q);
        _totalSlices = parsed.$2;
        _activeSlices = parsed.$1;

      case _VisualTopic.clock:
        _extraMinutes = 0;

      case _VisualTopic.angle:
        final degMatch = RegExp(r'(\d+)\s*°').firstMatch(q);
        if (degMatch != null) {
          _interactiveAngle =
              (double.tryParse(degMatch.group(1)!) ?? 90).clamp(15, 180);
        } else if (lower.contains('agudo')) {
          _interactiveAngle = 45;
        } else if (lower.contains('obtuso')) {
          _interactiveAngle = 130;
        } else if (lower.contains('llano')) {
          _interactiveAngle = 180;
        } else {
          _interactiveAngle = 90;
        }

      case _VisualTopic.circle:
        _showDiameter = lower.contains('diámetro') || lower.contains('diametro');

      case _VisualTopic.solid3D:
      case _VisualTopic.polygonAreaPerimeter:
        _showAreaGrid = !lower.contains('perímetro') && !lower.contains('perimetro');

      case _VisualTopic.cartesian:
        final ptMatch = RegExp(r'\(\s*(\d+)\s*,\s*(\d+)\s*\)').firstMatch(q);
        if (ptMatch != null) {
          final x = (int.tryParse(ptMatch.group(1)!) ?? 3).clamp(0, 5);
          final y = (int.tryParse(ptMatch.group(2)!) ?? 2).clamp(0, 4);
          _cartesianPoint = math.Point(x, y);
        } else {
          _cartesianPoint = const math.Point(3, 2);
        }

      case _VisualTopic.statistics:
        _selectedBarIdx = 0;

      case _VisualTopic.measurement:
        _selectedUnitIdx = 0;

      case _VisualTopic.percentDecimalMoney:
        final pctMatch = RegExp(r'(\d+)\s*%').firstMatch(q);
        if (pctMatch != null) {
          final pct = (int.tryParse(pctMatch.group(1)!) ?? 50).clamp(10, 100);
          _selectedPctCells = (pct / 10).round().clamp(1, 10);
        } else {
          _selectedPctCells = 5;
        }

      case _VisualTopic.algebra:
        _algebraStepRevealed = false;

      case _VisualTopic.numberLineSequence:
        _numberLineStep = 0;

      case _VisualTopic.arithmetic:
        _arithmeticStepRevealed = false;
    }
  }

  static (int, int) _parseFractionFromQuestion(String q) {
    final lower = q.toLowerCase();
    // 1. Si la pregunta misma contiene una fracción explícita a/b
    final explicit = RegExp(r'(\d+)\s*/\s*(\d+)').firstMatch(q);
    if (explicit != null) {
      final n = int.tryParse(explicit.group(1)!) ?? 1;
      final d = (int.tryParse(explicit.group(2)!) ?? 4).clamp(2, 12);
      return (n.clamp(1, d), d);
    }
    // 2. "divides ... en N partes ... y comes/tomas/sombreas M"
    final partsMatch =
        RegExp(r'(\d+)\s*partes').firstMatch(lower);
    if (partsMatch != null) {
      final d = (int.tryParse(partsMatch.group(1)!) ?? 4).clamp(2, 12);
      final takenMatch =
          RegExp(r'(?:comes|comiste|tomas|sombreo|sombreas|pintan)\s*(\d+)')
              .firstMatch(lower);
      final n = takenMatch != null
          ? (int.tryParse(takenMatch.group(1)!) ?? 1).clamp(1, d)
          : 1;
      return (n, d);
    }
    if (lower.contains('mitad') || lower.contains('medio')) return (1, 2);
    if (lower.contains('tercio') || lower.contains('tercera parte')) return (1, 3);
    if (lower.contains('cuarto') || lower.contains('cuarta parte')) return (1, 4);
    if (lower.contains('quinto') || lower.contains('quinta parte')) return (1, 5);
    return (1, 4);
  }

  static _VisualTopic _detectTopic(String q, List<String> options) {
    final lower = q.toLowerCase();

    // 1. Valor posicional / lectura y escritura de números grandes
    if (lower.contains('centena') ||
        lower.contains('decena') ||
        lower.contains('unidad de mil') ||
        lower.contains('unidades de mil') ||
        lower.contains('millón') ||
        lower.contains('millon') ||
        lower.contains('valor posicional') ||
        lower.contains('dígito') ||
        lower.contains('digito') ||
        lower.contains('redondea') ||
        lower.contains('cómo se escribe') ||
        lower.contains('como se escribe') ||
        lower.contains('cómo se lee')) {
      return _VisualTopic.placeValue;
    }

    // 2. Reloj y tiempo
    if (lower.contains('reloj') ||
        lower.contains('manecilla') ||
        RegExp(r'\b\d{1,2}:\d{2}\b').hasMatch(lower) ||
        lower.contains('en punto') ||
        lower.contains('y media') ||
        lower.contains('minutos tiene') ||
        lower.contains('horas tiene')) {
      return _VisualTopic.clock;
    }

    // 3. Ángulos
    if (lower.contains('ángulo') ||
        lower.contains('angulo') ||
        lower.contains('90°') ||
        lower.contains('180°') ||
        lower.contains('agudo') ||
        lower.contains('obtuso') ||
        lower.contains('llano') ||
        lower.contains('transportador')) {
      return _VisualTopic.angle;
    }

    // 4. Círculo y circunferencia
    if (lower.contains('circunferencia') ||
        lower.contains('círculo') ||
        lower.contains('circulo') ||
        lower.contains('radio') ||
        lower.contains('diámetro') ||
        lower.contains('diametro') ||
        lower.contains('π')) {
      return _VisualTopic.circle;
    }

    // 5. Volumen y sólidos 3D
    if (lower.contains('volumen') ||
        lower.contains('cm³') ||
        lower.contains('cubo') ||
        lower.contains('prisma') ||
        lower.contains('cilindro') ||
        lower.contains('cono') ||
        lower.contains('esfera') ||
        lower.contains('caras')) {
      return _VisualTopic.solid3D;
    }

    // 6. Plano cartesiano y coordenadas / orientación
    if (lower.contains('plano cartesiano') ||
        lower.contains('coordenada') ||
        lower.contains('eje x') ||
        lower.contains('eje y') ||
        RegExp(r'\(\s*\d+\s*,\s*\d+\s*\)').hasMatch(lower) ||
        lower.contains('norte') ||
        lower.contains('derecha') ||
        lower.contains('izquierda')) {
      return _VisualTopic.cartesian;
    }

    // 7. Figuras planas, área y perímetro
    if (lower.contains('perímetro') ||
        lower.contains('perimetro') ||
        lower.contains('área') ||
        lower.contains('area') ||
        lower.contains('cm²') ||
        lower.contains('m²') ||
        lower.contains('triángulo') ||
        lower.contains('triangulo') ||
        lower.contains('rectángulo') ||
        lower.contains('rectangulo') ||
        lower.contains('cuadrado') ||
        lower.contains('pentágono') ||
        lower.contains('hexágono') ||
        lower.contains('vértice') ||
        lower.contains('lados tiene') ||
        lower.contains('simetría')) {
      return _VisualTopic.polygonAreaPerimeter;
    }

    // 8. Fracciones (solo cuando la pregunta trata de fracciones/partes)
    if (RegExp(r'\b\d+\s*/\s*\d+\b').hasMatch(lower) ||
        lower.contains('fracción') ||
        lower.contains('fraccion') ||
        lower.contains('numerador') ||
        lower.contains('denominador') ||
        lower.contains('partes iguales') ||
        lower.contains('mitad') ||
        lower.contains('cuarta parte') ||
        lower.contains('tercera parte') ||
        lower.contains('equivalente')) {
      return _VisualTopic.fraction;
    }

    // 9. Estadística y probabilidad
    if (lower.contains('gráfica') ||
        lower.contains('grafica') ||
        lower.contains('pictograma') ||
        lower.contains('moda') ||
        lower.contains('mediana') ||
        lower.contains('promedio') ||
        lower.contains('media') ||
        lower.contains('frecuencia') ||
        lower.contains('encuesta') ||
        lower.contains('probabilidad') ||
        lower.contains('dado') ||
        lower.contains('ruleta') ||
        lower.contains('bolas')) {
      return _VisualTopic.statistics;
    }

    // 10. Porcentajes, decimales y dinero
    if (lower.contains('%') ||
        lower.contains('porcentaje') ||
        lower.contains('descuento') ||
        lower.contains('decimal') ||
        lower.contains('décima') ||
        lower.contains('centésima') ||
        RegExp(r'\b\d+[.,]\d{1,2}\b').hasMatch(q) &&
            !RegExp(r'\b\d+\.\d{3}\b').hasMatch(q)) {
      return _VisualTopic.percentDecimalMoney;
    }

    // 11. Medición (longitud, masa, capacidad)
    if (lower.contains('regla') ||
        lower.contains('centímetro') ||
        lower.contains('kilómetro') ||
        lower.contains('milímetro') ||
        lower.contains('litro') ||
        lower.contains('mililitro') ||
        lower.contains('kilogramo') ||
        lower.contains('gramo') ||
        RegExp(r'\b\d+\s*(cm|mm|m|km|kg|g|l|ml)\b').hasMatch(lower)) {
      return _VisualTopic.measurement;
    }

    // 12. Álgebra y ecuaciones
    if (lower.contains('ecuación') ||
        lower.contains('ecuacion') ||
        lower.contains('incógnita') ||
        lower.contains('variable') ||
        lower.contains('balanza') ||
        RegExp(r'\b\d*x\s*[+\-=]').hasMatch(lower)) {
      return _VisualTopic.algebra;
    }

    // 13. Recta numérica, enteros negativos y secuencias
    if (lower.contains('negativo') ||
        lower.contains('bajo cero') ||
        lower.contains('°c') ||
        lower.contains('recta') ||
        lower.contains('secuencia') ||
        lower.contains('patrón') ||
        lower.contains('antes del') ||
        lower.contains('después del') ||
        lower.contains('opuesto')) {
      return _VisualTopic.numberLineSequence;
    }

    return _VisualTopic.arithmetic;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTip =
        (widget.hint != null && widget.hint!.trim().isNotEmpty)
            ? widget.hint!.trim()
            : _contextualTip();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Tarjeta Gráfica Interactiva ──────────────────────────────────
        Container(
          padding: EdgeInsets.all(widget.compact ? 10 : 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF0F7FF), Color(0xFFF5F3FF)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: EduPlayColors.primaryBlue.withValues(alpha: 0.22),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Encabezado con badge "Interactivo · Toca para explorar"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _topicTitle(),
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: EduPlayColors.primaryBlue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '👆 Interactivo',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: EduPlayColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildInteractiveVisual(),
            ],
          ),
        ),
        SizedBox(height: widget.compact ? 8 : 10),
        // ── Tip Pedagógico ───────────────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: widget.compact ? 7 : 9,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.45),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('💡', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: widget.compact ? 12 : 13,
                      color: const Color(0xFF92400E),
                      height: 1.3,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Tip: ',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text: effectiveTip,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _topicTitle() {
    return switch (_topic) {
      _VisualTopic.placeValue => '🔢 Tablero de Valor Posicional',
      _VisualTopic.fraction => '🍕 Modelo de Fracciones (Toca las partes)',
      _VisualTopic.clock => '🕒 Reloj Analógico (Toca para avanzar)',
      _VisualTopic.angle => '📐 Transportador de Ángulos',
      _VisualTopic.circle => '⭕ Círculo: Radio y Diámetro',
      _VisualTopic.solid3D => '🧊 Prisma 3D y Volumen',
      _VisualTopic.polygonAreaPerimeter => '📏 Figura Geométrica (Área / Perímetro)',
      _VisualTopic.cartesian => '📍 Plano Cartesiano (Toca un punto)',
      _VisualTopic.statistics => '📊 Gráfica de Datos (Toca las barras)',
      _VisualTopic.measurement => '⚖️ Equivalencias de Medida',
      _VisualTopic.percentDecimalMoney => '💯 Cuadrícula de Porcentaje y Decimal',
      _VisualTopic.algebra => '⚖️ Balanza de Ecuaciones',
      _VisualTopic.numberLineSequence => '🐸 Recta Numérica y Saltos',
      _VisualTopic.arithmetic => '🧮 Descomposición Paso a Paso',
    };
  }

  // ── Constructores de cada gráfico interactivo ─────────────────────────────

  Widget _buildInteractiveVisual() {
    return switch (_topic) {
      _VisualTopic.placeValue => _buildPlaceValueAbacus(),
      _VisualTopic.fraction => _buildInteractiveFraction(),
      _VisualTopic.clock => _buildInteractiveClock(),
      _VisualTopic.angle => _buildInteractiveProtractor(),
      _VisualTopic.circle => _buildInteractiveCircle(),
      _VisualTopic.solid3D => _buildInteractiveSolid3D(),
      _VisualTopic.polygonAreaPerimeter => _buildInteractivePolygon(),
      _VisualTopic.cartesian => _buildInteractiveCartesian(),
      _VisualTopic.statistics => _buildInteractiveChart(),
      _VisualTopic.measurement => _buildInteractiveMeasurement(),
      _VisualTopic.percentDecimalMoney => _buildInteractivePercentBar(),
      _VisualTopic.algebra => _buildInteractiveAlgebra(),
      _VisualTopic.numberLineSequence => _buildInteractiveNumberLine(),
      _VisualTopic.arithmetic => _buildInteractiveArithmetic(),
    };
  }

  // 1. Valor Posicional Interactivo (U, D, C, UM, DM, CM, M)
  Widget _buildPlaceValueAbacus() {
    const columns = [
      ('M', '1.000.000', '1 Millón = 10 CM', Color(0xFFEF4444)),
      ('CM', '100.000', '1 Centena de mil = 100.000 U', Color(0xFFF59E0B)),
      ('DM', '10.000', '1 Decena de mil = 10.000 U', Color(0xFF10B981)),
      ('UM', '1.000', '1 Unidad de mil = 1.000 U', Color(0xFF3B82F6)),
      ('C', '100', '1 Centena = 100 Unidades', Color(0xFF6366F1)),
      ('D', '10', '1 Decena = 10 Unidades', Color(0xFF8B5CF6)),
      ('U', '1', '1 Unidad = valor base 1', Color(0xFF64748B)),
    ];

    final selected = columns[_selectedPlaceIdx];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(columns.length, (i) {
            final col = columns[i];
            final isSel = i == _selectedPlaceIdx;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedPlaceIdx = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: isSel ? col.$4 : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: col.$4,
                      width: isSel ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        col.$1,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: isSel ? Colors.white : col.$4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        col.$2,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: isSel
                              ? Colors.white.withValues(alpha: 0.95)
                              : EduPlayColors.textMedium,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: selected.$4.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '✨ ${selected.$3} (Cada columna vale ×10 la de su derecha)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: selected.$4,
            ),
          ),
        ),
      ],
    );
  }

  // 2. Fracciones Interactivas (Toca la barra o pizza para colorear partes)
  Widget _buildInteractiveFraction() {
    return Column(
      children: [
        Row(
          children: [
            // Pizza circular dibujada en Canvas (tocar suma 1 rebanada)
            GestureDetector(
              onTap: () {
                setState(() {
                  _activeSlices = (_activeSlices % _totalSlices) + 1;
                });
              },
              child: SizedBox(
                width: 68,
                height: 68,
                child: CustomPaint(
                  painter: _InteractivePiePainter(
                    numerator: _activeSlices,
                    denominator: _totalSlices,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Barra fraccionaria interactiva: tocar cualquier celda colorea hasta ahí
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(_totalSlices, (i) {
                      final active = i < _activeSlices;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _activeSlices = i + 1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration: BoxDecoration(
                              color: active
                                  ? const Color(0xFF3B82F6)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFF1E3A8A),
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '1/$_totalSlices',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: _totalSlices > 6 ? 8 : 10,
                                fontWeight: FontWeight.w800,
                                color: active
                                    ? Colors.white
                                    : const Color(0xFF1E3A8A),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Seleccionado: $_activeSlices/$_totalSlices ($_activeSlices de $_totalSlices partes)',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      Row(
                        children: [
                          _MiniChipButton(
                            label: '− partes',
                            onTap: _totalSlices > 2
                                ? () => setState(() {
                                      _totalSlices--;
                                      if (_activeSlices > _totalSlices) {
                                        _activeSlices = _totalSlices;
                                      }
                                    })
                                : null,
                          ),
                          const SizedBox(width: 4),
                          _MiniChipButton(
                            label: '+ partes',
                            onTap: _totalSlices < 10
                                ? () => setState(() => _totalSlices++)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 3. Reloj Analógico Interactivo
  Widget _buildInteractiveClock() {
    final match =
        RegExp(r'(\d{1,2}):(\d{2})').firstMatch(widget.questionText);
    int baseHour = 3;
    int baseMin = 0;
    if (match != null) {
      baseHour = int.tryParse(match.group(1)!) ?? 3;
      baseMin = int.tryParse(match.group(2)!) ?? 0;
    }
    final totalMinutes = baseHour * 60 + baseMin + _extraMinutes;
    final displayHour = ((totalMinutes ~/ 60) % 12 == 0)
        ? 12
        : ((totalMinutes ~/ 60) % 12);
    final displayMin = totalMinutes % 60;

    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _extraMinutes += 15),
          child: SizedBox(
            width: 70,
            height: 70,
            child: CustomPaint(
              painter: _InteractiveClockPainter(
                hour: displayHour,
                minute: displayMin,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hora marcada: $displayHour:${displayMin.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  _MiniChipButton(
                    label: '+15 min',
                    onTap: () => setState(() => _extraMinutes += 15),
                  ),
                  _MiniChipButton(
                    label: '+30 min',
                    onTap: () => setState(() => _extraMinutes += 30),
                  ),
                  _MiniChipButton(
                    label: '+1 hora',
                    onTap: () => setState(() => _extraMinutes += 60),
                  ),
                  if (_extraMinutes != 0)
                    _MiniChipButton(
                      label: 'Reiniciar',
                      onTap: () => setState(() => _extraMinutes = 0),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 4. Transportador de Ángulos Interactivo
  Widget _buildInteractiveProtractor() {
    final classification = _interactiveAngle < 90
        ? 'Agudo (< 90°)'
        : _interactiveAngle == 90
            ? 'Recto (= 90°)'
            : _interactiveAngle < 180
                ? 'Obtuso (> 90°)'
                : 'Llano (= 180°)';

    return Row(
      children: [
        SizedBox(
          width: 92,
          height: 66,
          child: CustomPaint(
            painter: _InteractiveAnglePainter(degrees: _interactiveAngle),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_interactiveAngle.toInt()}° · $classification',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: [
                  for (final deg in [45.0, 90.0, 130.0, 180.0])
                    _MiniChipButton(
                      label: '${deg.toInt()}°',
                      active: _interactiveAngle == deg,
                      onTap: () => setState(() => _interactiveAngle = deg),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 5. Círculo Interactivo (Alternar Radio r vs Diámetro d = 2r)
  Widget _buildInteractiveCircle() {
    final rMatch = RegExp(r'(\d+)\s*cm').firstMatch(widget.questionText);
    final val = rMatch != null ? (int.tryParse(rMatch.group(1)!) ?? 5) : 5;
    final radiusVal = widget.questionText.toLowerCase().contains('diámetro')
        ? val / 2
        : val.toDouble();

    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _showDiameter = !_showDiameter),
          child: SizedBox(
            width: 70,
            height: 70,
            child: CustomPaint(
              painter: _InteractiveCirclePainter(showDiameter: _showDiameter),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _showDiameter
                    ? 'Diámetro (d) = ${ (radiusVal * 2).toStringAsFixed(radiusVal % 1 == 0 ? 0 : 1) } cm (pasa por el centro)'
                    : 'Radio (r) = ${ radiusVal.toStringAsFixed(radiusVal % 1 == 0 ? 0 : 1) } cm (mitad del diámetro)',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _MiniChipButton(
                    label: 'Ver Radio (r)',
                    active: !_showDiameter,
                    onTap: () => setState(() => _showDiameter = false),
                  ),
                  const SizedBox(width: 6),
                  _MiniChipButton(
                    label: 'Ver Diámetro (2r)',
                    active: _showDiameter,
                    onTap: () => setState(() => _showDiameter = true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 6. Sólido 3D Interactivo (Volumen = largo × ancho × alto)
  Widget _buildInteractiveSolid3D() {
    final nums = RegExp(r'\d+')
        .allMatches(widget.questionText)
        .map((m) => int.tryParse(m.group(0)!) ?? 0)
        .where((n) => n > 0 && n <= 30)
        .toList();
    final l = nums.isNotEmpty ? nums[0] : 3;
    final w = nums.length > 1 ? nums[1] : l;
    final h = nums.length > 2 ? nums[2] : l;

    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _showAreaGrid = !_showAreaGrid),
          child: SizedBox(
            width: 74,
            height: 68,
            child: CustomPaint(
              painter: _InteractiveCubePainter(highlightFaces: _showAreaGrid),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _showAreaGrid
                    ? 'Dimensiones: $l × $w × $h → V = ${l * w * h} cm³'
                    : 'Cubo/Prisma: 6 caras · 12 aristas · 8 vértices',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _MiniChipButton(
                    label: 'Ver Volumen',
                    active: _showAreaGrid,
                    onTap: () => setState(() => _showAreaGrid = true),
                  ),
                  const SizedBox(width: 6),
                  _MiniChipButton(
                    label: 'Caras y Vértices',
                    active: !_showAreaGrid,
                    onTap: () => setState(() => _showAreaGrid = false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 7. Polígono Interactivo (Alternar Área vs Perímetro con medidas de la pregunta)
  Widget _buildInteractivePolygon() {
    final lower = widget.questionText.toLowerCase();
    final isTriangle =
        lower.contains('triángulo') || lower.contains('triangulo');
    final nums = RegExp(r'\d+')
        .allMatches(widget.questionText)
        .map((m) => int.tryParse(m.group(0)!) ?? 0)
        .where((n) => n > 0 && n <= 50)
        .toList();
    final b = nums.isNotEmpty ? nums[0] : 5;
    final h = nums.length > 1 ? nums[1] : b;

    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _showAreaGrid = !_showAreaGrid),
          child: SizedBox(
            width: 78,
            height: 66,
            child: CustomPaint(
              painter: _InteractivePolygonPainter(
                isTriangle: isTriangle,
                showGrid: _showAreaGrid,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isTriangle
                    ? (_showAreaGrid
                        ? 'Área triángulo = ($b × $h) ÷ 2 = ${(b * h) / 2}'
                        : 'Triángulo: 3 lados y 3 vértices')
                    : (_showAreaGrid
                        ? 'Área (interior) = $b × $h = ${b * h} unidades²'
                        : 'Perímetro (borde) = $b + $h + $b + $h = ${2 * (b + h)}'),
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _MiniChipButton(
                    label: 'Ver Área (interior)',
                    active: _showAreaGrid,
                    onTap: () => setState(() => _showAreaGrid = true),
                  ),
                  const SizedBox(width: 6),
                  _MiniChipButton(
                    label: 'Ver Perímetro (borde)',
                    active: !_showAreaGrid,
                    onTap: () => setState(() => _showAreaGrid = false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 8. Plano Cartesiano Interactivo (Toca cualquier punto de la cuadrícula)
  Widget _buildInteractiveCartesian() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 72,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                onTapDown: (details) {
                  const left = 18.0;
                  const bottom = 58.0;
                  const stepX = 14.0;
                  const stepY = 12.0;
                  final x = ((details.localPosition.dx - left) / stepX)
                      .round()
                      .clamp(0, 5);
                  final y = ((bottom - details.localPosition.dy) / stepY)
                      .round()
                      .clamp(0, 4);
                  setState(() => _cartesianPoint = math.Point(x, y));
                },
                child: CustomPaint(
                  painter: _InteractiveCartesianPainter(point: _cartesianPoint),
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coordenada actual: (${_cartesianPoint.x}, ${_cartesianPoint.y})',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              Text(
                'Avanza ${_cartesianPoint.x} en X (→) y sube ${_cartesianPoint.y} en Y (↑)',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 11.5,
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

  // 9. Gráfica de Barras Interactiva con datos extraídos de la pregunta
  Widget _buildInteractiveChart() {
    final nums = RegExp(r'\d+')
        .allMatches(widget.questionText)
        .map((m) => int.tryParse(m.group(0)!) ?? 0)
        .where((n) => n > 0 && n <= 100)
        .take(5)
        .toList();
    final values = nums.length >= 2 ? nums : [4, 8, 6, 5];
    final maxVal = values.reduce(math.max);
    final idx = _selectedBarIdx.clamp(0, values.length - 1);

    return Column(
      children: [
        SizedBox(
          height: 54,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(values.length, (i) {
              final v = values[i];
              final isSel = i == idx;
              final h = (v / maxVal * 38).clamp(10.0, 38.0);
              return GestureDetector(
                onTap: () => setState(() => _selectedBarIdx = i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$v',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: isSel
                            ? const Color(0xFF1E3A8A)
                            : EduPlayColors.textMedium,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 26,
                      height: h,
                      decoration: BoxDecoration(
                        color: v == maxVal
                            ? const Color(0xFFF59E0B)
                            : isSel
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF93C5FD),
                        borderRadius: BorderRadius.circular(5),
                        border: isSel
                            ? Border.all(
                                color: const Color(0xFF1E3A8A),
                                width: 1.5,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Barra seleccionada: ${values[idx]} · Mayor frecuencia (Moda): $maxVal',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E3A8A),
          ),
        ),
      ],
    );
  }

  // 10. Convertidor de Unidades Interactivo (Longitud, Masa, Capacidad)
  Widget _buildInteractiveMeasurement() {
    final lower = widget.questionText.toLowerCase();
    final List<(String, String)> pairs;
    if (lower.contains('kg') ||
        lower.contains('kilogramo') ||
        lower.contains('gramo')) {
      pairs = const [
        ('1 kg', '1.000 g'),
        ('1/2 kg', '500 g'),
        ('1/4 kg', '250 g'),
      ];
    } else if (lower.contains('litro') || lower.contains('ml')) {
      pairs = const [
        ('1 L', '1.000 mL'),
        ('1/2 L', '500 mL'),
        ('1/4 L', '250 mL'),
      ];
    } else {
      pairs = const [
        ('1 m', '100 cm'),
        ('1 cm', '10 mm'),
        ('1 km', '1.000 m'),
      ];
    }
    final idx = _selectedUnitIdx % pairs.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(pairs.length, (i) {
            final isSel = i == idx;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _MiniChipButton(
                label: '${pairs[i].$1} = ${pairs[i].$2}',
                active: isSel,
                onTap: () => setState(() => _selectedUnitIdx = i),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          '📏 Equivalencia activa: ${pairs[idx].$1} equivale exactamente a ${pairs[idx].$2}',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E3A8A),
          ),
        ),
      ],
    );
  }

  // 11. Barra Interactiva de Porcentaje / Decimal (10 bloques de 10%)
  Widget _buildInteractivePercentBar() {
    final pct = _selectedPctCells * 10;
    final dec = (_selectedPctCells / 10).toStringAsFixed(1);

    return Column(
      children: [
        Row(
          children: List.generate(10, (i) {
            final active = i < _selectedPctCells;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedPctCells = i + 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  height: 26,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  decoration: BoxDecoration(
                    color:
                        active ? const Color(0xFF10B981) : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xFF047857),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          'Toca los bloques: $pct%  =  $_selectedPctCells/10  =  $dec',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF065F46),
          ),
        ),
      ],
    );
  }

  // 12. Balanza Algebraica Interactiva
  Widget _buildInteractiveAlgebra() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF8B5CF6), width: 1.5),
            ),
            child: Text(
              _algebraStepRevealed
                  ? '⚖️ Paso: Aplica la operación inversa en ambos lados para dejar sola la x'
                  : '⚖️ En equilibrio: Lado izquierdo = Lado derecho',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF5B21B6),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _MiniChipButton(
          label: _algebraStepRevealed ? 'Ver balanza' : 'Despejar x',
          active: _algebraStepRevealed,
          onTap: () =>
              setState(() => _algebraStepRevealed = !_algebraStepRevealed),
        ),
      ],
    );
  }

  // 13. Recta Numérica Interactiva
  Widget _buildInteractiveNumberLine() {
    final nums = RegExp(r'-?\d+')
        .allMatches(widget.questionText)
        .map((m) => int.tryParse(m.group(0)!) ?? 0)
        .toList();
    final start = nums.isNotEmpty ? nums.first : 0;
    final current = start + _numberLineStep;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (i) {
            final val = start - 3 + i + _numberLineStep;
            final isCenter = i == 3;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: isCenter ? const Color(0xFF3B82F6) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isCenter
                      ? const Color(0xFF1D4ED8)
                      : const Color(0xFFCBD5E1),
                ),
              ),
              child: Text(
                '$val',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: isCenter ? Colors.white : EduPlayColors.textDark,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MiniChipButton(
              label: '← Retroceder (−1)',
              onTap: () => setState(() => _numberLineStep--),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Posición: $current',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
            _MiniChipButton(
              label: 'Avanzar (+1) →',
              onTap: () => setState(() => _numberLineStep++),
            ),
          ],
        ),
      ],
    );
  }

  // 14. Descomposición de Operaciones Aritméticas reales de la pregunta
  Widget _buildInteractiveArithmetic() {
    final nums = RegExp(r'\d+(?:\.\d{3})*')
        .allMatches(widget.questionText)
        .map((m) => int.tryParse(m.group(0)!.replaceAll('.', '')) ?? 0)
        .where((n) => n > 0)
        .toList();

    if (nums.length >= 2) {
      final a = nums[0];
      final b = nums[1];
      final lower = widget.questionText.toLowerCase();
      String op = '+';
      String explanation = 'Suma unidades con unidades y decenas con decenas';
      if (widget.questionText.contains('×') ||
          lower.contains('por ') ||
          lower.contains('cada') ||
          lower.contains('veces')) {
        op = '×';
        explanation =
            'Descompón: $a × $b = ($a × ${b ~/ 10 * 10}) + ($a × ${b % 10})';
      } else if (widget.questionText.contains('÷') ||
          lower.contains('repart') ||
          lower.contains('divid')) {
        op = '÷';
        explanation =
            'Busca qué número multiplicado por $b se acerca a $a sin pasarse';
      } else if (widget.questionText.contains('-') ||
          lower.contains('resta') ||
          lower.contains('queda') ||
          lower.contains('menos') ||
          lower.contains('más cara') ||
          lower.contains('diferencia')) {
        op = '−';
        explanation = 'Calcula la diferencia entre $a y $b paso a paso';
      }

      return Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: EduPlayColors.primaryBlue.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                _arithmeticStepRevealed
                    ? '🔍 $explanation'
                    : 'Datos del problema:  $a   $op   $b',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          _MiniChipButton(
            label: _arithmeticStepRevealed ? 'Ver datos' : 'Ver estrategia',
            active: _arithmeticStepRevealed,
            onTap: () => setState(
              () => _arithmeticStepRevealed = !_arithmeticStepRevealed,
            ),
          ),
        ],
      );
    }

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Text(
        'Lee con atención las cantidades de la pregunta y compara cada opción.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1E3A8A),
        ),
      ),
    );
  }

  String _contextualTip() {
    return switch (_topic) {
      _VisualTopic.placeValue =>
        'Toca cada casilla del tablero (M, CM, DM, UM, C, D, U): cada posición a la izquierda multiplica su valor por 10.',
      _VisualTopic.fraction =>
        'Toca las partes de la barra o la pizza: el denominador indica el total de partes iguales y el numerador las seleccionadas.',
      _VisualTopic.clock =>
        'Usa los botones +15 min, +30 min y +1 hora en el reloj para comprobar a qué hora llega el minutero.',
      _VisualTopic.angle =>
        'Toca los botones de grados en el transportador: 90° es recto, menor de 90° es agudo y mayor de 90° es obtuso.',
      _VisualTopic.circle =>
        'Toca el círculo para alternar entre radio (r) y diámetro (d = 2 × r). Para la circunferencia multiplica por π ≈ 3,14.',
      _VisualTopic.solid3D =>
        'El volumen cuenta cuántos cubos de 1 cm³ caben adentro: multiplica largo × ancho × alto.',
      _VisualTopic.polygonAreaPerimeter =>
        'Alterna entre Área (cuadros interiores = base × altura) y Perímetro (suma de todos los lados del borde).',
      _VisualTopic.cartesian =>
        'Toca cualquier punto del plano: primero cuenta hacia la derecha en el eje X y luego hacia arriba en el eje Y.',
      _VisualTopic.statistics =>
        'Toca cada barra para comparar cantidades. La barra más alta representa la moda (el dato más frecuente).',
      _VisualTopic.measurement =>
        'Toca las fichas de equivalencia para recordar cuántas unidades pequeñas caben en una grande.',
      _VisualTopic.percentDecimalMoney =>
        'Toca los 10 bloques: cada bloque representa 10% (o 0,1). 5 bloques son 50% (la mitad).',
      _VisualTopic.algebra =>
        'Pulsa "Despejar x": para mantener la balanza en equilibrio, haz la operación inversa en ambos lados.',
      _VisualTopic.numberLineSequence =>
        'Usa los botones de avanzar (+) y retroceder (−) en la recta para contar los saltos entre números.',
      _VisualTopic.arithmetic =>
        'Pulsa "Ver estrategia" para descomponer la operación con los números exactos del problema.',
    };
  }
}

class _MiniChipButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool active;

  const _MiniChipButton({
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: active ? EduPlayColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: EduPlayColors.primaryBlue.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: active ? Colors.white : EduPlayColors.primaryBlue,
          ),
        ),
      ),
    );
  }
}

// ── Painters de los gráficos interactivos ───────────────────────────────────

class _InteractivePiePainter extends CustomPainter {
  final int numerator;
  final int denominator;

  _InteractivePiePainter({
    required this.numerator,
    required this.denominator,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 3;
    final sweep = (2 * math.pi) / denominator;

    final fill = Paint()..style = PaintingStyle.fill;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF1E3A8A)
      ..strokeWidth = 1.8;

    for (int i = 0; i < denominator; i++) {
      fill.color =
          i < numerator ? const Color(0xFFF59E0B) : Colors.white;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + i * sweep,
        sweep,
        true,
        fill,
      );
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + i * sweep,
        sweep,
        true,
        stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _InteractivePiePainter old) =>
      old.numerator != numerator || old.denominator != denominator;
}

class _InteractiveClockPainter extends CustomPainter {
  final int hour;
  final int minute;

  _InteractiveClockPainter({required this.hour, required this.minute});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 3;

    canvas.drawCircle(center, radius, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFF1E3A8A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    for (int i = 0; i < 12; i++) {
      final a = -math.pi / 2 + i * (math.pi / 6);
      canvas.drawLine(
        Offset(center.dx + (radius - 5) * math.cos(a),
            center.dy + (radius - 5) * math.sin(a)),
        Offset(center.dx + (radius - 1) * math.cos(a),
            center.dy + (radius - 1) * math.sin(a)),
        Paint()
          ..color = const Color(0xFF1E3A8A)
          ..strokeWidth = i % 3 == 0 ? 2.2 : 1,
      );
    }

    final hAngle = -math.pi / 2 + (((hour % 12) + minute / 60) * math.pi / 6);
    canvas.drawLine(
      center,
      Offset(center.dx + radius * 0.5 * math.cos(hAngle),
          center.dy + radius * 0.5 * math.sin(hAngle)),
      Paint()
        ..color = const Color(0xFFEF4444)
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    final mAngle = -math.pi / 2 + (minute * math.pi / 30);
    canvas.drawLine(
      center,
      Offset(center.dx + radius * 0.75 * math.cos(mAngle),
          center.dy + radius * 0.75 * math.sin(mAngle)),
      Paint()
        ..color = const Color(0xFF2563EB)
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(center, 3, Paint()..color = const Color(0xFF1E3A8A));
  }

  @override
  bool shouldRepaint(covariant _InteractiveClockPainter old) =>
      old.hour != hour || old.minute != minute;
}

class _InteractiveAnglePainter extends CustomPainter {
  final double degrees;
  _InteractiveAnglePainter({required this.degrees});

  @override
  void paint(Canvas canvas, Size size) {
    final vertex = Offset(size.width * 0.45, size.height * 0.85);
    const len = 38.0;
    final rad = -degrees * math.pi / 180;

    // Semicírculo de transportador
    canvas.drawArc(
      Rect.fromCircle(center: vertex, radius: len),
      -math.pi,
      math.pi,
      true,
      Paint()..color = Colors.white,
    );
    canvas.drawArc(
      Rect.fromCircle(center: vertex, radius: 22),
      rad,
      -rad,
      true,
      Paint()..color = const Color(0xFFF59E0B).withValues(alpha: 0.45),
    );

    final rayPaint = Paint()
      ..color = const Color(0xFF1D4ED8)
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(vertex, Offset(vertex.dx + len, vertex.dy), rayPaint);
    canvas.drawLine(
      vertex,
      Offset(vertex.dx + len * math.cos(rad), vertex.dy + len * math.sin(rad)),
      rayPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _InteractiveAnglePainter old) =>
      old.degrees != degrees;
}

class _InteractiveCirclePainter extends CustomPainter {
  final bool showDiameter;
  _InteractiveCirclePainter({required this.showDiameter});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;

    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFDBEAFE));
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFF1D4ED8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2,
    );

    canvas.drawLine(
      showDiameter ? Offset(center.dx - radius, center.dy) : center,
      Offset(center.dx + radius, center.dy),
      Paint()
        ..color = const Color(0xFFEF4444)
        ..strokeWidth = 2.8,
    );
    canvas.drawCircle(center, 3.5, Paint()..color = const Color(0xFF1E3A8A));
  }

  @override
  bool shouldRepaint(covariant _InteractiveCirclePainter old) =>
      old.showDiameter != showDiameter;
}

class _InteractiveCubePainter extends CustomPainter {
  final bool highlightFaces;
  _InteractiveCubePainter({required this.highlightFaces});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.44;
    final cy = size.height * 0.58;
    const w = 34.0;
    const h = 28.0;
    const dx = 12.0;
    const dy = -10.0;

    final front = Rect.fromCenter(center: Offset(cx, cy), width: w, height: h);
    final top = Path()
      ..moveTo(front.left, front.top)
      ..lineTo(front.left + dx, front.top + dy)
      ..lineTo(front.right + dx, front.top + dy)
      ..lineTo(front.right, front.top)
      ..close();
    final side = Path()
      ..moveTo(front.right, front.top)
      ..lineTo(front.right + dx, front.top + dy)
      ..lineTo(front.right + dx, front.bottom + dy)
      ..lineTo(front.right, front.bottom)
      ..close();

    canvas.drawPath(top, Paint()..color = const Color(0xFF93C5FD));
    canvas.drawPath(side, Paint()..color = const Color(0xFF3B82F6));
    canvas.drawRect(
      front,
      Paint()
        ..color = highlightFaces
            ? const Color(0xFF60A5FA)
            : const Color(0xFFFDE68A),
    );

    final stroke = Paint()
      ..color = const Color(0xFF1E3A8A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawRect(front, stroke);
    canvas.drawPath(top, stroke);
    canvas.drawPath(side, stroke);
  }

  @override
  bool shouldRepaint(covariant _InteractiveCubePainter old) =>
      old.highlightFaces != highlightFaces;
}

class _InteractivePolygonPainter extends CustomPainter {
  final bool isTriangle;
  final bool showGrid;

  _InteractivePolygonPainter({
    required this.isTriangle,
    required this.showGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final fill = Paint()
      ..color = showGrid
          ? const Color(0xFFBFDBFE)
          : Colors.white;
    final stroke = Paint()
      ..color = showGrid
          ? const Color(0xFF1D4ED8)
          : const Color(0xFFEF4444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = showGrid ? 2.0 : 3.2;

    if (isTriangle) {
      final path = Path()
        ..moveTo(center.dx, center.dy - 22)
        ..lineTo(center.dx - 26, center.dy + 20)
        ..lineTo(center.dx + 26, center.dy + 20)
        ..close();
      canvas.drawPath(path, fill);
      canvas.drawPath(path, stroke);
    } else {
      final rect = Rect.fromCenter(center: center, width: 54, height: 38);
      canvas.drawRect(rect, fill);
      if (showGrid) {
        final g = Paint()
          ..color = const Color(0xFF1D4ED8).withValues(alpha: 0.35)
          ..strokeWidth = 1;
        canvas.drawLine(Offset(rect.left + 18, rect.top),
            Offset(rect.left + 18, rect.bottom), g);
        canvas.drawLine(Offset(rect.left + 36, rect.top),
            Offset(rect.left + 36, rect.bottom), g);
        canvas.drawLine(Offset(rect.left, rect.top + 19),
            Offset(rect.right, rect.top + 19), g);
      }
      canvas.drawRect(rect, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _InteractivePolygonPainter old) =>
      old.isTriangle != isTriangle || old.showGrid != showGrid;
}

class _InteractiveCartesianPainter extends CustomPainter {
  final math.Point<int> point;
  _InteractiveCartesianPainter({required this.point});

  @override
  void paint(Canvas canvas, Size size) {
    const left = 18.0;
    const bottom = 58.0;
    const stepX = 14.0;
    const stepY = 12.0;

    final grid = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 0.8;
    for (int x = 0; x <= 5; x++) {
      canvas.drawLine(
        Offset(left + x * stepX, bottom - 4 * stepY),
        Offset(left + x * stepX, bottom),
        grid,
      );
    }
    for (int y = 0; y <= 4; y++) {
      canvas.drawLine(
        Offset(left, bottom - y * stepY),
        Offset(left + 5 * stepX, bottom - y * stepY),
        grid,
      );
    }

    final axis = Paint()
      ..color = const Color(0xFF1E3A8A)
      ..strokeWidth = 2;
    canvas.drawLine(
        const Offset(left, bottom), const Offset(left + 5 * stepX, bottom), axis);
    canvas.drawLine(
        const Offset(left, bottom), const Offset(left, bottom - 4 * stepY), axis);

    final pt = Offset(left + point.x * stepX, bottom - point.y * stepY);
    canvas.drawCircle(pt, 5, Paint()..color = const Color(0xFFEF4444));
  }

  @override
  bool shouldRepaint(covariant _InteractiveCartesianPainter old) =>
      old.point != point;
}
