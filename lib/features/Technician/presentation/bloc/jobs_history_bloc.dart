import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../jobs/job_model.dart';
import '../../../jobs/jobs_repository.dart';

abstract class JobsHistoryEvent extends Equatable {
  const JobsHistoryEvent();
  @override
  List<Object?> get props => [];
}

class LoadJobsHistory extends JobsHistoryEvent {}

class ChangeMonthEvent extends JobsHistoryEvent {
  final DateTime month;
  const ChangeMonthEvent(this.month);
  @override
  List<Object?> get props => [month];
}

class ChangeTabEvent extends JobsHistoryEvent {
  final int tabIndex;
  const ChangeTabEvent(this.tabIndex);
  @override
  List<Object?> get props => [tabIndex];
}

class SearchJobsEvent extends JobsHistoryEvent {
  final String query;
  const SearchJobsEvent(this.query);
  @override
  List<Object?> get props => [query];
}

class SortJobsEvent extends JobsHistoryEvent {
  final String sortBy;
  const SortJobsEvent(this.sortBy);
  @override
  List<Object?> get props => [sortBy];
}

class JobsHistoryState extends Equatable {
  final bool isLoading;
  final List<JobModel> allJobs;
  final DateTime selectedMonth;
  final int selectedTab; // 0: All, 1: Completed, 2: Cancelled, 3: Disputed
  final String searchQuery;
  final String sortBy;
  final String? error;

  const JobsHistoryState({
    this.isLoading = false,
    this.allJobs = const [],
    required this.selectedMonth,
    this.selectedTab = 1,
    this.searchQuery = '',
    this.sortBy = 'newest',
    this.error,
  });

  JobsHistoryState copyWith({
    bool? isLoading,
    List<JobModel>? allJobs,
    DateTime? selectedMonth,
    int? selectedTab,
    String? searchQuery,
    String? sortBy,
    String? error,
  }) {
    return JobsHistoryState(
      isLoading: isLoading ?? this.isLoading,
      allJobs: allJobs ?? this.allJobs,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      error: error,
    );
  }

  List<JobModel> get monthHistoryJobs {
    return allJobs.where((job) {
      if (!job.isCompleted && !job.isCancelled && !job.isDisputed) return false;
      final date = job.closedAt ?? job.createdAt;
      if (date == null) return false;
      return date.year == selectedMonth.year && date.month == selectedMonth.month;
    }).toList();
  }

  int get countAll => monthHistoryJobs.length;
  int get countCompleted => monthHistoryJobs.where((j) => j.isCompleted).length;
  int get countCancelled => monthHistoryJobs.where((j) => j.isCancelled).length;
  int get countDisputed => monthHistoryJobs.where((j) => j.isDisputed).length;

  double get netInvoiced {
    return monthHistoryJobs
        .where((j) => j.isCompleted)
        .fold(0.0, (sum, j) => sum + j.netPayout);
  }

  List<JobModel> get filteredAndSortedJobs {
    var list = monthHistoryJobs.where((job) {
      if (selectedTab == 1 && !job.isCompleted) return false;
      if (selectedTab == 2 && !job.isCancelled) return false;
      if (selectedTab == 3 && !job.isDisputed) return false;

      if (searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        final matchName = job.customerName.toLowerCase().contains(q);
        final matchDiag = job.diagnosisTitle.toLowerCase().contains(q);
        final matchReq = job.requestNumber.toLowerCase().contains(q);
        if (!matchName && !matchDiag && !matchReq) return false;
      }
      return true;
    }).toList();

    list.sort((a, b) {
      final da = a.createdAt ?? DateTime(2000);
      final db = b.createdAt ?? DateTime(2000);
      if (sortBy == 'oldest') {
        return da.compareTo(db);
      } else if (sortBy == 'payout') {
        return b.netPayout.compareTo(a.netPayout);
      } else {
        return db.compareTo(da);
      }
    });

    return list;
  }

  @override
  List<Object?> get props => [isLoading, allJobs, selectedMonth, selectedTab, searchQuery, sortBy, error];
}

class JobsHistoryBloc extends Bloc<JobsHistoryEvent, JobsHistoryState> {
  final JobsRepository _repository;

  JobsHistoryBloc(this._repository)
      : super(JobsHistoryState(selectedMonth: DateTime(DateTime.now().year, DateTime.now().month))) {
    on<LoadJobsHistory>(_onLoadJobs);
    on<ChangeMonthEvent>(_onChangeMonth);
    on<ChangeTabEvent>(_onChangeTab);
    on<SearchJobsEvent>(_onSearchJobs);
    on<SortJobsEvent>(_onSortJobs);
  }

  Future<void> _onLoadJobs(LoadJobsHistory event, Emitter<JobsHistoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final jobs = await _repository.getTechnicianJobs();
      emit(state.copyWith(isLoading: false, allJobs: jobs));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onChangeMonth(ChangeMonthEvent event, Emitter<JobsHistoryState> emit) {
    emit(state.copyWith(selectedMonth: event.month));
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<JobsHistoryState> emit) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }

  void _onSearchJobs(SearchJobsEvent event, Emitter<JobsHistoryState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onSortJobs(SortJobsEvent event, Emitter<JobsHistoryState> emit) {
    emit(state.copyWith(sortBy: event.sortBy));
  }
}