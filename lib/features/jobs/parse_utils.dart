import 'package:cloud_firestore/cloud_firestore.dart';



double? asDouble(dynamic v) {
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

DateTime? asDate(dynamic v) {
  if (v is Timestamp) return v.toDate();
  if (v is DateTime) return v;
  return null;
}

String asString(dynamic v, [String fallback = '']) =>
    v == null ? fallback : v.toString();

bool asBool(dynamic v) => v is bool ? v : false;
