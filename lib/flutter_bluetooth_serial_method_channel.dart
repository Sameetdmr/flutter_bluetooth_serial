import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/bluetooth_state.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial_platform_interface.dart';

class MethodChannelFlutterBluetoothSerial
    extends FlutterBluetoothSerialPlatform {
  static const String namespace = 'flutter_bluetooth_serial';

  @visibleForTesting
  final EventChannel stateChannel = const EventChannel('$namespace/state');

  @override
  Stream<BluetoothState> onStateChanged() {
    return stateChannel.receiveBroadcastStream().map(BluetoothState.parse);
  }

  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel('$namespace/methods');

  @override
  Future<bool> isAvailable() async {
    return (await methodChannel.invokeMethod<bool>('isAvailable')) ?? false;
  }

  @override
  Future<bool> isEnabled() async {
    return (await methodChannel.invokeMethod<bool>('isEnabled')) ?? false;
  }

  @override
  Future<void> openSettings() async =>
      methodChannel.invokeMethod<void>('openSettings');

  @override
  Future<bool> requestEnable() async {
    return (await methodChannel.invokeMethod<bool>('requestEnable')) ?? false;
  }

  @override
  Future<bool> requestDisable() async {
    return (await methodChannel.invokeMethod<bool>('requestDisable')) ?? false;
  }

  @override
  Future<bool> ensurePermissions() async =>
      (await methodChannel.invokeMethod<bool>('ensurePermissions')) ?? false;

  @override
  Future<String?> getAddress() =>
      methodChannel.invokeMethod<String>('getAddress');

  @override
  Future<BluetoothState> getState() async => BluetoothState.parse(
        (await methodChannel.invokeMethod<int>('getState')) ?? -2,
      );

  @override
  Future<String?> getName() => methodChannel.invokeMethod<String>('getName');

  @override
  Future<bool> setName(final String name) async =>
      (await methodChannel.invokeMethod<bool>(
        'setName',
        <String, dynamic>{'name': name},
      )) ??
      false;

  @override
  Future<bool> isDiscoverable() async =>
      (await methodChannel.invokeMethod<bool>('isDiscoverable')) ?? false;

  @override
  Future<int?> requestDiscoverable({final int? durationInSeconds}) =>
      methodChannel.invokeMethod<int>(
        'requestDiscoverable',
        durationInSeconds == null
            ? null
            : <String, dynamic>{
                'duration': durationInSeconds,
              },
      );

  @override
  Future<bool> isDiscovering() async =>
      (await methodChannel.invokeMethod<bool>('isDiscovering')) ?? false;
}
