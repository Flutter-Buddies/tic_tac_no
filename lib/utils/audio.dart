import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore_for_file: constant_identifier_names
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
      'piece_placement.mp3',
      'success.mp3',
      'player_win.mp3',
      'game_over.mp3',
    ]);
  }

  Future<void> playSound(GameSounds soundEvent) async {
    switch (soundEvent) {
      case GameSounds.PlacingPiece:
        await player.play(
          'piece_placement.mp3',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.5 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
      case GameSounds.InnerGridWin:
        await player.play(
          'success.mp3',
          mode: PlayerMode.LOW_LATENCY,
          volume: 1 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
      case GameSounds.GameWon:
        // Need to wait for inner grid win to finish playing
        await Future.delayed(const Duration(milliseconds: 500));
        await player.play(
          'player_win.mp3',
          mode: PlayerMode.LOW_LATENCY,
          volume: 1 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
      case GameSounds.GameLost:
        // Ned to wait for innter grid win the finish playing
        await Future.delayed(const Duration(milliseconds: 500));
        await player.play(
          'game_over.mp3',
          mode: PlayerMode.LOW_LATENCY,
          volume: 1 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
    }
  }
}

class UIAudio extends BaseAudio {
  @override
  void preloadSounds() {
    player.loadAll(['button_click.mp3']);
  }

  Future<void> playSound(UISounds uiSound) async {
    switch (uiSound) {
      case UISounds.ButtonClick:
        await player.play(
          'button_click.mp3',
          mode: PlayerMode.LOW_LATENCY,
          volume: 1 * (super.isMuted ? 0.0 : 1.0),
        );
        break;
    }
  }
}
