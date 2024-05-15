import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 入力値を管理するProvider
final inputValueProvider = StateProvider((ref) => '');

// タイマー値を管理するProvider
final timerValueProvider = StateProvider((ref) => 0);

// BottomNavigationBarの選択インデックスを管理するProvider
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input and Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: bottomNavIndex,
        children: const [
          InputTab(),
          TimerTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Input',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
        ],
      ),
    );
  }
}

class InputTab extends ConsumerWidget {
  const InputTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputValue = ref.watch(inputValueProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) {
              ref.read(inputValueProvider.notifier).state = value;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Input Value: $inputValue',
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class TimerTab extends ConsumerWidget {
  const TimerTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerValue = ref.watch(timerValueProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Timer Value: $timerValue',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(timerValueProvider.notifier).state++;
            },
            child: const Text('Increment Timer'),
          ),
        ],
      ),
    );
  }
}