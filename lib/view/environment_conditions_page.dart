import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:strawberry_disease_detection/common/widget/sensor_row.dart';

import 'package:strawberry_disease_detection/provider/environment_conditions_provider.dart';

class EnvironmentConditionsPage extends StatefulWidget{
  const EnvironmentConditionsPage({super.key});

  @override
  _EnvironmentConditionsPageState createState() => _EnvironmentConditionsPageState();
}

class _EnvironmentConditionsPageState extends State<EnvironmentConditionsPage> {
  bool ledStatus = false;
  bool relayStatus = false;
  String statusMessage = "Chưa kết nối";

  final String topicControl = 'esp8266/control';
  final String topicStatus = 'esp8266/status';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final environmentConditions = Provider.of<EnvironmentConditionsProvider>(context, listen: false);
      environmentConditions.setupMQTT();
    });
  }

  // void publishMessage(String message) {
  //   if (isConnected) {
  //     final builder = MqttClientPayloadBuilder();
  //     builder.addString(message);
  //     client.publishMessage(topicControl, MqttQos.atLeastOnce, builder.payload!);
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    final environmentConditions = Provider.of<EnvironmentConditionsProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Trạng thái kết nối
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        environmentConditions.isConnected ? Icons.wifi : Icons.wifi_off,
                        color: environmentConditions.isConnected ? Colors.green : Colors.red,
                        size: 48,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Trạng thái: ${environmentConditions.isConnected ? "Đã kết nối" : "Chưa kết nối"}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(statusMessage),
                    ],
                  ),
                ),
              ),
              SensorRow(imagePath: "assets/images/thermometer.png", title: "Temperature", value: "25°C"),
              SensorRow(imagePath: "assets/images/humidity.png", title: "Humidity", value: "25°C"),
              SensorRow(imagePath: "assets/images/sun.png", title: "Temperature", value: "25°C"),
        
              SizedBox(height: 20),
        
              // Điều khiển LED
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Điều khiển LED', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: environmentConditions.isConnected ? () {
                              setState(() { ledStatus = true; });
                            } : null,
                            icon: Icon(Icons.lightbulb),
                            label: Text('Bật LED'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: environmentConditions.isConnected ? () {
                              setState(() { ledStatus = false; });
                            } : null,
                            icon: Icon(Icons.lightbulb_outline),
                            label: Text('Tắt LED'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text('LED: ${ledStatus ? "Bật" : "Tắt"}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
        
              SizedBox(height: 20),
        
              // Điều khiển Relay
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Điều khiển Relay', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: environmentConditions.isConnected ? () {
                              setState(() { relayStatus = true; });
                            } : null,
                            icon: Icon(Icons.power),
                            label: Text('Bật Relay'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: environmentConditions.isConnected ? () {
                              setState(() { relayStatus = false; });
                            } : null,
                            icon: Icon(Icons.power_off),
                            label: Text('Tắt Relay'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text('Relay: ${relayStatus ? "Bật" : "Tắt"}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
        
              SizedBox(height: 20),
        
              // Nút kết nối lại
        
            ],
          ),
        ),
      ),
    );
  }

}