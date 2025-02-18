import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/medication.dart';

final medicationProvider =
    StateNotifierProvider<MedicationNotifier, List<Medication>>((ref) {
  return MedicationNotifier();
});

class MedicationNotifier extends StateNotifier<List<Medication>> {
  MedicationNotifier() : super([]);

  void addMedication(
    String name,
    String dosage,
    int pillCount,
    List<TimeOfDay> schedule,
    String instructions,
  ) {
    final newMed = Medication(
      id: const Uuid().v4(),
      name: name,
      dosage: dosage,
      pillCount: pillCount,
      schedule: schedule,
      remainingPills: pillCount,
      instructions: instructions,
    );

    state = [...state, newMed];
  }

  void updateMedication(Medication medication) {
    state = [
      for (final med in state)
        if (med.id == medication.id) medication else med
    ];
  }

  void deleteMedication(String id) {
    state = state.where((med) => med.id != id).toList();
  }

  void takeMedication(String id) {
    state = [
      for (final med in state)
        if (med.id == id)
          med.copyWith(remainingPills: med.remainingPills - 1)
        else
          med
    ];
  }

  List<Medication> getActiveMedications() {
    return state.where((med) => med.isActive).toList();
  }

  List<Medication> getMedicationsDueNow() {
    final now = TimeOfDay.now();
    return state.where((med) {
      return med.isActive &&
          med.schedule.any((time) {
            // Consider a 30-minute window for taking medication
            final dueTime = time.hour * 60 + time.minute;
            final currentTime = now.hour * 60 + now.minute;
            return (currentTime - dueTime).abs() <= 30;
          });
    }).toList();
  }
}
