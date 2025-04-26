import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:isar/isar.dart';
import '../modelBT/bluetooth_data.dart';
import '../maincar.dart'; // Importa la instancia global de Isar

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
      if (!mounted) return; // Verifica si el widget sigue montado

      setState(() {
        _connectedDevice = device;
      });

      // Descubrir servicios y características del dispositivo
      final services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.notify) {
            // Configurar notificaciones para recibir datos
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              final receivedData = String.fromCharCodes(value);

              // Guardar los datos en la base de datos Isar
              final bluetoothData = BluetoothData()
                ..deviceName = device.name.isNotEmpty ? device.name : "Dispositivo sin nombre"
                ..deviceAddress = device.id.toString()
                ..receivedData = receivedData
                ..timestamp = DateTime.now();

              isar.writeTxn(() async {
                await isar.bluetoothDatas.put(bluetoothData);
              });

              if (mounted) {
                // Mostrar los datos recibidos en la interfaz
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Datos recibidos: $receivedData')),
                );
              }
            });
          }
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Conectado a ${device.name}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al conectar con el dispositivo: $e')),
        );
      }
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
                      const SizedBox(height: 20),
                      Expanded(
                        child: FutureBuilder<List<BluetoothData>>(
                          future: isar.bluetoothDatas.where().findAll(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            final data = snapshot.data!;
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final bluetoothData = data[index];
                                return ListTile(
                                  title: Text(bluetoothData.deviceName),
                                  subtitle: Text(
                                    'Datos: ${bluetoothData.receivedData}\n'
                                    'Fecha: ${bluetoothData.timestamp}',
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}