// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "global": {
    "app_name": "Tic-Tac-No"
  },
  "game": {
    "are_you_sure_quit": "Are you sure you'd like to quit?",
    "all_progress_lost": "All progress will be lost",
    "quit_game": "QUIT GAME",
    "return_to_game": "RETURN TO GAME",
    "quit_to_menu": "QUIT TO MENU",
    "play_again": "PLAY AGAIN",
    "win": "win!",
    "wins": "wins!",
    "won": "won!",
    "nobody_wins": "Nobody wins 😲",
    "thinking": "Thinking...",
    "player_no_name": "No name"
  },
  "menu": {
    "online_multiplayer": "ONLINE MULTIPLAYER",
    "coming_soon": "Coming Soon!",
    "how_to_play": "How to play",
    "easy": "EASY",
    "medium": "MEDIUM",
    "hard": "HARD",
    "single_player_setup": "SINGLE PLAYER SETUP",
    "local_multiplayer_setup": "LOCAL MULTIPLAYER SETUP",
    "online_multiplayer_setup": "ONLINE MULTIPLAYER SETUP",
    "searching_for_game": "Searching for game...",
    "you": "YOU",
    "player_1": "PLAYER 1",
    "player_2": "PLAYER 2",
    "ai": "AI",
    "start_game": "START GAME",
    "tic": "TIC",
    "tac": "TAC",
    "no": "NO",
    "local_multiplayer": "LOCAL MULTIPLAYER",
    "single_player": "SINGLE PLAYER",
    "change_language": "Language"
  },
  "rules": {
    "rules": "Rules",
    "previous": "Previous",
    "next": "Next",
    "start": "Start",
    "good_luck": "Good luck!",
    "tic_must_win": "You’re faced with a tic-tac-toe board you must win.",
    "there_is_catch": "But there’s a catch... each board is part of a bigger tic-tac-toe board!",
    "win_inner_grid": "You must win the inner-grid to claim the position on the main-grid. Once you claim it, no one can claim it again.",
    "one_more_thing": "Easy? There’s one more thing... your move within the inner-grid determines the inner-grid your opponent can play."
  }
};
static const Map<String,dynamic> ar = {
  "global": {
    "app_name": "تيك تاك نو"
  },
  "game": {
    "are_you_sure_quit": "هل أنت متأكد أنك تريد إنهاء اللعبة؟",
    "all_progress_lost": "سيضيع كل التقدم",
    "quit_game": "إنهاء اللعبة",
    "return_to_game": "العودة إلى اللعبة",
    "win": "فاز!",
    "wins": "يفوز!",
    "nobody_wins": "لم يفز أحد 😲",
    "thinking": "جاري التفكير...",
    "player_no_name": "بدون اسم"
  },
  "menu": {
    "online_multiplayer": "العب اونلاين",
    "coming_soon": "قريبا!",
    "how_to_play": "كيف العب",
    "easy": "سهل",
    "medium": "متوسط",
    "hard": "صعب",
    "single_player_setup": "إعدادات لاعب واحد",
    "local_multiplayer_setup": "إعدادات العب مع صديقك",
    "online_multiplayer_setup": "إعدادات العب اونلاين",
    "searching_for_game": "جاري البحث عن لعبة...",
    "you": "أنت",
    "player_1": "لاعب 1",
    "player_2": "لاعب 2",
    "ai": "الكمبيوتر",
    "start_game": "بدء اللعبة",
    "tic": "تيك",
    "tac": "تاك",
    "no": "نو",
    "local_multiplayer": "العب مع صديقك",
    "single_player": "لاعب واحد",
    "change_language": "تغيير اللغة"
  },
  "rules": {
    "rules": "القواعد",
    "previous": "السابق",
    "next": "التالي",
    "start": "بدء",
    "good_luck": "حظا طيبا وفقك الله!",
    "tic_must_win": "يجب أن تفوز بلوحة الـtic-tac-toe.",
    "there_is_catch": "ولكن هناك مشكلة ... كل لوح هو جزء من لوحة الـtic-tac-toe أكبر!",
    "win_inner_grid": "يجب أن تفوز في لوحة الـtic-tac-toe صغيرة لتحصل على لمكان في اللوحة الكبيرة. بمجرد حصولك عليها لا يمكن أن يأخخذها أحد منك.",
    "one_more_thing": "سهلة؟ باقي شيء واحد... حركتك في لوح داخلي تحدد وين خصمك يلعب."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ar": ar};
}
