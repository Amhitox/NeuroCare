class Userr {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final DateTime joinDate;
  final List<String> medicalHistory;

  Userr({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.joinDate,
    required this.medicalHistory,
  });

  factory Userr.fromJson(Map<String, dynamic> json) {
    try {
      return Userr(
        id: json['id']?.toString() ?? '0',
        name: json['name']?.toString() ?? 'No Name',
        phone: json['phone']?.toString() ?? 'No phone',
        status: json['status']?.toString() ?? 'active',
        email: json['email']?.toString() ?? 'default',
        medicalHistory: json['medicalHistory'] is List
            ? List<String>.from(
                json['medicalHistory'].map((item) => item.toString()))
            : [],
        joinDate: DateTime.tryParse(json['joinDate']?.toString() ?? '') ??
            DateTime.now(),
      );
    } catch (e) {
      print("Error in fromJson: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'joinDate': joinDate.toIso8601String(),
      'medicalHistory': medicalHistory,
    };
  }

  Userr copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? status,
    DateTime? joinDate,
    List<String>? medicalHistory,
  }) {
    return Userr(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      joinDate: joinDate ?? this.joinDate,
      medicalHistory: medicalHistory ?? this.medicalHistory,
    );
  }
}
