import 'dart:ui';

/// Paleta atmosférica dark-fairy-tale para cada bioma subterráneo (niveles 1–8).
class BiomeTheme {
  final String name;
  final Color skyTop;
  final Color skyBottom;
  final Color farRock;
  final Color midRock;
  final Color stoneBody;
  final Color stoneTop;
  final Color accentGlow;
  final Color sporeColor;

  const BiomeTheme({
    required this.name,
    required this.skyTop,
    required this.skyBottom,
    required this.farRock,
    required this.midRock,
    required this.stoneBody,
    required this.stoneTop,
    required this.accentGlow,
    required this.sporeColor,
  });
}

class PlatformDef {
  final double x;
  final double y;
  final double width;
  final double height;
  final bool hasCrystalAccent;

  const PlatformDef({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.hasCrystalAccent = false,
  });
}

class SpikeDef {
  final double x;
  final double y; // superficie sobre la que descansan las espinas
  final double width;

  const SpikeDef({
    required this.x,
    required this.y,
    required this.width,
  });
}

class BounceMushroomDef {
  final double x;
  final double y; // base del hongo sobre una plataforma o tallo

  const BounceMushroomDef({required this.x, required this.y});
}

class HookRingDef {
  final double x;
  final double y;

  const HookRingDef({required this.x, required this.y});
}

enum EnemyKind { crawler, floater, sentinel, boss }

class EnemyDef {
  final EnemyKind kind;
  final double x;
  final double y; // pies (crawler/sentinel/boss) o centro (floater)
  final double patrolMinX;
  final double patrolMaxX;

  const EnemyDef({
    required this.kind,
    required this.x,
    required this.y,
    required this.patrolMinX,
    required this.patrolMaxX,
  });
}

class TotemDef {
  final int index; // 0..8 (los 9 altares del mapa; el 10° es el Portal)
  final double x;
  final double y; // base sobre plataforma

  const TotemDef({
    required this.index,
    required this.x,
    required this.y,
  });
}

class HeartPickupDef {
  final double x;
  final double y;

  const HeartPickupDef({required this.x, required this.y});
}

class LevelMapData {
  final int level;
  final BiomeTheme biome;
  final double worldWidth;
  final double worldHeight;
  final double spawnX;
  final double spawnY;
  final List<PlatformDef> platforms;
  final List<SpikeDef> spikes;
  final List<BounceMushroomDef> mushrooms;
  final List<HookRingDef> hookRings;
  final List<EnemyDef> enemies;
  final List<TotemDef> totems;
  final List<HeartPickupDef> hearts;
  final double portalX;
  final double portalY;

  const LevelMapData({
    required this.level,
    required this.biome,
    required this.worldWidth,
    required this.worldHeight,
    required this.spawnX,
    required this.spawnY,
    required this.platforms,
    required this.spikes,
    required this.mushrooms,
    this.hookRings = const [],
    required this.enemies,
    required this.totems,
    required this.hearts,
    required this.portalX,
    required this.portalY,
  });

  static BiomeTheme biomeForLevel(int level) {
    return _biomes[(level - 1).clamp(0, _biomes.length - 1)];
  }

  static LevelMapData forLevel(int level) {
    final clamped = level.clamp(1, 8);
    switch (clamped) {
      case 1:
        return _level1();
      case 2:
        return _level2();
      case 3:
        return _level3();
      case 4:
        return _level4();
      case 5:
        return _level5();
      case 6:
        return _level6();
      case 7:
        return _level7();
      case 8:
      default:
        return _level8();
    }
  }

