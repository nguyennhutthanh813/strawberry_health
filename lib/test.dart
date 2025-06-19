import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MQTT HiveMQ Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('MQTT HiveMQ')),
        body: const Center(child: MqttClientWidget()),
      ),
    );
  }
}

class MqttClientWidget extends StatefulWidget {
  const MqttClientWidget({super.key});

  @override
  State<MqttClientWidget> createState() => _MqttClientWidgetState();
}

class _MqttClientWidgetState extends State<MqttClientWidget> {
  late MqttServerClient client;
  String status = 'Disconnected';

  final String serverUri = 'fdbfeadfd02c464bace2dd0b5df1df9a.s1.eu.hivemq.cloud';
  final int port = 8883;
  final String username = 'esp8266';
  final String password = 'abc12345M';
  final String clientId = 'flutter_client';

  @override
  void initState() {
    super.initState();
    connectToBroker();
  }

  Future<void> connectToBroker() async {
    client = MqttServerClient.withPort(serverUri, clientId, port);
    client.secure = true; // Sử dụng TLS
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(username, password)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        print("dit me connect roi, du con me chung may");
      }
      } catch (e) {
      setState(() {
        status = 'Connection failed: $e';
      });
      client.disconnect();
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final payload =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      setState(() {
        status = 'Received: $payload';
      });
    });

    // Đăng ký nhận dữ liệu từ topic của ESP8266 (ví dụ "sensor/data")
    client.subscribe('sensor/data', MqttQos.atMostOnce);
  }

  void _onDisconnected() {
    setState(() {
      status = 'Disconnected';
    });
  }

  void _onConnected() {
    setState(() {
      status = 'Connected to $serverUri';
    });
  }

  void _onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  @override
  Widget build(BuildContext context) {
    return Text(status, style: const TextStyle(fontSize: 16));
  }
}
