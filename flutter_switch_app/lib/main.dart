import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebSocketChannel _channel;
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:9090'));
  }

  void _sendSwitch(bool value) {
    final msg = jsonEncode({
      'op': 'publish',
      'topic': '/switch_cmd',
      'msg': {'data': value}
    });
    _channel.sink.add(msg);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ROS2 Switch')),
        body: Center(
          child: Switch(
            value: _switchValue,
            onChanged: (val) {
              setState(() => _switchValue = val);
              _sendSwitch(val);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
