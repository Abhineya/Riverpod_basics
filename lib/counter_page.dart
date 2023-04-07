import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learning/main.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> counter = ref.watch(
      counterProvider(5),
    );
    // ref.listen<int>(
    //   counterProvider,

    //   (previous, next) {
    //     if (next >= 5) {
    //       showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             title: Text('Warning'),
    //             content:
    //                 Text('Counter dangerously high. Consider resetting it.'),
    //             actions: [
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Text('OK'),
    //               )
    //             ],
    //           );
    //         },
    //       );
    //     }
    //   },
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         ref.invalidate(counterProvider);
        //       },
        //       icon: Icon(Icons.refresh))
        // ],
      ),
      body: Center(
        child: Text(
          counter
              .when(
                data: (int value) => value,
                error: (Object error, stackTrace) => error,
                loading: () => 5,
              )
              .toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     ref.read(counterProvider.notifier).state++;
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
