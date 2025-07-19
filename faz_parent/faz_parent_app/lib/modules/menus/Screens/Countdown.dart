import 'dart:async';
import 'package:get/get.dart';

class CountdownController extends GetxController {
  var countdowns = <CountdownItem>[].obs;
  final Map<String, Timer> _timers = {};

  void addCountdown(String id, DateTime targetDate) {
    final countdown = CountdownItem(id: id, targetDate: targetDate);
    countdowns.add(countdown);

    _timers[id] = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final diff = targetDate.difference(now);

      if (diff.isNegative) {
        countdown.timeLeft.value = "Countdown Finished!";
        _timers[id]?.cancel();
      } else {
        final days = diff.inDays;
        final hours = diff.inHours % 24;
        final minutes = diff.inMinutes % 60;
        final seconds = diff.inSeconds % 60;

        countdown.timeLeft.value =
        "$days days, $hours hrs, $minutes min, $seconds sec";
      }
    });
  }

  @override
  void onClose() {
    _timers.forEach((_, timer) => timer.cancel());
    super.onClose();
  }
}
class CountdownItem {
  final String id;
  final DateTime targetDate;
  RxString timeLeft = ''.obs;

  CountdownItem({required this.id, required this.targetDate});
}