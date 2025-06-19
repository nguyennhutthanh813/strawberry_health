import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/model/environment_conditions.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:convert';
import '';

class EnvironmentConditionsProvider with ChangeNotifier {
  EnvironmentConditions _conditions = EnvironmentConditions(
    temperature: 0.0,
    humidity: 0.0,
    // soilMoisture: 0.0,
    // lux: 0.0,
  );

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late String? uid;

  // MQTT client
  late MqttServerClient client;

  // Cấu hình MQTT(Hive MQ)
  final String server = 'fdbfeadfd02c464bace2dd0b5df1df9a.s1.eu.hivemq.cloud';
  final String clientIdentifier = 'flutter_client';
  final int port = 8883;

  bool isConnected = false;

  EnvironmentConditions get conditions => _conditions;


  Future<void> setupMQTT() async {
    print("Setting up MQTT client.....................................");
    String mqttUsername = '';
    String mqttPassword = '';
    uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid != null) {
      await fireStore.collection('users').doc(uid).get().then((doc) {
        if (doc.exists) {
          mqttUsername = doc.data()?['mqttUsername'] ?? '';
          mqttPassword = doc.data()?['mqttPassword'] ?? '';
        }
      });
      print('MQTT Username: $mqttUsername');
      print('MQTT Password: $mqttPassword');
    }else{
      return;
    }

    client = MqttServerClient.withPort(server, clientIdentifier, port);
    client.secure = true;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = (String topic) {
      debugPrint('Subscribed to topic: $topic');
    };



    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .authenticateAs("esp8266", "abc12345M")
        .startClean()
        .withWillQos(MqttQos.atMostOnce)
    ;
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      debugPrint('MQTT client connection failed - $e');
      debugPrint('👉 Connection status: ${client.connectionStatus?.state}');
      client.disconnect();
    }

    // subscribe to topics
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      debugPrint('MQTT client connected');
      client.subscribe('esp8266/dht11', MqttQos.atMostOnce);
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final message = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        debugPrint('Received: $message');

        // Update conditions with the received message
        updateConditions(message);

      });
    } else {
      debugPrint('MQTT client connection failed');
      client.disconnect();
    }
  }

  void updateConditions(String message) {
    final data = json.decode(message);
    _conditions.humidity = data['humidity']?.toDouble() ?? 0.0;
    _conditions.temperature = data['temperature']?.toDouble() ?? 0.0;
    // _conditions.soilMoisture = data['soilMoisture']?.toDouble() ?? 0.0;
    // _conditions.lux = data['lux']?.toDouble() ?? 0.0;

    notifyListeners();
  }

  void onConnected() {
    isConnected = true;
    notifyListeners();
  }

  void onDisconnected() {
    isConnected = false;
    notifyListeners();
  }


}
