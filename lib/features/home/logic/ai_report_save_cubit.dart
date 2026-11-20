import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ai_analysis_bloc.dart';

abstract class AiReportSaveState { const AiReportSaveState(); }
class AiReportSaveIdle extends AiReportSaveState { const AiReportSaveIdle(); }
class AiReportSaving extends AiReportSaveState { const AiReportSaving(); }
class AiReportSaved extends AiReportSaveState { const AiReportSaved(); }
class AiReportSaveError extends AiReportSaveState {
  final String message;
  const AiReportSaveError(this.message);
}

/// Saves a report to THIS DEVICE only. It does not create a service request
/// or synchronize with Firestore; implement that separately with your team.
class AiReportSaveCubit extends Cubit<AiReportSaveState> {
  AiReportSaveCubit() : super(const AiReportSaveIdle());

  Future<void> save(AiReport report) async {
    if (state is AiReportSaving || state is AiReportSaved) return;
    emit(const AiReportSaving());
    try {
      final prefs = await SharedPreferences.getInstance();
      const key = '7elhaly_saved_ai_reports_v1';
      final current = prefs.getStringList(key) ?? <String>[];
      final entry = jsonEncode(<String, dynamic>{
        'savedAt': DateTime.now().toIso8601String(),
        'category': report.category,
        'title': report.title,
        'summary': report.summary,
        'specialty': report.specialty,
        'severity': report.severity,
        'precaution': report.precaution,
        'parts': report.parts,
        'costMin': report.costMin,
        'costMax': report.costMax,
        'minutesMin': report.minutesMin,
        'minutesMax': report.minutesMax,
        'isDemo': report.isDemo,
      });
      final didSave = await prefs.setStringList(key, <String>[...current, entry]);
      if (!didSave) throw StateError('Local storage did not confirm the save');
      emit(const AiReportSaved());
    } catch (_) {
      emit(const AiReportSaveError('Could not save the report on this device. Try again.'));
    }
  }
}
