import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _connectedDevice;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStartScan();
  }

  Future<void> _checkPermissionsAndStartScan() async {
    // Solicitar permisos de Bluetooth y ubicación
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.locationWhenInUse.request().isGranted) {
      _startScan();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permisos de Bluetooth y ubicación denegados')),
      );
    }
  }

  void _startScan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!_devicesList.contains(result.device)) {
          setState(() {
            _devicesList.add(result.device);
          });
        }
      }
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() {
        _connectedDevice = device;
      });

      // Aquí puedes manejar la conexión al dispositivo Bluetooth
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conectado a ${device.name}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar con el dispositivo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _connectedDevice == null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _devicesList.length,
                    itemBuilder: (context, index) {
                      final device = _devicesList[index];
                      final deviceName = device.name.isNotEmpty
                          ? device.name
                          : 'Dispositivo sin nombre';
                      final deviceAddress = device.id.toString();

                      return ListTile(
                        title: Text(deviceName),
                        subtitle: Text('Dirección MAC: $deviceAddress'),
                        onTap: () => _connectToDevice(device),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Conectado a ${_connectedDevice!.name}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _connectedDevice = null;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Desconectado')),
                          );
                        },
                        child: const Text('Desconectar'),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}