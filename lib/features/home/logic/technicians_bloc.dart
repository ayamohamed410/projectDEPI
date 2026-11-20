import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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

class TechniciansInitial extends TechniciansState {
  const TechniciansInitial();
}

class TechniciansLoading extends TechniciansState {
  const TechniciansLoading();
}

class TechniciansLoaded extends TechniciansState {
  final List<TechnicianInfo> technicians;

  const TechniciansLoaded(this.technicians);
}

class TechniciansFailure extends TechniciansState {
  final String message;

  const TechniciansFailure(this.message);
}

class TechniciansBloc extends Bloc<TechniciansEvent, TechniciansState> {
  final TechniciansRepository repository;

  TechniciansBloc(this.repository) : super(const TechniciansInitial()) {
    on<LoadTechnicians>((event, emit) async {
      emit(const TechniciansLoading());

      try {
        debugPrint('Loading technicians for: ${event.category}');

        final techs = await repository.fetchForCategory(event.category);

        debugPrint('Technicians found: ${techs.length}');

        emit(TechniciansLoaded(techs));
      } on FirebaseException catch (e) {
        debugPrint('Firebase Error Code: ${e.code}');
        debugPrint('Firebase Error Message: ${e.message}');

        emit(TechniciansFailure('Firebase Error: ${e.code}'));
      } catch (e) {
        debugPrint('Technicians Error: $e');

        emit(
          const TechniciansFailure(
            'Something went wrong while loading technicians.',
          ),
        );
      }
    });
  }
}
