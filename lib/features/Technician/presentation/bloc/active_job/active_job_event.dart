import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../../jobs/job_model.dart';

abstract class ActiveJobEvent extends Equatable {
  const ActiveJobEvent();

  @override
  List<Object?> get props => [];
}


class LoadActiveJob extends ActiveJobEvent {
  final String? jobId;
  const LoadActiveJob(this.jobId);

  @override
  List<Object?> get props => [jobId];
}


class JobUpdated extends ActiveJobEvent {
  final JobModel? job;
  const JobUpdated(this.job);

  @override
  List<Object?> get props => [job];
}


class AdvanceStatus extends ActiveJobEvent {
  const AdvanceStatus();
}

class AddPartRequested extends ActiveJobEvent {
  final JobPart part;
  const AddPartRequested(this.part);

  @override
  List<Object?> get props => [part];
}

class PhotoPicked extends ActiveJobEvent {
  final bool isBefore;
  final Uint8List bytes;
  const PhotoPicked({required this.isBefore, required this.bytes});

  @override
  List<Object?> get props => [isBefore, bytes];
}

class CompletePressed extends ActiveJobEvent {
  const CompletePressed();
}

class ReportIssueRequested extends ActiveJobEvent {
  final String reason;
  const ReportIssueRequested(this.reason);

  @override
  List<Object?> get props => [reason];
}



class TimerTicked extends ActiveJobEvent {
  const TimerTicked();
}

class RetryPressed extends ActiveJobEvent {
  const RetryPressed();
}


class MessageShown extends ActiveJobEvent {
  const MessageShown();
}
