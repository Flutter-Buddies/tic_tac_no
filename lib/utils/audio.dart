import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

enum GameSounds { PlacingPiece, InnerGridWin, GameWon, GameLost }
enum UISounds { ButtonClick }

abstract class BaseAudio {
  final AudioCache player = AudioCache(prefix: 'assets/audio/');

  void preloadSounds();

  bool isMuted = false;

  void switchMute() {
    isMuted = !isMuted;
  }
}

class GameAudio extends BaseAudio {
  @override
  void preloadSounds() {
    player.loadAll([
      'piece_placement_1.mp3',
      'success_1.wav',
      'player_win_1.wav',
      'game_over_1.wav',
    ]);
  }

  void playSound(GameSounds soundEvent) async {
    switch (soundEvent) {
      case GameSounds.PlacingPiece:
        await player.play('piece_placement_1.mp3',
            mode: PlayerMode.LOW_LATENCY,
            volume: 1.0 * (super.isMuted ? 0.0 : 1.0));
        break;
      case GameSounds.InnerGridWin:
        await player.play(
          'success_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.2 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
      case GameSounds.GameWon:
        // Need to wait for inner grid win to finish playing
        await Future.delayed(const Duration(milliseconds: 500));
        await player.play(
          'player_win_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.2 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
      case GameSounds.GameLost:
        // Ned to wait for innter grid win the finish playing
        await Future.delayed(const Duration(milliseconds: 500));
        await player.play(
          'game_over_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.2 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
    }
  }
}

class UIAudio extends BaseAudio {
  @override
  void preloadSounds() {
    player.loadAll([
      'button_click_1.wav',
    ]);
  }

  void playSound(UISounds uiSound) async {
    switch (uiSound) {
      case UISounds.ButtonClick:
        await player.play(
          'button_click_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.5 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
    }
  }
}
