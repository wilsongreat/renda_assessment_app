import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({required this.duration});
  final int duration;
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: duration), action);
  }
}
