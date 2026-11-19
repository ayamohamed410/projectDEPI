import '../../domain/entities/technician_profile_entity.dart';

class TechnicianProfileModel extends TechnicianProfileEntity {
  const TechnicianProfileModel({
    required super.id,
    required super.name,
    required super.title,
    required super.rating,
    required super.reviewsCount,
    required super.experience,
    required super.completedJobs,
    required super.punctuality,
    required super.about,
    required super.specialties,
    required super.coverageAreas,
    required super.workingDays,
    required super.workingHours,
    required super.emergencyAvailable,
    required super.inspectionFee,
    required super.hourlyRate,
  });

  /// Reads the `users/{uid}` document. Fields that the signup flow does not
  /// create yet (rating, completedJobs, ...) fall back to safe defaults.
  factory TechnicianProfileModel.fromJson(Map<String, dynamic> json) {
    final String? specialization = json['specialization'] as String?;

    return TechnicianProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '${specialization ?? 'Technician'} Technician',


    //  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      rating: (json['ratingAvg'] as num?)?.toDouble() ??
          (json['rating'] as num?)?.toDouble() ??
          0.0,

      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      experience: (json['experience'] as String?) ?? '-',


    //  completedJobs: (json['completedJobs'] as num?)?.toInt() ?? 0,
      completedJobs: (json['completedJobsCount'] as num?)?.toInt() ??
          (json['completedJobs'] as num?)?.toInt() ??
          0,

      punctuality: (json['punctuality'] as num?)?.toDouble() ?? 0.0,
      about: json['about'] ?? 'No description added yet.',
      specialties: json['specialties'] != null
          ? List<String>.from(json['specialties'])
          : [if (specialization != null) specialization],
      coverageAreas: json['coverageAreas'] != null
          ? List<String>.from(json['coverageAreas'])
          : <String>[],
      workingDays: json['workingDays'] ?? 'Monday – Saturday',
      workingHours: json['workingHours'] ?? '8:00 AM – 9:00 PM',
      emergencyAvailable: json['emergencyAvailable'] ?? false,
      inspectionFee: (json['inspectionFee'] as num?)?.toDouble() ?? 100,
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 200,
    );
  }
}
