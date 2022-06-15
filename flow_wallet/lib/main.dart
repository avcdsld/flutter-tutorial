
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flow_dart_sdk/fcl/fcl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Flow Dart SDK Demo', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () => showDemoPage(context),
              child: const Text('Start')),
        ]),
      ),
    );
  }

  void showDemoPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DemoPage()),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Dart SDK Demo'),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => executeScript(),
                child: const Text('Execute Script'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void executeScript() async {
      const endpoint = "localhost";
      const port = FlowClient.FLOW_EMULATOR_PORT;
      // ignore: unused_local_variable
      final FlowClient flow = FlowClient(endpoint, port);

      const code = '''
        pub fun main(): Int {
          log("Hello from FlowClient");
          return 42
        }
      ''';

      final result = await flow.executeScript(code);
      final decoded = flow.decodeResponse(result);

      // ignore: avoid_print
      print(result);
      // ignore: avoid_print
      print(decoded);
      // ignore: avoid_print
      print("✅ Done");
  }
}

class TilesView extends StatelessWidget {
  final List<int> numbers;
  final bool isCorrect;
  final void Function(int number) onPressed;

  const TilesView({
    Key? key,
    required this.numbers,
    required this.isCorrect,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // グリッド状にWidgetを並べる
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: numbers // 受け取ったデータを元に表示する
          .map((number) {
        if (number == 0) {
          return Container();
        }
        return TileView(
          number: number,
          // 正解の場合は色を変える
          color: isCorrect ? Colors.green : Colors.blue,
          // コールバックでタップされたことを伝える
          onPressed: () => onPressed(number),
        );
      }).toList(),
    );
  }
}

class TileView extends StatelessWidget {
  final int number;
  final Color color;
  final void Function() onPressed;

  const TileView({
    Key? key,
    required this.number,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        textStyle: const TextStyle(fontSize: 32),
      ),
      child: Center(
        child: Text(number.toString()),
      ),
    );
  }
}
