import 'package:flutter_test/flutter_test.dart';

import 'package:edplay_ft/features/games/g4_adventure/data/level_map_data.dart';

void main() {
  group('LevelMapData', () {
    test('todos los niveles 1..8 tienen 9 tótems, plataformas, enemigos y portal válido', () {
      for (var level = 1; level <= 8; level++) {
        final map = LevelMapData.forLevel(level);
        expect(map.level, level);
        expect(map.totems.length, 9, reason: 'Nivel $level debe tener 9 tótems (+ 1 portal = 10)');
        expect(map.platforms, isNotEmpty, reason: 'Nivel $level debe tener plataformas');
        expect(map.hookRings, isNotEmpty, reason: 'Nivel $level debe tener anillos de enganche para el látigo');
        expect(map.enemies, isNotEmpty, reason: 'Nivel $level debe tener enemigos');
        expect(map.portalX, greaterThan(map.spawnX));
        expect(map.portalX, lessThan(map.worldWidth));
        expect(map.biome.name, isNotEmpty);
      }
    });

    test('el nivel 8 incluye al jefe final (EnemyKind.boss)', () {
      final level8 = LevelMapData.forLevel(8);
      expect(
        level8.enemies.any((e) => e.kind == EnemyKind.boss),
        isTrue,
      );
    });

    test('los 8 biomas tienen nombres únicos', () {
      final names = List.generate(8, (i) => LevelMapData.biomeForLevel(i + 1).name).toSet();
      expect(names.length, 8);
    });
  });
}
