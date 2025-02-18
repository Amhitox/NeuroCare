class Seizure {
  final String id;
  final DateTime dateTime;
  final String type;
  final Duration duration;
  final List<String> triggers;
  final String? notes;
  final List<String>? symptoms;
  final bool wasAlerted; // If emergency contacts were notified
  final String? location;

  Seizure({
    required this.id,
    required this.dateTime,
    required this.type,
    required this.duration,
    required this.triggers,
    this.notes,
    this.symptoms,
    this.wasAlerted = false,
    this.location,
  });

  Seizure copyWith({
    String? id,
    DateTime? dateTime,
    String? type,
    Duration? duration,
    List<String>? triggers,
    String? notes,
    List<String>? symptoms,
    bool? wasAlerted,
    String? location,
  }) {
    return Seizure(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      triggers: triggers ?? this.triggers,
      notes: notes ?? this.notes,
      symptoms: symptoms ?? this.symptoms,
      wasAlerted: wasAlerted ?? this.wasAlerted,
      location: location ?? this.location,
    );
  }
}
