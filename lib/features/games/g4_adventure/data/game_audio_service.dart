import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';

/// Servicio ligero de efectos de sonido alegres para La Aventura de Lumi.
///
/// Usa archivos WAV livianos en `assets/audio/games/g4/` compatibles con Web,
/// macOS, Android e iOS, con control reactivo de silencio (`soundEnabled`).
class GameAudioService {
  GameAudioService._();

  static final ValueNotifier<bool> soundEnabled = ValueNotifier<bool>(true);

  static void toggleSound() {
    soundEnabled.value = !soundEnabled.value;
  }

  static void playJump() => _play('games/g4/sfx_jump.wav', volume: 0.45);
  static void playWhip() => _play('games/g4/sfx_whip.wav', volume: 0.42);
  static void playBounce() => _play('games/g4/sfx_bounce.wav', volume: 0.50);
  static void playStar() => _play('games/g4/sfx_star.wav', volume: 0.42);
  static void playCorrect() => _play('games/g4/sfx_correct.wav', volume: 0.55);
  static void playWrong() => _play('games/g4/sfx_wrong.wav', volume: 0.42);
  static void playVictory() => _play('games/g4/sfx_victory.wav', volume: 0.60);

  static void _play(String file, {double volume = 0.5}) {
    if (!soundEnabled.value) return;
    try {
      // Evita fallos en tests unitarios puros de Dart sin binding inicializado.
      WidgetsBinding.instance;
    } catch (_) {
      return;
    }
    try {
      FlameAudio.play(file, volume: volume).then<void>((_) {}, onError: (_) {});
    } catch (_) {}
  }
}
