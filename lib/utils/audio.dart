import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

enum SoundEvents { ButtonClick, PlacingPiece, InnerGridWin, GameWon, GameLost }

class TtnAudio {
  // Member fields
  final AudioCache player = AudioCache(prefix: 'assets/audio/');

  // Constructor
  TtnAudio() {
    // Load all the audio files when the class is instantiated to prevent lag
    player.loadAll([
      'button_click_wav',
      'piece_placement_1.mp3',
      'success_1.wav',
      'player_win_1.wav',
      'game_over_1.wav',
    ]);
  }

  void playSound(SoundEvents soundEvent) async {
    switch (soundEvent) {
      case SoundEvents.ButtonClick:
        await player.play(
          'button_click_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.5,
        );
        break;
      case SoundEvents.PlacingPiece:
        await player.play(
          'piece_placement_1.mp3',
          mode: PlayerMode.LOW_LATENCY,
        );
        break;
      case SoundEvents.InnerGridWin:
        await player.play(
          'success_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.2,
        );
        break;
      case SoundEvents.GameWon:
        await player.play(
          'player_win_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.2,
        );
        break;
      case SoundEvents.GameLost:
        await player.play(
          'game_over_1.wav',
          mode: PlayerMode.LOW_LATENCY,
          volume: 0.2,
        );
        break;
    }
  }
}
