import 'emergency_contact.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final DateTime joinDate;
  final List<EmergencyContact> emergencyContacts;
  final List<String> medicalHistory;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.joinDate,
    required this.emergencyContacts,
    required this.medicalHistory,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      joinDate: DateTime.parse(json['joinDate']),
      emergencyContacts: (json['emergencyContacts'] as List)
          .map((e) => EmergencyContact.fromJson(e))
          .toList(),
      medicalHistory: List<String>.from(json['medicalHistory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'joinDate': joinDate.toIso8601String(),
      'emergencyContacts': emergencyContacts.map((e) => e.toJson()).toList(),
      'medicalHistory': medicalHistory,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? status,
    DateTime? joinDate,
    List<EmergencyContact>? emergencyContacts,
    List<String>? medicalHistory,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      joinDate: joinDate ?? this.joinDate,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      medicalHistory: medicalHistory ?? this.medicalHistory,
    );
  }
}
