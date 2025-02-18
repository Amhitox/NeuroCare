import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/seizure.dart';

final seizureProvider =
    StateNotifierProvider<SeizureNotifier, List<Seizure>>((ref) {
  return SeizureNotifier();
});

class SeizureNotifier extends StateNotifier<List<Seizure>> {
  SeizureNotifier() : super([]);

  void addSeizure(
    DateTime dateTime,
    String type,
    Duration duration,
    List<String> triggers, {
    String? notes,
    List<String>? symptoms,
    bool wasAlerted = false,
    String? location,
  }) {
    final newSeizure = Seizure(
      id: const Uuid().v4(),
      dateTime: dateTime,
      type: type,
      duration: duration,
      triggers: triggers,
      notes: notes,
      symptoms: symptoms,
      wasAlerted: wasAlerted,
      location: location,
    );

    state = [...state, newSeizure];
  }

  void updateSeizure(Seizure seizure) {
    state = [
      for (final s in state)
        if (s.id == seizure.id) seizure else s
    ];
  }

  void deleteSeizure(String id) {
    state = state.where((s) => s.id != id).toList();
  }

  int getSeizureCount(DateTime startDate, DateTime endDate) {
    return state
        .where((s) =>
            s.dateTime.isAfter(startDate) && s.dateTime.isBefore(endDate))
        .length;
  }

  Duration getSeizureFreeTime() {
    if (state.isEmpty) return Duration.zero;

    final lastSeizure = state.reduce(
        (curr, next) => curr.dateTime.isAfter(next.dateTime) ? curr : next);
    return DateTime.now().difference(lastSeizure.dateTime);
  }

  Map<String, int> getTriggerFrequency() {
    final Map<String, int> frequency = {};
    for (final seizure in state) {
      for (final trigger in seizure.triggers) {
        frequency[trigger] = (frequency[trigger] ?? 0) + 1;
      }
    }
    return frequency;
  }

  List<Seizure> getSeizuresByMonth(int year, int month) {
    return state
        .where((s) => s.dateTime.year == year && s.dateTime.month == month)
        .toList();
  }
}
