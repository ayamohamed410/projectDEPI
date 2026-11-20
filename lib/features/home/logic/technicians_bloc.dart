import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/technicians_repository.dart';

abstract class TechniciansEvent {
  const TechniciansEvent();
}

class LoadTechnicians extends TechniciansEvent {
  final String category;
  const LoadTechnicians(this.category);
}

abstract class TechniciansState {
  const TechniciansState();
}

class TechniciansInitial extends TechniciansState { const TechniciansInitial(); }
class TechniciansLoading extends TechniciansState { const TechniciansLoading(); }
class TechniciansLoaded extends TechniciansState {
  final List<TechnicianInfo> technicians;
  const TechniciansLoaded(this.technicians);
}
class TechniciansFailure extends TechniciansState {
  final String message;
  const TechniciansFailure(this.message);
}

class TechniciansBloc extends Bloc<TechniciansEvent, TechniciansState> {
  TechniciansBloc(this.repository) : super(const TechniciansInitial()) {
    on<LoadTechnicians>((event, emit) async {
      emit(const TechniciansLoading());
      try {
        final techs = await repository.fetchForCategory(event.category);
        emit(TechniciansLoaded(techs));
      } catch (_) {
        emit(const TechniciansFailure('Could not load technicians. Check your connection and Firestore access.'));
      }
    });
  }
  final TechniciansRepository repository;
}
