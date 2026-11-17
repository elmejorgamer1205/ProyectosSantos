import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../model/hero_item.dart';

class MotionPicker {
  StreamSubscription<UserAccelerometerEvent>? _subscription;

  // RETO UD3 A2: suscribirse al sensor, calcular magnitud, umbral y pausa.
  void start(void Function(HeroItem) onShake, void Function(Object) onError) {
    onError(StateError('RETO UD3 A2: completar lectura del acelerómetro'));
  }

  Future<void> stop() async => _subscription?.cancel();
}
