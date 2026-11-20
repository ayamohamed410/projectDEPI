import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import '../logic/ai_analysis_bloc.dart';
import 'ai_analysis_repository.dart';

/// The Gemini key is NEVER stored in the Flutter app.
/// Requires the deployed Firebase callable `analyzeHomeIssue` in us-central1.
class FirebaseAiAnalysisRepository implements AiAnalysisRepository {
  final FirebaseFunctions functions;
  FirebaseAiAnalysisRepository({FirebaseFunctions? functions})
    : functions =
          functions ?? FirebaseFunctions.instanceFor(region: 'us-central1');

  @override
  Future<AiReport> analyze({
    required String category,
    required String summary,
    required String description,
    String location = '',
    List<String> imagePaths = const [],
  }) async {
    try {
      if (imagePaths.length > 4) {
        throw const AiAnalysisException('Please select no more than 4 images.');
      }
      final images = <Map<String, String>>[];
      for (final path in imagePaths) {
        final file = File(path);
        final bytes = await file.readAsBytes();
        if (bytes.length > 1024 * 1024) {
          throw const AiAnalysisException(
            'Each image must be 1 MB or less. Please choose a smaller image.',
          );
        }
        final ext = path.toLowerCase().split('.').last;
        final mime = ext == 'png'
            ? 'image/png'
            : (ext == 'jpg' || ext == 'jpeg')
            ? 'image/jpeg'
            : null;
        if (mime == null) {
          throw const AiAnalysisException(
            'Only JPG and PNG images are supported.',
          );
        }
        images.add({'mimeType': mime, 'data': base64Encode(bytes)});
      }
      final callable = functions.httpsCallable(
        'analyzeHomeIssue',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 90)),
      );
      final response = await callable.call<Map<String, dynamic>>({
        'category': category,
        'summary': summary,
        'description': description,
        'location': location,
        'images': images,
      });
      final json = Map<String, dynamic>.from(response.data);
      String str(String key, String fallback) {
        final value = json[key];
        return value is String && value.trim().isNotEmpty
            ? value.trim()
            : fallback;
      }

      int num(String key) {
        final value = json[key];
        return value is num ? value.toInt().clamp(0, 10000000).toInt() : 0;
      }

      final parts = json['parts'];
      return AiReport(
        title: str('title', 'Issue requires inspection'),
        summary: str(
          'summary',
          'A qualified technician should inspect the issue.',
        ),
        specialty: str('specialty', 'Home Maintenance Technician'),
        severity: str('severity', 'Needs inspection'),
        precaution: str('precaution', 'Avoid hazardous DIY repairs.'),
        category:
            category, // trusted original selection, not a model-generated value
        parts: parts is List
            ? parts.whereType<String>().take(8).toList()
            : const [],
        costMin: num('costMin'),
        costMax: num('costMax'),
        minutesMin: num('minutesMin'),
        minutesMax: num('minutesMax'),
        isDemo: false,
      );
    } on AiAnalysisException {
      rethrow;
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'unauthenticated') {
        throw const AiAnalysisException(
          'Please sign in before analyzing a problem.',
        );
      }
      if (e.code == 'resource-exhausted') {
        throw const AiAnalysisException(
          'AI requests are temporarily limited. Try later.',
        );
      }
      throw AiAnalysisException(
        'AI service unavailable (${e.code}). Please try again.',
      );
    } catch (_) {
      throw const AiAnalysisException(
        'Could not analyze your problem. Check your connection and try again.',
      );
    }
  }
}
