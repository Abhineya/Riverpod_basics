import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learning/home.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

abstract class WebsocketClient {
  Stream<int> getCounterStream();
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while (true) {
      yield i++;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}

final webSocketClientProvider = Provider<FakeWebsocketClient>(
  (ref) {
    return FakeWebsocketClient();
  },
);

final counterProvider =
    StreamProvider.autoDispose.family<int, int>((ref, start) {
  final wsClient = ref.watch(webSocketClientProvider);
  return wsClient.getCounterStream(start);
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
          surface: Color(0xff003909),
        ),
      ),
      home: HomePage(),
    );
  }
}