  static const List<BiomeTheme> _biomes = [
    // 1. Cuaderno Menta (papel crema + acuarela turquesa + reglas doradas)
    BiomeTheme(
      name: 'Cuaderno Menta',
      skyTop: Color(0xFFFFFDF7),
      skyBottom: Color(0xFFE6FCF5),
      farRock: Color(0xFF99F6E4),
      midRock: Color(0xFF5EEAD4),
      stoneBody: Color(0xFF0F766E),
      stoneTop: Color(0xFFF59E0B),
      accentGlow: Color(0xFFFB7185),
      sporeColor: Color(0xFF2DD4BF),
    ),
    // 2. Acuarela Coral (papel marfil + manchas coral + reglas celestes)
    BiomeTheme(
      name: 'Acuarela Coral',
      skyTop: Color(0xFFFFFBF5),
      skyBottom: Color(0xFFFFF1F2),
      farRock: Color(0xFFFECDD3),
      midRock: Color(0xFFFDA4AF),
      stoneBody: Color(0xFFBE123C),
      stoneTop: Color(0xFF38BDF8),
      accentGlow: Color(0xFFFACC15),
      sporeColor: Color(0xFFFB7185),
    ),
    // 3. Página Celeste (cuadrícula azul pastel + libros cobalto + reglas mandarina)
    BiomeTheme(
      name: 'Página Celeste',
      skyTop: Color(0xFFF8FAFC),
      skyBottom: Color(0xFFE0F2FE),
      farRock: Color(0xFFBAE6FD),
      midRock: Color(0xFF7DD3FC),
      stoneBody: Color(0xFF1D4ED8),
      stoneTop: Color(0xFFFB923C),
      accentGlow: Color(0xFFFDE047),
      sporeColor: Color(0xFF38BDF8),
    ),
    // 4. Boceto Mandarina (papel vainilla + acuarela durazno + reglas esmeralda)
    BiomeTheme(
      name: 'Boceto Mandarina',
      skyTop: Color(0xFFFFFDF5),
      skyBottom: Color(0xFFFFF7ED),
      farRock: Color(0xFFFED7AA),
      midRock: Color(0xFFFDBA74),
      stoneBody: Color(0xFFC2410C),
      stoneTop: Color(0xFF10B981),
      accentGlow: Color(0xFFFACC15),
      sporeColor: Color(0xFFF59E0B),
    ),
    // 5. Diario Lavanda (papel lila suave + acuarela violeta + reglas turquesa)
    BiomeTheme(
      name: 'Diario Lavanda',
      skyTop: Color(0xFFFAF5FF),
      skyBottom: Color(0xFFF3E8FF),
      farRock: Color(0xFFDDD6FE),
      midRock: Color(0xFFC4B5FD),
      stoneBody: Color(0xFF6D28D9),
      stoneTop: Color(0xFF14B8A6),
      accentGlow: Color(0xFFF472B6),
      sporeColor: Color(0xFFA78BFA),
    ),
    // 6. Atlas Botánico (papel crema fresco + acuarela salvia + reglas sol)
    BiomeTheme(
      name: 'Atlas Botánico',
      skyTop: Color(0xFFFDFEF6),
      skyBottom: Color(0xFFECFCCB),
      farRock: Color(0xFFBEF264),
      midRock: Color(0xFF86EFAC),
      stoneBody: Color(0xFF15803D),
      stoneTop: Color(0xFFEAB308),
      accentGlow: Color(0xFFFB7185),
      sporeColor: Color(0xFF84CC16),
    ),
    // 7. Taller Fucsia (papel rosado pastel + acuarela frambuesa + reglas cielo)
    BiomeTheme(
      name: 'Taller Fucsia',
      skyTop: Color(0xFFFFF7FA),
      skyBottom: Color(0xFFFCE7F3),
      farRock: Color(0xFFFBCFE8),
      midRock: Color(0xFFF9A8D4),
      stoneBody: Color(0xFF9D174D),
      stoneTop: Color(0xFF0EA5E9),
      accentGlow: Color(0xFFFACC15),
      sporeColor: Color(0xFFEC4899),
    ),
    // 8. Gran Enciclopedia (papel estelar + acuarela índigo-rosa + reglas oro)
    BiomeTheme(
      name: 'Gran Enciclopedia',
      skyTop: Color(0xFFF5F7FF),
      skyBottom: Color(0xFFFDF4FF),
      farRock: Color(0xFFC7D2FE),
      midRock: Color(0xFFE9D5FF),
      stoneBody: Color(0xFF4338CA),
      stoneTop: Color(0xFFF59E0B),
      accentGlow: Color(0xFFFDE047),
      sporeColor: Color(0xFFF472B6),
    ),
  ];

