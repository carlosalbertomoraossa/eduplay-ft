import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/lumi_lion_mascot.dart';

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
  int _selectedPlaceIdx = 4; // 0:M, 1:CM, 2:DM, 3:UM, 4:C, 5:D, 6:U
  int _startPlaceCol = 4; // desde qué columna mostrar (4=C..U, 3=UM..U, 1=CM..U, 0=M..U)
  List<int> _placeDigits = [0, 0, 0, 0, 1, 0, 0]; // 7 dígitos: M, CM, DM, UM, C, D, U
  List<int> _candidatePlaceNumbers = const [];
  bool _showExtraTip = false;
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
    _showExtraTip = false;

    // Inicializar estado coherente con los datos reales de la pregunta
    switch (_topic) {
      case _VisualTopic.placeValue:
        _initPlaceValueFromQuestion(q, lower, widget.options);

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

  void _initPlaceValueFromQuestion(
    String q,
    String lower,
    List<String> options,
  ) {
    // Extraer números grandes (con o sin puntos de miles) de la pregunta
    final qNums = RegExp(r'\d+(?:\.\d{3})*')
        .allMatches(q)
        .map((m) => int.tryParse(m.group(0)!.replaceAll('.', '')) ?? -1)
        .where((n) => n >= 10 && n <= 9999999)
        .toSet()
        .toList();

    // Si la pregunta es de descomposición (ej. "500 + 60 + 8 = ___"), no pre-armar la suma total
    final isSumDecomposition = RegExp(r'\d+\s*\+\s*(?:\d+|___)\s*\+').hasMatch(q);

    // También extraer candidatos de las opciones cuando en la pregunta están en letras
    final optNums = options
        .map((o) => int.tryParse(o.replaceAll(RegExp(r'[^0-9]'), '')) ?? -1)
        .where((n) => n >= 100 && n <= 9999999)
        .take(4)
        .toList();

    if (!isSumDecomposition && qNums.isNotEmpty) {
      _candidatePlaceNumbers = qNums.take(3).toList();
    } else if (!isSumDecomposition && optNums.isNotEmpty && qNums.isEmpty) {
      // Pregunta en palabras ("trescientos cuarenta y siete"): permitir probar opciones o armar desde 0
      _candidatePlaceNumbers = const [];
    } else {
      _candidatePlaceNumbers = const [];
    }

    // Determinar cuántas columnas mostrar según la magnitud del problema
    final scaleNums = qNums.isNotEmpty ? qNums : optNums;
    final maxNum = scaleNums.isEmpty ? 0 : scaleNums.reduce(math.max);

    if (lower.contains('millón') ||
        lower.contains('millon') ||
        maxNum >= 1000000) {
      _startPlaceCol = 0; // M, CM, DM, UM, C, D, U (7 columnas)
    } else if (lower.contains('centena de mil') ||
        lower.contains('centenas de mil') ||
        lower.contains('decena de mil') ||
        lower.contains('decenas de mil') ||
        maxNum >= 10000) {
      _startPlaceCol = 1; // CM, DM, UM, C, D, U (6 columnas)
    } else if (lower.contains('unidad de mil') ||
        lower.contains('unidades de mil') ||
        lower.contains('millar') ||
        lower.contains('mil') ||
        maxNum >= 1000) {
      _startPlaceCol = 3; // UM, C, D, U (4 columnas)
    } else {
      _startPlaceCol = 4; // C, D, U (3 columnas amplias para 1° y 2°)
    }

    // Cargar el número principal en las casillas (o dejar en 0/100 para que el niño lo arme)
    if (!isSumDecomposition && qNums.isNotEmpty) {
      _setDigitsFromNumber(qNums.first);
    } else if (lower.contains('1 centena de mil')) {
      _setDigitsFromNumber(100000);
    } else if (lower.contains('1 decena de mil')) {
      _setDigitsFromNumber(10000);
    } else if (lower.contains('1 unidad de mil') || lower.contains('un millar')) {
      _setDigitsFromNumber(1000);
    } else if (lower.contains('1 centena') || lower.contains('una centena')) {
      _setDigitsFromNumber(100);
    } else {
      _setDigitsFromNumber(0);
    }

    // Seleccionar la columna relevante según la pregunta
    // Si pregunta por un dígito específico ("el dígito 6" en 648.320), seleccionamos su columna
    final digitAsked = RegExp(r'd[íi]gito\s+(\d)').firstMatch(lower);
    if (digitAsked != null) {
      final d = int.tryParse(digitAsked.group(1)!) ?? -1;
      final idx = _placeDigits.indexOf(d, _startPlaceCol);
      if (idx != -1) {
        _selectedPlaceIdx = idx;
        return;
      }
    }

    if (lower.contains('millón') || lower.contains('millon')) {
      _selectedPlaceIdx = 0;
    } else if (lower.contains('centena de mil') ||
        lower.contains('centenas de mil')) {
      _selectedPlaceIdx = 1;
    } else if (lower.contains('decena de mil') ||
        lower.contains('decenas de mil')) {
      _selectedPlaceIdx = 2;
    } else if (lower.contains('unidad de mil') ||
        lower.contains('unidades de mil') ||
        lower.contains('millar')) {
      _selectedPlaceIdx = 3;
    } else if (lower.contains('centena')) {
      _selectedPlaceIdx = 4;
    } else if (lower.contains('decena')) {
      _selectedPlaceIdx = 5;
    } else if (lower.contains('unidad')) {
      _selectedPlaceIdx = 6;
    } else {
      _selectedPlaceIdx = _startPlaceCol;
    }
  }

  void _setDigitsFromNumber(int number) {
    final clamped = number.clamp(0, 9999999);
    final padded = clamped.toString().padLeft(7, '0');
    _placeDigits = List.generate(7, (i) => int.parse(padded[i]));
  }

  int _currentPlaceNumber() {
    int total = 0;
    const multipliers = [1000000, 100000, 10000, 1000, 100, 10, 1];
    for (int i = 0; i < 7; i++) {
      total += _placeDigits[i] * multipliers[i];
    }
    return total;
  }

  void _changePlaceDigit(int colIdx, int delta) {
    const multipliers = [1000000, 100000, 10000, 1000, 100, 10, 1];
    final nextTotal =
        (_currentPlaceNumber() + delta * multipliers[colIdx]).clamp(0, 9999999);
    setState(() {
      _selectedPlaceIdx = colIdx;
      _setDigitsFromNumber(nextTotal);
      if (nextTotal >= 1000000 && _startPlaceCol > 0) {
        _startPlaceCol = 0;
      } else if (nextTotal >= 100000 && _startPlaceCol > 1) {
        _startPlaceCol = 1;
      } else if (nextTotal >= 1000 && _startPlaceCol > 3) {
        _startPlaceCol = 3;
      }
    });
  }

  static String _formatColombianInt(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) {
        buf.write('.');
      }
      buf.write(s[i]);
    }
    return buf.toString();
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

    // 1. Valor posicional / lectura, escritura, descomposición y comparación de números
    final isPlaceDecomposition =
        RegExp(r'\b[1-9]00(?:\.\d{3})*\s*\+\s*(?:[1-9]0|___)').hasMatch(q) ||
        lower.contains('descomposición') ||
        lower.contains('descomposicion');
    final isBigNumberComparison =
        (lower.contains('mayor') ||
            lower.contains('menor') ||
            lower.contains('símbolo') ||
            lower.contains('habitantes') ||
            lower.contains('población')) &&
        RegExp(r'\b\d{3}(?:\.\d{3})*\b').hasMatch(q) &&
        !lower.contains('fracción') &&
        !lower.contains('ángulo') &&
        !lower.contains('área') &&
        !lower.contains('perímetro');

    if (lower.contains('centena') ||
        lower.contains('decena') ||
        lower.contains('unidad de mil') ||
        lower.contains('unidades de mil') ||
        lower.contains('millar') ||
        lower.contains('millón') ||
        lower.contains('millon') ||
        lower.contains('valor posicional') ||
        lower.contains('dígito') ||
        lower.contains('digito') ||
        lower.contains('cifras') ||
        lower.contains('redondea') ||
        lower.contains('cómo se escribe') ||
        lower.contains('como se escribe') ||
        lower.contains('cómo se lee') ||
        isPlaceDecomposition ||
        isBigNumberComparison) {
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
    final primaryTip =
        (widget.hint != null && widget.hint!.trim().isNotEmpty)
            ? widget.hint!.trim()
            : _contextualTip();
    final extraTip = _kidFriendlyExtraTip();
    final displayedTip = _showExtraTip ? extraTip : primaryTip;

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
                  Flexible(
                    child: Text(
                      _topicTitle(),
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E3A8A),
                      ),
                      overflow: TextOverflow.ellipsis,
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
                      '👆 ¡Toca y juega!',
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
        // ── Pista de Lumi para niños (con botón de súper truco extra) ────
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: widget.compact ? 8 : 10,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.55),
              width: 1.4,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LumiLionMascot(
                        size: 30,
                        expressionVariant: _showExtraTip ? 1 : 0,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _showExtraTip
                            ? '🦁 Súper Tip: ¡Truco de Lumi!'
                            : '🦁 Tip: ¡Pista de Lumi!',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: widget.compact ? 11.5 : 12.5,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _showExtraTip = !_showExtraTip),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFD97706).withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        _showExtraTip ? '🔙 Ver pista 1' : '✨ Otro truco',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF92400E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                displayedTip,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: widget.compact ? 12 : 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF78350F),
                  height: 1.32,
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
      _VisualTopic.placeValue => '🧮 Ábaco y Tabla Posicional (+ / −)',
      _VisualTopic.fraction => '🍕 Fábrica de Fracciones (Toca las partes)',
      _VisualTopic.clock => '🕒 Reloj Interactivo (Mueve los minutos)',
      _VisualTopic.angle => '📐 Explorador de Ángulos',
      _VisualTopic.circle => '⭕ Círculo: Radio y Diámetro',
      _VisualTopic.solid3D => '🧊 Cubo 3D y Volumen',
      _VisualTopic.polygonAreaPerimeter => '📏 Figura Geométrica (Área / Perímetro)',
      _VisualTopic.cartesian => '📍 Mapa Cartesiano (Toca un punto)',
      _VisualTopic.statistics => '📊 Gráfica de Barras (Toca cada barra)',
      _VisualTopic.measurement => '⚖️ Tabla de Medidas y Equivalencias',
      _VisualTopic.percentDecimalMoney => '💯 Bloques de Porcentaje y Decimal',
      _VisualTopic.algebra => '⚖️ Balanza de Ecuaciones',
      _VisualTopic.numberLineSequence => '🐸 Saltos en la Recta Numérica',
      _VisualTopic.arithmetic => '🧮 Laboratorio de Operaciones',
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

  // 1. Ábaco y Tabla Posicional Interactiva (con fichas visuales, botones + / − y descomposición en vivo)
  Widget _buildPlaceValueAbacus() {
    const allColumns = [
      ('M', 'Millón', 1000000, Color(0xFFEF4444)),
      ('CM', 'C. Mil', 100000, Color(0xFFF59E0B)),
      ('DM', 'D. Mil', 10000, Color(0xFF10B981)),
      ('UM', 'Mil', 1000, Color(0xFF3B82F6)),
      ('C', 'Cien', 100, Color(0xFF6366F1)),
      ('D', 'Diez', 10, Color(0xFF8B5CF6)),
      ('U', 'Uno', 1, Color(0xFFEC4899)),
    ];

    final startCol = _startPlaceCol.clamp(0, 4);
    final selIdx = _selectedPlaceIdx.clamp(startCol, 6);
    final selCol = allColumns[selIdx];
    final selDigit = _placeDigits[selIdx];
    final selValue = selDigit * selCol.$3;
    final totalNum = _currentPlaceNumber();

    // Partes de la descomposición aditiva (> 0)
    final activeParts = <(int colIdx, String text, Color color)>[];
    for (int i = startCol; i < 7; i++) {
      final d = _placeDigits[i];
      if (d > 0) {
        activeParts.add((
          i,
          _formatColombianInt(d * allColumns[i].$3),
          allColumns[i].$4,
        ));
      }
    }

    return Column(
      children: [
        // Barra superior: Número armado + botones rápidos (comparar números / vaciar / más casillas)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '🔢 Número: ${_formatColombianInt(totalNum)}',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Wrap(
              spacing: 4,
              children: [
                for (final cand in _candidatePlaceNumbers.take(2))
                  if (_candidatePlaceNumbers.length > 1 || cand != totalNum)
                    _MiniChipButton(
                      label: '📌 ${_formatColombianInt(cand)}',
                      active: totalNum == cand,
                      onTap: () => setState(() => _setDigitsFromNumber(cand)),
                    ),
                if (totalNum > 0)
                  _MiniChipButton(
                    label: '🧹 En 0',
                    onTap: () => setState(() => _setDigitsFromNumber(0)),
                  ),
                if (startCol > 0)
                  _MiniChipButton(
                    label: '+ casillas',
                    onTap: () => setState(() {
                      _startPlaceCol = startCol >= 4
                          ? 3
                          : startCol >= 3
                              ? 1
                              : 0;
                    }),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Columnas interactivas del tablero con botones [+], fichas de ábaco, dígito y [-]
        Row(
          children: [
            for (int i = startCol; i < 7; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: _buildPlaceColumnCard(
                    colIdx: i,
                    shortCode: allColumns[i].$1,
                    friendlyName: allColumns[i].$2,
                    unitValue: allColumns[i].$3,
                    color: allColumns[i].$4,
                    digit: _placeDigits[i],
                    isSelected: i == selIdx,
                    compact: widget.compact || (7 - startCol) >= 6,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),

        // Barra de descomposición en vivo (tocar cada sumando selecciona su casilla)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selCol.$4.withValues(alpha: 0.45),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              if (activeParts.isEmpty)
                const Text(
                  '👆 ¡Toca los botones + en cada casilla para poner fichas y armar tu número!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E3A8A),
                  ),
                )
              else
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 3,
                  runSpacing: 2,
                  children: [
                    const Text(
                      '🧩 Suma: ',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: EduPlayColors.textMedium,
                      ),
                    ),
                    for (int p = 0; p < activeParts.length; p++) ...[
                      if (p > 0)
                        const Text(
                          '+',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: EduPlayColors.textMedium,
                          ),
                        ),
                      GestureDetector(
                        onTap: () =>
                            setState(() => _selectedPlaceIdx = activeParts[p].$1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: activeParts[p].$1 == selIdx
                                ? activeParts[p].$3
                                : activeParts[p].$3.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            activeParts[p].$2,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: activeParts[p].$1 == selIdx
                                  ? Colors.white
                                  : activeParts[p].$3,
                            ),
                          ),
                        ),
                      ),
                    ],
                    Text(
                      ' = ${_formatColombianInt(totalNum)}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 3),
              Text(
                '🎯 Casilla ${selCol.$1} (${selCol.$2} = ${_formatColombianInt(selCol.$3)}): '
                '$selDigit ${selDigit == 1 ? "ficha vale" : "fichas valen"} ${_formatColombianInt(selValue)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: selCol.$4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceColumnCard({
    required int colIdx,
    required String shortCode,
    required String friendlyName,
    required int unitValue,
    required Color color,
    required int digit,
    required bool isSelected,
    required bool compact,
  }) {
    final posVal = digit * unitValue;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlaceIdx = colIdx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          vertical: compact ? 4 : 5,
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.45),
            width: isSelected ? 2.2 : 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Etiqueta de la posición (M, CM, DM, UM, C, D, U)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                shortCode,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: compact ? 10 : 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            if (!compact)
              Text(
                friendlyName,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 3),

            // Botón [+] para agregar 1 ficha en esta columna
            GestureDetector(
              onTap: () => _changePlaceDigit(colIdx, 1),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: compact ? 12 : 13,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),

            // Fichas visuales del ábaco (hasta 9 bolitas de color) + Dígito grande
            SizedBox(
              height: compact ? 12 : 16,
              child: Center(
                child: digit == 0
                    ? Text(
                        'vacío',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 7.5,
                          fontWeight: FontWeight.w600,
                          color: EduPlayColors.textMedium.withValues(alpha: 0.6),
                        ),
                      )
                    : Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 1.5,
                        runSpacing: 1.5,
                        children: List.generate(
                          digit,
                          (_) => Container(
                            width: compact ? 4.5 : 5.5,
                            height: compact ? 4.5 : 5.5,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Text(
              '$digit',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: compact ? 15 : 17,
                fontWeight: FontWeight.w900,
                height: 1.1,
                color: digit > 0 ? const Color(0xFF1E293B) : EduPlayColors.textMedium,
              ),
            ),
            const SizedBox(height: 2),

            // Botón [−] para quitar 1 ficha de esta columna
            GestureDetector(
              onTap: () => _changePlaceDigit(colIdx, -1),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0).withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '−',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: compact ? 12 : 13,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    color: EduPlayColors.textDark,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),

            // Valor posicional real de ese dígito abajo
            Text(
              _formatColombianInt(posVal),
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: compact ? 8 : 9,
                fontWeight: FontWeight.w800,
                color: digit > 0 ? color : EduPlayColors.textMedium,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
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
    final lower = widget.questionText.toLowerCase();

    return switch (_topic) {
      _VisualTopic.placeValue => () {
          if (lower.contains('redondea') || lower.contains('aproximadamente')) {
            return '¡El truco del tobogán! 🛝 Mira el número vecino de la derecha: si es 5 o más (5, 6, 7, 8, 9), sube al siguiente escalón; si es menor que 5, se queda igual.';
          }
          if (lower.contains('mayor') ||
              lower.contains('menor') ||
              lower.contains('símbolo') ||
              lower.contains('habitantes')) {
            return '¡Usa el truco del cocodrilo hambriento! 🐊 Compara casilla por casilla desde la izquierda. Recuerda que la boca abierta (>) siempre se come al número más grande.';
          }
          if (lower.contains('dígito') || lower.contains('digito')) {
            return '¡Juguemos al detective! 🕵️ Busca ese número en las casillas de arriba: el nombre de su casilla te dice cuánto vale y cuántos ceros lleva al final.';
          }
          return '¡Cada casilla es un equipo! 🧮 10 Unidades forman 1 Decena (10), y 10 Decenas forman 1 Centena (100). ¡Usa los botones + y − para armar el número!';
        }(),
      _VisualTopic.fraction => () {
          if (lower.contains('equivalente')) {
            return '¡Dos fracciones son gemelas (equivalentes) si pintan exactamente el mismo tamaño de pizza, aunque esté cortada en más pedacitos! 🍕';
          }
          return '¡Imagina una rica pizza! 🍕 El número de abajo cuenta en cuántos pedazos iguales se partió toda la pizza, y el de arriba cuántos pedazos tomaste.';
        }(),
      _VisualTopic.clock =>
        '¡El secreto de las agujas! ⏰ La aguja cortita es tranquila y dice la HORA. La aguja larga es rápida y cuenta los MINUTOS de 5 en 5 alrededor del reloj.',
      _VisualTopic.angle =>
        '¡Haz el ángulo con tus brazos! 💪 Como la esquina de tu cuaderno = 90° (recto). Más cerradito = agudo (< 90°). Muy abierto = obtuso (> 90°).',
      _VisualTopic.circle =>
        '¡Piensa en una rueda de bicicleta! 🚲 Un rayo del centro al borde es el RADIO. Si cruzas todo el círculo pasando por el centro es el DIÁMETRO (¡mide 2 radios!).',
      _VisualTopic.solid3D =>
        '¡Imagina que llenas una caja con cubitos de armar! 🧱 Para saber cuántos cubitos caben adentro sin contarlos uno por uno, multiplica: largo × ancho × alto.',
      _VisualTopic.polygonAreaPerimeter => () {
          if (lower.contains('perímetro') || lower.contains('perimetro')) {
            return '¡El PERÍMETRO es como la cerca que rodea un jardín! 🏡 Solo tienes que caminar por todo el borde y sumar lo que miden todos sus lados.';
          }
          if (lower.contains('área') || lower.contains('area')) {
            return '¡El ÁREA es el pasto que cubre el piso por dentro! 🌱 Cuenta cuántos cuadritos caben adentro multiplicando el largo por el ancho.';
          }
          return '¡Cuenta con tu dedito las esquinas (vértices) y los bordes rectos (lados) de la figura! 📐';
        }(),
      _VisualTopic.cartesian =>
        '¡Primero caminas y luego subes en ascensor! 🚀 El primer número te dice cuántos pasos das a la derecha (→) y el segundo cuántos pisos subes (↑).',
      _VisualTopic.statistics => () {
          if (lower.contains('moda')) {
            return '¡La MODA es el campeón que más se repite! 🏆 Mira en la gráfica cuál es la barra más alta de todas.';
          }
          if (lower.contains('mediana')) {
            return '¡Haz una fila del más pequeño al más grande! 🧍‍♂️🧍‍♀️ El número que quede justo en toda la mitad de la fila es la MEDIANA.';
          }
          if (lower.contains('promedio') || lower.contains('media')) {
            return '¡El PROMEDIO es repartir en partes iguales! 🤝 Suma todos los puntos y luego divídelo entre la cantidad de datos.';
          }
          if (lower.contains('probabilidad') ||
              lower.contains('dado') ||
              lower.contains('moneda') ||
              lower.contains('bolas')) {
            return '¡Cuenta tus oportunidades de ganar! 🎲 Pon arriba cuántas opciones te sirven a ti y abajo el total de opciones que existen.';
          }
          return '¡Toca cada barra de colores para comparar! 📊 Entre más alta sea la barra, mayor es la cantidad.';
        }(),
      _VisualTopic.measurement =>
        '¡Palabra mágica! ✨ "Kilo" significa MIL (1 km = 1.000 m, 1 kg = 1.000 g) y "Centi" significa CIEN (1 metro tiene 100 centímetros).',
      _VisualTopic.percentDecimalMoney => () {
          if (lower.contains('descuento')) {
            return '¡Un descuento es plata que te ahorras! 🏷️ Primero calcula esa parte del precio y luego réstala de lo que costaba antes.';
          }
          return '¡Piensa en 100 moneditas! 🪙 50% es exactamente la mitad (÷ 2), 25% es la cuarta parte (÷ 4) y 10% es quitar un cero.';
        }(),
      _VisualTopic.algebra =>
        '¡La letra x es un número misterioso con antifaz! 🎭 Como la balanza está en equilibrio, descúbrelo haciendo la operación contraria (si suma, resta; si multiplica, divide).',
      _VisualTopic.numberLineSequence =>
        '¡Salta como una ranita en la recta! 🐸 Cuando sumas o sube el calor vas a la derecha (+); cuando restas o hace frío bajo cero vas a la izquierda (−).',
      _VisualTopic.arithmetic => () {
          if (widget.questionText.contains('×') ||
              lower.contains('por ') ||
              lower.contains('cada') ||
              lower.contains('veces')) {
            return '¡Multiplicar es sumar rápido el mismo grupo varias veces! ⚡ Si un número termina en 0, multiplica los demás y ponle el 0 al final.';
          }
          if (widget.questionText.contains('÷') ||
              lower.contains('repart') ||
              lower.contains('divid')) {
            return '¡Dividir es repartir dulces en partes iguales! 🍬 Pregúntate: ¿qué número multiplicado por el divisor me da el total?';
          }
          if (widget.questionText.contains('-') ||
              lower.contains('resta') ||
              lower.contains('queda') ||
              lower.contains('menos') ||
              lower.contains('diferencia')) {
            return '¡Para restar sin equivocarte, empieza por las unidades! 🎯 También puedes contar cuánto le falta al número pequeño para alcanzar al grande.';
          }
          return '¡Suma primero las unidades y luego las decenas! 🌟 Si las unidades pasan de 9, formas 1 decena nueva y la llevas a la siguiente columna.';
        }(),
    };
  }

  String _kidFriendlyExtraTip() {
    final totalNum = _currentPlaceNumber();
    return switch (_topic) {
      _VisualTopic.placeValue =>
        'Usa los botones + y − del ábaco arriba: cada ficha en C vale 100, en D vale 10 y en U vale 1. Ahora mismo tienes armado el ${_formatColombianInt(totalNum)}. ¡Prueba cambiar las fichas!',
      _VisualTopic.fraction =>
        'Toca los pedazos de la pizza o de la barra azul arriba hasta pintar $_activeSlices de $_totalSlices partes y compáralo con las opciones.',
      _VisualTopic.clock =>
        'Toca el botón "+15 min" o "+30 min" en el reloj de arriba y mira a qué número apunta cada manecilla.',
      _VisualTopic.angle =>
        'Toca los botones 45°, 90°, 130° y 180° arriba para ver cómo se abre el abanico amarillo en el transportador.',
      _VisualTopic.circle =>
        'Toca "Ver Radio (r)" y "Ver Diámetro (2r)" arriba: verás que el diámetro es el doble del radio. Para el borde completo multiplica el diámetro por 3,14.',
      _VisualTopic.solid3D =>
        'Toca el cubo 3D arriba para ver la multiplicación de sus 3 medidas (largo × ancho × alto) o contar sus 6 caras y 8 esquinas.',
      _VisualTopic.polygonAreaPerimeter =>
        'Toca los botones "Ver Área (interior)" y "Ver Perímetro (borde)" arriba para ver la fórmula resuelta con los números de tu ejercicio.',
      _VisualTopic.cartesian =>
        'Toca la cuadrícula del mapa arriba para mover el punto rojo y ver cómo cambian los números (X horizontal, Y vertical).',
      _VisualTopic.statistics =>
        'Toca cada barra de la gráfica arriba: la barra dorada te muestra enseguida el valor más alto.',
      _VisualTopic.measurement =>
        'Toca los botones de equivalencia arriba: si pasas de una medida grande a una pequeña multiplicas; de pequeña a grande divides.',
      _VisualTopic.percentDecimalMoney =>
        'Toca los 10 bloquecitos verdes arriba: cada bloque vale 10% (o 0,1). ¡Cuenta cuántos bloques necesitas!',
      _VisualTopic.algebra =>
        'Toca el botón "Despejar x" arriba: si a la x le suman un número, réstalo; si la multiplican por un número, divide entre ese número.',
      _VisualTopic.numberLineSequence =>
        'Usa los botones "← Retroceder" y "Avanzar →" arriba para dar saltos de 1 en 1 y ver a qué número llegas.',
      _VisualTopic.arithmetic =>
        'Toca el botón "Ver estrategia" arriba a la derecha para ver cómo partir los números del problema en pasos súper fáciles.',
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
