import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_technician_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetTechnicianProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase})
      : super(const ProfileInitial()) {
    on<ProfileStarted>(_load);
    on<ProfileRefreshed>(_load);
  }

  Future<void> _load(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