  // ── Nivel 1: El Pozo de Cristal (introductorio, plataformas amables y amplias)
  static LevelMapData _level1() {
    return LevelMapData(
      level: 1,
      biome: _biomes[0],
      worldWidth: 2700,
      worldHeight: 720,
      spawnX: 110,
      spawnY: 540,
      platforms: const [
        // Suelo inicial amplio
        PlatformDef(x: 0, y: 580, width: 520, height: 180, hasCrystalAccent: true),
        // Primeras repisas ascendentes
        PlatformDef(x: 340, y: 465, width: 170, height: 26),
        PlatformDef(x: 590, y: 540, width: 320, height: 220),
        PlatformDef(x: 650, y: 390, width: 200, height: 26, hasCrystalAccent: true),
        // Puente central sobre foso pequeño
        PlatformDef(x: 1000, y: 580, width: 380, height: 180),
        PlatformDef(x: 960, y: 440, width: 170, height: 26),
        PlatformDef(x: 1210, y: 350, width: 210, height: 26, hasCrystalAccent: true),
        // Zona media con ruta alta y baja
        PlatformDef(x: 1470, y: 540, width: 420, height: 220),
        PlatformDef(x: 1560, y: 400, width: 220, height: 26),
        PlatformDef(x: 1820, y: 290, width: 180, height: 26, hasCrystalAccent: true),
        // Recta hacia el portal
        PlatformDef(x: 1990, y: 560, width: 320, height: 200),
        PlatformDef(x: 2050, y: 420, width: 190, height: 26),
        // Santuario del Portal
        PlatformDef(x: 2360, y: 500, width: 340, height: 260, hasCrystalAccent: true),
      ],
      spikes: const [
        SpikeDef(x: 1140, y: 580, width: 64),
        SpikeDef(x: 1690, y: 540, width: 64),
      ],
      mushrooms: const [
        BounceMushroomDef(x: 545, y: 580),
        BounceMushroomDef(x: 1425, y: 560),
        BounceMushroomDef(x: 1940, y: 540),
      ],
      hookRings: const [
        HookRingDef(x: 545, y: 390),
        HookRingDef(x: 960, y: 345),
        HookRingDef(x: 1440, y: 350),
        HookRingDef(x: 1790, y: 265),
        HookRingDef(x: 2320, y: 395),
      ],
      enemies: const [
        EnemyDef(kind: EnemyKind.crawler, x: 740, y: 540, patrolMinX: 610, patrolMaxX: 880),
        EnemyDef(kind: EnemyKind.floater, x: 1120, y: 350, patrolMinX: 1020, patrolMaxX: 1260),
        EnemyDef(kind: EnemyKind.crawler, x: 1580, y: 540, patrolMinX: 1490, patrolMaxX: 1660),
        EnemyDef(kind: EnemyKind.crawler, x: 2140, y: 560, patrolMinX: 2010, patrolMaxX: 2280),
      ],
      totems: const [
        TotemDef(index: 0, x: 425, y: 465),
        TotemDef(index: 1, x: 750, y: 390),
        TotemDef(index: 2, x: 860, y: 540),
        TotemDef(index: 3, x: 1045, y: 440),
        TotemDef(index: 4, x: 1315, y: 350),
        TotemDef(index: 5, x: 1670, y: 400),
        TotemDef(index: 6, x: 1910, y: 290),
        TotemDef(index: 7, x: 2145, y: 420),
        TotemDef(index: 8, x: 2260, y: 560),
      ],
      hearts: const [
        HeartPickupDef(x: 1315, y: 290),
      ],
      portalX: 2540,
      portalY: 500,
    );
  }

