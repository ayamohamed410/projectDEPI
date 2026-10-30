import 'package:flutter/material.dart';

class Job1Model {
  final String id;
  final String title;
  final DateTime dateTime;
  final String? status;
  final double netPayout;
  final double? rating;
  final String? reviewComment;
  final String? cancellationNote;
  final double? cancellationFeeCredited;

  Job1Model({
    this.status,
    required this.cancellationFeeCredited,
    required this.id,
    required this.title,
    required this.dateTime,
    required this.netPayout,
    this.rating,
    this.reviewComment,
    this.cancellationNote,
  });
}

List jobdata = [
  Job1Model(
    status: "completed",
    id: "#7H-9482",
    title: "Kitchen Sink High",
    dateTime: DateTime(2024, 10, 24, 11, 25),
    netPayout: 370.0,
    rating: 5.0,
    reviewComment: "Exceptional Service!",
    cancellationNote: null,
    cancellationFeeCredited: null,
  ),
  Job1Model(
    status: "completed",
    id: "#7H-9482",
    title: "Kitchen Sink High",
    dateTime: DateTime(2024, 10, 24, 11, 25),
    netPayout: 370.0,
    rating: 5.0,
    reviewComment: "Exceptional Service!",
    cancellationNote: null,
    cancellationFeeCredited: null,
  ),
  Job1Model(
    status: "completed",
    id: "#7H-9482",
    title: "Kitchen Sink High",
    dateTime: DateTime(2024, 10, 24, 11, 25),
    netPayout: 370.0,
    rating: 5.0,
    reviewComment: "Exceptional Service!",
    cancellationNote: null,
    cancellationFeeCredited: null,
  ),
];
