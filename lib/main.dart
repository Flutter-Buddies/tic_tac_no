import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/bloc_observer.dart';

import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider(
    create: (context) => GameBloc(),
    child: App(),
  ));
}