  // ── Nivel 2: Cueva de los Hongos (verticalidad + hongos saltarines)
  static LevelMapData _level2() {
    return LevelMapData(
      level: 2,
      biome: _biomes[1],
      worldWidth: 2800,
      worldHeight: 720,
      spawnX: 100,
      spawnY: 540,
      platforms: const [
        PlatformDef(x: 0, y: 580, width: 420, height: 180, hasCrystalAccent: true),
        PlatformDef(x: 260, y: 445, width: 170, height: 26),
        PlatformDef(x: 510, y: 520, width: 250, height: 240),
        PlatformDef(x: 540, y: 340, width: 190, height: 26, hasCrystalAccent: true),
        PlatformDef(x: 840, y: 580, width: 320, height: 180),
        PlatformDef(x: 860, y: 420, width: 180, height: 26),
        PlatformDef(x: 1090, y: 290, width: 190, height: 26, hasCrystalAccent: true),
        PlatformDef(x: 1260, y: 520, width: 340, height: 240),
        PlatformDef(x: 1380, y: 375, width: 200, height: 26),
        PlatformDef(x: 1700, y: 580, width: 350, height: 180),
        PlatformDef(x: 1680, y: 430, width: 170, height: 26),
        PlatformDef(x: 1920, y: 310, width: 200, height: 26, hasCrystalAccent: true),
        PlatformDef(x: 2150, y: 520, width: 240, height: 240),
        PlatformDef(x: 2440, y: 460, width: 360, height: 300, hasCrystalAccent: true),
      ],
      spikes: const [
        SpikeDef(x: 960, y: 580, width: 72),
        SpikeDef(x: 1460, y: 520, width: 64),
        SpikeDef(x: 1850, y: 580, width: 72),
      ],
      mushrooms: const [
        BounceMushroomDef(x: 460, y: 560),
        BounceMushroomDef(x: 795, y: 560),
        BounceMushroomDef(x: 1200, y: 560),
        BounceMushroomDef(x: 1645, y: 560),
        BounceMushroomDef(x: 2100, y: 550),
      ],
      hookRings: const [
        HookRingDef(x: 470, y: 345),
        HookRingDef(x: 1030, y: 270),
        HookRingDef(x: 1620, y: 360),
        HookRingDef(x: 1875, y: 280),
        HookRingDef(x: 2390, y: 365),
      ],
      enemies: const [
        EnemyDef(kind: EnemyKind.crawler, x: 620, y: 520, patrolMinX: 525, patrolMaxX: 740),
        EnemyDef(kind: EnemyKind.floater, x: 980, y: 320, patrolMinX: 860, patrolMaxX: 1120),
        EnemyDef(kind: EnemyKind.crawler, x: 1330, y: 520, patrolMinX: 1275, patrolMaxX: 1445),
        EnemyDef(kind: EnemyKind.floater, x: 1800, y: 330, patrolMinX: 1680, patrolMaxX: 1940),
        EnemyDef(kind: EnemyKind.crawler, x: 2260, y: 520, patrolMinX: 2165, patrolMaxX: 2370),
      ],
      totems: const [
        TotemDef(index: 0, x: 345, y: 445),
        TotemDef(index: 1, x: 635, y: 340),
        TotemDef(index: 2, x: 950, y: 420),
        TotemDef(index: 3, x: 1185, y: 290),
        TotemDef(index: 4, x: 1320, y: 520),
        TotemDef(index: 5, x: 1480, y: 375),
        TotemDef(index: 6, x: 1765, y: 430),
        TotemDef(index: 7, x: 2020, y: 310),
        TotemDef(index: 8, x: 2270, y: 520),
      ],
      hearts: const [
        HeartPickupDef(x: 635, y: 280),
        HeartPickupDef(x: 2020, y: 250),
      ],
      portalX: 2630,
      portalY: 460,
    );
  }

  // ── Nivel 3: Galerías del Eco (primer Centinela + plataformas colgantes)
  static LevelMapData _level3() {
    return _buildProceduralCavern(
      level: 3,
      biome: _biomes[2],
      worldWidth: 2900,
      includeSentinel: true,
      floaterCount: 3,
      spikeDensity: 3,
    );
  }

  // ── Nivel 4: Abismo de Ámbar
  static LevelMapData _level4() {
    return _buildProceduralCavern(
      level: 4,
      biome: _biomes[3],
      worldWidth: 2950,
      includeSentinel: true,
      floaterCount: 3,
      spikeDensity: 4,
    );
  }

  // ── Nivel 5: Ruinas de Amatista
  static LevelMapData _level5() {
    return _buildProceduralCavern(
      level: 5,
      biome: _biomes[4],
      worldWidth: 3000,
      includeSentinel: true,
      floaterCount: 4,
      spikeDensity: 4,
    );
  }

  // ── Nivel 6: Gruta de las Luciérnagas
  static LevelMapData _level6() {
    return _buildProceduralCavern(
      level: 6,
      biome: _biomes[5],
      worldWidth: 3050,
      includeSentinel: true,
      floaterCount: 4,
      spikeDensity: 5,
    );
  }

  // ── Nivel 7: Santuario del Eclipse
  static LevelMapData _level7() {
    return _buildProceduralCavern(
      level: 7,
      biome: _biomes[6],
      worldWidth: 3100,
      includeSentinel: true,
      floaterCount: 5,
      spikeDensity: 5,
    );
  }

