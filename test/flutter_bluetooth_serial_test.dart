import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial_method_channel.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBluetoothSerialPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBluetoothSerialPlatform {
  @override
  Future<bool> isAvailable() => Future<bool>.value(true);

  @override
  Future<bool> isEnabled() => Future<bool>.value(true);

  @override
  Future<void> openSettings() => Future<void>.value();

  @override
  Future<bool> requestEnable() => Future<bool>.value(true);
}

void main() {
  final FlutterBluetoothSerialPlatform initialPlatform =
      FlutterBluetoothSerialPlatform.instance;

  test('$MethodChannelFlutterBluetoothSerial is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelFlutterBluetoothSerial>(),
    );
  });

  test('isAvailable', () async {
    final FlutterBluetoothSerial flutterBluetoothSerialPlugin =
        FlutterBluetoothSerial();

    final MockFlutterBluetoothSerialPlatform fakePlatform =
        MockFlutterBluetoothSerialPlatform();

    FlutterBluetoothSerialPlatform.instance = fakePlatform;

    expect(await flutterBluetoothSerialPlugin.isAvailable(), true);
  });

  // TODO(anyone): isEnabled

  // TODO(anyone): openSettings

  // TODO(anyone): requestEnable
}
