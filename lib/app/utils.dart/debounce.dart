import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel(); // Önceki timer'ı iptal et
    _timer = Timer(delay, action); // Yeni timer başlat
  }

  void dispose() {
    _timer?.cancel();
  }
}