  // ── Nivel 8: Trono de la Reina Sombra (Cámara del Jefe Final)
  static LevelMapData _level8() {
    return LevelMapData(
      level: 8,
      biome: _biomes[7],
      worldWidth: 3150,
      worldHeight: 720,
      spawnX: 100,
      spawnY: 540,
      platforms: const [
        // Entrada del Trono
        PlatformDef(x: 0, y: 580, width: 380, height: 180, hasCrystalAccent: true),
        PlatformDef(x: 240, y: 450, width: 160, height: 26),
        // Nave de los Pilares
        PlatformDef(x: 470, y: 540, width: 290, height: 220),
        PlatformDef(x: 520, y: 370, width: 180, height: 26, hasCrystalAccent: true),
        PlatformDef(x: 860, y: 580, width: 320, height: 180),
        PlatformDef(x: 840, y: 420, width: 170, height: 26),
        PlatformDef(x: 1060, y: 290, width: 190, height: 26, hasCrystalAccent: true),
        // Galería Alta
        PlatformDef(x: 1290, y: 520, width: 320, height: 240),
        PlatformDef(x: 1380, y: 360, width: 190, height: 26),
        PlatformDef(x: 1710, y: 560, width: 310, height: 200),
        PlatformDef(x: 1740, y: 400, width: 180, height: 26, hasCrystalAccent: true),
        PlatformDef(x: 1960, y: 290, width: 170, height: 26),
        // Gran Arena de la Reina Sombra + Portal
        PlatformDef(x: 2140, y: 560, width: 1010, height: 200, hasCrystalAccent: true),
        PlatformDef(x: 2260, y: 430, width: 160, height: 24),
        PlatformDef(x: 2560, y: 390, width: 180, height: 24, hasCrystalAccent: true),
        PlatformDef(x: 2860, y: 430, width: 150, height: 24),
      ],
      spikes: const [
        SpikeDef(x: 610, y: 540, width: 64),
        SpikeDef(x: 980, y: 580, width: 64),
        SpikeDef(x: 1420, y: 520, width: 64),
        SpikeDef(x: 1840, y: 560, width: 64),
      ],
      mushrooms: const [
        BounceMushroomDef(x: 425, y: 560),
        BounceMushroomDef(x: 810, y: 560),
        BounceMushroomDef(x: 1235, y: 550),
        BounceMushroomDef(x: 1660, y: 550),
        BounceMushroomDef(x: 2080, y: 560),
      ],
      hookRings: const [
        HookRingDef(x: 435, y: 365),
        HookRingDef(x: 1010, y: 280),
        HookRingDef(x: 1675, y: 365),
        HookRingDef(x: 2085, y: 350),
        HookRingDef(x: 2490, y: 330),
        HookRingDef(x: 2800, y: 340),
      ],
      enemies: const [
        EnemyDef(kind: EnemyKind.crawler, x: 520, y: 540, patrolMinX: 485, patrolMaxX: 595),
        EnemyDef(kind: EnemyKind.floater, x: 960, y: 310, patrolMinX: 840, patrolMaxX: 1120),
        EnemyDef(kind: EnemyKind.sentinel, x: 1520, y: 520, patrolMinX: 1495, patrolMaxX: 1595),
        EnemyDef(kind: EnemyKind.floater, x: 1860, y: 310, patrolMinX: 1730, patrolMaxX: 2000),
        // Jefe Final: Guardián del Trono Sombra
        EnemyDef(kind: EnemyKind.boss, x: 2660, y: 560, patrolMinX: 2240, patrolMaxX: 2940),
      ],
      totems: const [
        TotemDef(index: 0, x: 320, y: 450),
        TotemDef(index: 1, x: 610, y: 370),
        TotemDef(index: 2, x: 925, y: 420),
        TotemDef(index: 3, x: 1155, y: 290),
        TotemDef(index: 4, x: 1475, y: 360),
        TotemDef(index: 5, x: 1830, y: 400),
        TotemDef(index: 6, x: 2045, y: 290),
        TotemDef(index: 7, x: 2340, y: 430),
        TotemDef(index: 8, x: 2650, y: 390),
      ],
      hearts: const [
        HeartPickupDef(x: 1155, y: 230),
        HeartPickupDef(x: 2340, y: 370),
      ],
      portalX: 3020,
      portalY: 560,
    );
  }

