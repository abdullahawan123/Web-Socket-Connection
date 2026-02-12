import 'package:flutter/material.dart';
import 'package:web_socket_practice/single_r_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final signalR = SignalRTestService();
  await signalR.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("SignalR Test")),
        body: const Center(child: Text("Waiting for SignalR Messages…")),
      ),
    );
  }
}
