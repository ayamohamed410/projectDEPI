import '../logic/ai_analysis_bloc.dart';

class AiAnalysisException implements Exception {
  final String message;
  const AiAnalysisException(this.message);
}

abstract class AiAnalysisRepository {
  Future<AiReport> analyze({required String category, required String summary,
    required String description, String location, List<String> imagePaths});
}

/// DEMO ONLY. Replace with a backend API implementation before release.
/// These outputs are illustrative, NOT Gemini diagnoses or verified prices.
class DemoAiAnalysisRepository implements AiAnalysisRepository {
  @override
  Future<AiReport> analyze({required String category, required String summary,
    required String description, String location = '', List<String> imagePaths = const []}) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final text = '$summary $description'.toLowerCase();
    final plumbing = category == 'Plumbing' || text.contains('leak') || text.contains('pipe');
    final electrical = category == 'Electrical';
    final trade = plumbing ? 'Plumber' : electrical ? 'Electrician' : category == 'HVAC' ? 'HVAC Technician' : 'Home Maintenance Technician';
    return AiReport(
      title: plumbing ? 'Possible plumbing leak' : 'Possible $category issue',
      summary: 'Demo assessment based on your description: $summary. A qualified $trade must inspect the problem to confirm the cause.',
      specialty: trade,
      severity: 'Needs inspection',
      precaution: plumbing ? 'If safe, shut off the local water supply and keep electrical devices away from water.' : 'Avoid attempting hazardous repairs yourself. Contact a qualified technician.',
      category: category,
      costMin: 0, costMax: 0, minutesMin: 0, minutesMax: 0,
      parts: const ['To be confirmed by technician'],
    );
  }
}
