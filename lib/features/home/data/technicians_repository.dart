import 'package:cloud_firestore/cloud_firestore.dart';

class TechnicianInfo {
  final String id;
  final String name;
  final String specialization;
  final String experience;

  const TechnicianInfo({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
  });

  factory TechnicianInfo.fromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    return TechnicianInfo(
      id: doc.id,
      name: (data['name'] ?? 'Technician').toString(),
      specialization: (data['specialization'] ?? '').toString(),
      experience: (data['experience'] ?? '').toString(),
    );
  }
}

abstract class TechniciansRepository {
  Future<List<TechnicianInfo>> fetchForCategory(String category);
}

class FirestoreTechniciansRepository implements TechniciansRepository {
  FirestoreTechniciansRepository(this.firestore);
  final FirebaseFirestore firestore;

  @override
  Future<List<TechnicianInfo>> fetchForCategory(String category) async {
    // This matches the ACTUAL schema in auth_remote_data_source_impl.dart:
    // users/{uid}: role, name, specialization, experience.
    final snapshot = await firestore
        .collection('technician_public_profiles')
        .get();
    final all = snapshot.docs.map(TechnicianInfo.fromDoc);
    final wanted = _normalizedCategory(category);
    final matches = all
        .where((tech) => _normalizedCategory(tech.specialization) == wanted)
        .toList();
    matches.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    return matches;
  }
}

String _normalizedCategory(String raw) {
  final text = raw.trim().toLowerCase();
  if (text == 'hvac' || text == 'ac & cooling' || text == 'air conditioning') {
    return 'air conditioning';
  }
  if (text == 'electrical' || text == 'electrician') return 'electrical';
  if (text == 'plumber' || text == 'plumbing') return 'plumbing';
  if (text == 'carpenter' || text == 'carpentry') return 'carpentry';
  if (text == 'painter' || text == 'painting') return 'painting';
  if (text == 'appliances' || text == 'repairs & maintenance') {
    return 'repairs & maintenance';
  }
  return text;
}
