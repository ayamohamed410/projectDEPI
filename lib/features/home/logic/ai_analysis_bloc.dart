import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/ai_analysis_repository.dart';

class AiReport {
  final String title, summary, specialty, severity, precaution;
  final String category;
  final int costMin, costMax, minutesMin, minutesMax;
  final List<String> parts;
  final bool isDemo;
  const AiReport({required this.title, required this.summary,
    required this.specialty, required this.severity, required this.precaution,
    required this.category, required this.costMin, required this.costMax,
    required this.minutesMin, required this.minutesMax, required this.parts,
    this.isDemo = true});
}

abstract class AiAnalysisEvent { const AiAnalysisEvent(); }
class AnalyzeProblem extends AiAnalysisEvent {
  final String category, summary, description;
  final String location;
  final List<String> imagePaths;
  const AnalyzeProblem({required this.category, required this.summary, required this.description,
    this.location = '', this.imagePaths = const []});
}
class ResetAnalysis extends AiAnalysisEvent { const ResetAnalysis(); }

abstract class AiAnalysisState { const AiAnalysisState(); }
class AiInitial extends AiAnalysisState { const AiInitial(); }
class AiLoading extends AiAnalysisState { const AiLoading(); }
class AiSuccess extends AiAnalysisState {
  final AiReport report;
  const AiSuccess(this.report);
}
class AiFailure extends AiAnalysisState {
  final String message;
  const AiFailure(this.message);
}

class AiAnalysisBloc extends Bloc<AiAnalysisEvent, AiAnalysisState> {
  final AiAnalysisRepository repository;
  AiAnalysisBloc(this.repository) : super(const AiInitial()) {
    on<AnalyzeProblem>((event, emit) async {
      if (event.summary.trim().isEmpty || event.description.trim().isEmpty) {
        emit(const AiFailure('Enter a problem summary and detailed description.'));
        return;
      }
      emit(const AiLoading());
      try {
        final result = await repository.analyze(
          category: event.category,
          summary: event.summary.trim(),
          description: event.description.trim(),
          location: event.location.trim(),
          imagePaths: event.imagePaths,
        );
        emit(AiSuccess(result));
      } catch (e) {
        emit(AiFailure(e is AiAnalysisException ? e.message : 'Analysis failed. Please try again.'));
      }
    });
    on<ResetAnalysis>((event, emit) => emit(const AiInitial()));
  }
}
