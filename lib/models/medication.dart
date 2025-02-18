import 'package:flutter/material.dart';

class Medication {
  final String id;
  final String name;
  final String dosage;
  final int pillCount;
  final List<TimeOfDay> schedule;
  final int remainingPills;
  final String instructions;
  final bool isActive;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.pillCount,
    required this.schedule,
    required this.remainingPills,
    required this.instructions,
    this.isActive = true,
  });

  Medication copyWith({
    String? id,
    String? name,
    String? dosage,
    int? pillCount,
    List<TimeOfDay>? schedule,
    int? remainingPills,
    String? instructions,
    bool? isActive,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      pillCount: pillCount ?? this.pillCount,
      schedule: schedule ?? this.schedule,
      remainingPills: remainingPills ?? this.remainingPills,
      instructions: instructions ?? this.instructions,
      isActive: isActive ?? this.isActive,
    );
  }
}