  /// Generador determinista para niveles 3–7 con variación real de alturas,
  /// puentes colgantes, rutas dobles, enemigos y alcobas secretas.
  static LevelMapData _buildProceduralCavern({
    required int level,
    required BiomeTheme biome,
    required double worldWidth,
    required bool includeSentinel,
    required int floaterCount,
    required int spikeDensity,
  }) {
    final platforms = <PlatformDef>[
      // Zona de inicio
      const PlatformDef(x: 0, y: 580, width: 380, height: 180, hasCrystalAccent: true),
    ];
    final spikes = <SpikeDef>[];
    final mushrooms = <BounceMushroomDef>[];
    final hookRings = <HookRingDef>[];
    final enemies = <EnemyDef>[];
    final totems = <TotemDef>[];
    final hearts = <HeartPickupDef>[];

    // 5 sectores entre x=430 y worldWidth-420
    const sectorCount = 5;
    final usableWidth = worldWidth - 820;
    final sectorW = usableWidth / sectorCount;
    int totemIdx = 0;

    for (var s = 0; s < sectorCount; s++) {
      final baseX = 430 + s * sectorW;
      // Alternar altura del suelo base para dar sensación de descenso/ascenso
      final floorOffset = ((s + level) % 3) * 28.0;
      final floorY = 580 - floorOffset;
      final floorW = sectorW - 75;

      platforms.add(PlatformDef(
        x: baseX,
        y: floorY,
        width: floorW,
        height: 760 - floorY,
        hasCrystalAccent: s.isEven,
      ));

      // Hongo rebotador en la brecha antes del sector + anillo de enganche alto
      mushrooms.add(BounceMushroomDef(x: baseX - 38, y: 565));
      hookRings.add(HookRingDef(x: baseX - 30, y: floorY - 175));

      // Repisa media
      final midW = 165.0 + ((s * 17 + level * 13) % 45);
      final midX = baseX + 25 + ((s + level).isEven ? 10 : floorW - midW - 25);
      final midY = floorY - 125;
      platforms.add(PlatformDef(
        x: midX,
        y: midY,
        width: midW,
        height: 26,
        hasCrystalAccent: true,
      ));

      if (totemIdx < 9) {
        totems.add(TotemDef(index: totemIdx++, x: midX + midW / 2, y: midY));
      }

      // Repisa alta (alcoba superior) en 4 de 5 sectores
      if (s < 4) {
        const highW = 165.0;
        final highX = baseX + (floorW - highW) * ((s + level).isEven ? 0.78 : 0.18);
        final highY = midY - 115;
        platforms.add(PlatformDef(
          x: highX,
          y: highY,
          width: highW,
          height: 24,
          hasCrystalAccent: true,
        ));
        if (totemIdx < 9) {
          totems.add(TotemDef(index: totemIdx++, x: highX + highW / 2, y: highY));
        }
        if (s == 1 || s == 3) {
          hearts.add(HeartPickupDef(x: highX + highW / 2, y: highY - 62));
        }
      }

      // Espinas seguras (siempre dejando espacio para caer/saltar a ambos lados)
      if (s < spikeDensity && floorW > 220) {
        final sx = baseX + floorW * 0.45;
        spikes.add(SpikeDef(x: sx, y: floorY, width: 64));
      }

      // Enemigos terrestres
      if (includeSentinel && s == 3) {
        enemies.add(EnemyDef(
          kind: EnemyKind.sentinel,
          x: baseX + floorW * 0.72,
          y: floorY,
          patrolMinX: baseX + floorW * 0.56,
          patrolMaxX: baseX + floorW - 24,
        ));
      } else {
        final hasSpike = s < spikeDensity && floorW > 220;
        final minX = baseX + 24;
        final maxX = hasSpike ? baseX + floorW * 0.40 : baseX + floorW - 24;
        if (maxX - minX > 70) {
          enemies.add(EnemyDef(
            kind: EnemyKind.crawler,
            x: (minX + maxX) / 2,
            y: floorY,
            patrolMinX: minX,
            patrolMaxX: maxX,
          ));
        }
      }

      // Enemigos voladores (Polillas del Pozo)
      if (s < floaterCount) {
        enemies.add(EnemyDef(
          kind: EnemyKind.floater,
          x: baseX + floorW * 0.5,
          y: midY - 75,
          patrolMinX: baseX + 30,
          patrolMaxX: baseX + floorW - 30,
        ));
      }
    }

    // Santuario final del Portal
    final portalPlatX = worldWidth - 380;
    const portalPlatY = 490.0;
    platforms.add(PlatformDef(
      x: portalPlatX,
      y: portalPlatY,
      width: 380,
      height: 270,
      hasCrystalAccent: true,
    ));

    // Garantizar exactamente 9 tótems
    while (totemIdx < 9) {
      totems.add(TotemDef(index: totemIdx++, x: portalPlatX + 60, y: portalPlatY));
    }

    return LevelMapData(
      level: level,
      biome: biome,
      worldWidth: worldWidth,
      worldHeight: 720,
      spawnX: 100,
      spawnY: 540,
      platforms: platforms,
      spikes: spikes,
      mushrooms: mushrooms,
      hookRings: hookRings,
      enemies: enemies,
      totems: totems,
      hearts: hearts,
      portalX: worldWidth - 150,
      portalY: portalPlatY,
    );
  }
}
