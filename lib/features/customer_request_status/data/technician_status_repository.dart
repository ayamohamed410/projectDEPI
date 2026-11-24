import 'package:cloud_firestore/cloud_firestore.dart';

class TechnicianStatusInfo {
  final String id;
  final String name;
  final String specialization;
  final String experience;

  const TechnicianStatusInfo({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
  });

  factory TechnicianStatusInfo.fromMap(String id, Map<String, dynamic> data) {
    return TechnicianStatusInfo(
      id: id,
      name: (data['name'] ?? 'Technician').toString(),
      specialization: (data['specialization'] ?? '').toString(),
      experience: (data['experience'] ?? '').toString(),
    );
  }
}

class TechnicianStatusRepository {
  final FirebaseFirestore _firestore;

  TechnicianStatusRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<TechnicianStatusInfo?> fetchTechnicianById(String technicianId) async {
    final document = await _firestore
        .collection('users')
        .doc(technicianId)
        .get();

    if (!document.exists) return null;

    final data = document.data();

    if (data == null || data['role'] != 'technician') {
      return null;
    }

    return TechnicianStatusInfo.fromMap(document.id, data);
  }
}
