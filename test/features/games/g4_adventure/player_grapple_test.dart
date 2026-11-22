import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:edplay_ft/features/games/g4_adventure/data/level_map_data.dart';
import 'package:edplay_ft/features/games/g4_adventure/presentation/components/platform_component.dart';
import 'package:edplay_ft/features/games/g4_adventure/presentation/components/player_component.dart';

void main() {
  group('PlayerComponent pendulum grapple physics', () {
    test('no se frena ni se traba cuando el péndulo pasa cerca del suelo', () {
      final theme = LevelMapData.biomeForLevel(1);
      final floor = CavernPlatformComponent(
        position: Vector2(300, 465),
        size: Vector2(300, 30),
        theme: theme,
      );
      final platforms = [floor];

      // Jugador salta debajo de un anillo bajo a solo 75px sobre la plataforma
      final player = PlayerComponent(startPosition: Vector2(400, 460));
      player.vx = 180;
      player.startGrapple(Vector2(450, 390), platforms);

      expect(player.isGrappling, isTrue);

      double minX = player.position.x;
      double maxX = player.position.x;

      // Simular 1.5 segundos de balanceo (90 frames a 60fps)
      for (var i = 0; i < 90; i++) {
        player.stepPhysics(
          dt: 1 / 60,
          moveDir: 0,
          platforms: platforms,
          worldWidth: 2700,
        );
        if (player.position.x < minX) minX = player.position.x;
        if (player.position.x > maxX) maxX = player.position.x;
        // Los pies nunca deben quedar hundidos dentro del suelo
        expect(player.position.y, lessThanOrEqualTo(floor.worldRect.top + 1));
      }

      // Debe seguir enganchado y haberse balanceado ampliamente de lado a lado
      expect(player.isGrappling, isTrue);
      expect(maxX - minX, greaterThan(45));
    });

    test('se suelta únicamente al presionar Salto y sale impulsado hacia arriba', () {
      final player = PlayerComponent(startPosition: Vector2(400, 420));
      player.startGrapple(Vector2(450, 320));
      expect(player.isGrappling, isTrue);

      player.requestJump();
      expect(player.isGrappling, isFalse);
      expect(player.vy, lessThan(-400));
      expect(player.hasDoubleJump, isTrue);
    });
  });
}
