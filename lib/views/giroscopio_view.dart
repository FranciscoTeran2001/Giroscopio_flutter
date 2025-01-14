// lib/views/gyro_view.dart
import 'package:flutter/material.dart';
import '../controllers/giroscopio_controller.dart';
import '../models/giroscopio.dart';

class GyroView extends StatefulWidget {
  @override
  _GyroViewState createState() => _GyroViewState();
}

class _GyroViewState extends State<GyroView> {
  final GyroController _controller = GyroController();

  @override
  void initState() {
    super.initState();
    _controller.initGyroscope();
    _controller.connectWebSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Control de giroscopio')),
      body: StreamBuilder<GiroscopioData>(
        stream: _controller.gyroDataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Connection: ${_controller.isConnected ? "Conectado" : "Desconectado"}'),
                Text('X: ${snapshot.data!.x.toStringAsFixed(2)}'),
                Text('Y: ${snapshot.data!.y.toStringAsFixed(2)}'),
                Text('Z: ${snapshot.data!.z.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
