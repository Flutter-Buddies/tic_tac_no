import 'dart:math';

int get aiThinkingTime => 200 + Random().nextInt(1000);

Future<void> wait_think() async {
  await Future.delayed(Duration(milliseconds: aiThinkingTime));
}

Future<void> wait_250ms() async {
  await Future.delayed(const Duration(milliseconds: 250));
}

Future<void> wait_650ms() async {
  await Future.delayed(const Duration(milliseconds: 650));
}

Future<void> wait_1s() async {
  await Future.delayed(const Duration(milliseconds: 1000));
}

Future<void> wait_2s() async {
  await Future.delayed(const Duration(milliseconds: 2000));
}

Future<void> wait_3s() async {
  await Future.delayed(const Duration(milliseconds: 3000));
}

Future<void> wait_5s() async {
  await Future.delayed(const Duration(milliseconds: 5000));
}

Future<void> wait_custom({int milliseconds = 0}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

extension AsyncVoidCallbackExt on Future<void> Function() {
  Future<void> executeNTimes(int n) async {
    for (var i = 0; i < n; i++) {
      await this();
    }
  }

  Future<void> execute3Times() async => executeNTimes(3);

  Future<void> execute5Times() async => executeNTimes(5);

  Future<void> execute10Times() async => executeNTimes(10);
}
