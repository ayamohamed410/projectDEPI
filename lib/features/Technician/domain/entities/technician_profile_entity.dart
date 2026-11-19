import 'package:equatable/equatable.dart';

class TechnicianProfileEntity extends Equatable {
  final String id;
  final String name;
  final String title;
  final double rating;
  final int reviewsCount;
  final String experience; // e.g. "1–3 years" (as chosen at signup)
  final int completedJobs;
  final double punctuality;
  final String about;
  final List<String> specialties;
  final List<String> coverageAreas;
  final String workingDays;
  final String workingHours;
  final bool emergencyAvailable;
  final double inspectionFee;
  final double hourlyRate;

  const TechnicianProfileEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.experience,
    required this.completedJobs,
    required this.punctuality,
    required this.about,
    required this.specialties,
    required this.coverageAreas,
    required this.workingDays,
    required this.workingHours,
    required this.emergencyAvailable,
    required this.inspectionFee,
    required this.hourlyRate,
  });

  @override
  List<Object?> get props => [id, name, rating, completedJobs];
}
