import 'package:flutter/material.dart';

class Job1Model {
  final String id;
  final String title;
  final DateTime dateTime;
  final String? status;

  // final JobStatus status; // حالة الطلب (Completed, Cancelled, الخ)
  // final CustomerModel? customer; // بيانات العميل
  final double netPayout; // المبلغ النهائي المدفوع للمصنّع/الفني
  final double? rating; // التقييم (مثلاً 5.0)
  final String? reviewComment; // التعليق (مثلاً "Exceptional Service!")
  final String? cancellationNote; // ملاحظة الإلغاء (إن وجدت)
  final double? cancellationFeeCredited; // رسوم التعويض في حال الإلغاء

  Job1Model({
     this.status,
    required this.cancellationFeeCredited,
    required this.id,
    required this.title,
    required this.dateTime,
    // required this.status,
    // this.customer,
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
  ),];
