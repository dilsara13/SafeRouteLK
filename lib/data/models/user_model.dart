class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final List<EmergencyContact> emergencyContacts;
  final UserPreferences preferences;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.emergencyContacts,
    required this.preferences,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'emergencyContacts': emergencyContacts.map((c) => c.toMap()).toList(),
      'preferences': preferences.toMap(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      emergencyContacts: (map['emergencyContacts'] as List)
          .map((c) => EmergencyContact.fromMap(c))
          .toList(),
      preferences: UserPreferences.fromMap(map['preferences']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

class EmergencyContact {
  final String id;
  final String name;
  final String phone;
  final String relationship;
  final bool isPrimary;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phone,
    required this.relationship,
    required this.isPrimary,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'relationship': relationship,
      'isPrimary': isPrimary,
    };
  }

  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      relationship: map['relationship'],
      isPrimary: map['isPrimary'],
    );
  }
}

class UserPreferences {
  final bool autoDetectDistress;
  final bool voiceInterfaceEnabled;
  final bool shareLiveLocation;
  final List<String> distressKeywords;
  final String fakeCallDefault;
  final int alertCheckInterval;

  UserPreferences({
    this.autoDetectDistress = true,
    this.voiceInterfaceEnabled = true,
    this.shareLiveLocation = true,
    this.distressKeywords = const [
      'help',
      'danger',
      'scared',
      'unsafe',
      'emergency',
    ],
    this.fakeCallDefault = 'dad',
    this.alertCheckInterval = 5,
  });

  Map<String, dynamic> toMap() {
    return {
      'autoDetectDistress': autoDetectDistress,
      'voiceInterfaceEnabled': voiceInterfaceEnabled,
      'shareLiveLocation': shareLiveLocation,
      'distressKeywords': distressKeywords,
      'fakeCallDefault': fakeCallDefault,
      'alertCheckInterval': alertCheckInterval,
    };
  }

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      autoDetectDistress: map['autoDetectDistress'] ?? true,
      voiceInterfaceEnabled: map['voiceInterfaceEnabled'] ?? true,
      shareLiveLocation: map['shareLiveLocation'] ?? true,
      distressKeywords: List<String>.from(map['distressKeywords'] ?? []),
      fakeCallDefault: map['fakeCallDefault'] ?? 'dad',
      alertCheckInterval: map['alertCheckInterval'] ?? 5,
    );
  }
}
