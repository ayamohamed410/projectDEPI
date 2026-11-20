import 'parse_utils.dart';


class JobStatus {
  JobStatus._();

  static const pending = 'pending';
  static const accepted = 'accepted';
  static const onWay = 'on_way';
  static const arrived = 'arrived';
  static const inProgress = 'in_progress';
  static const completed = 'completed';
  static const cancelled = 'cancelled';
  static const disputed = 'disputed';



  static const active = [accepted, onWay, arrived, inProgress];


  static const flow = [accepted, onWay, arrived, inProgress, completed];

  /// The status after [current] on the happy path, or null at the end.
  static String? next(String current) {
    final i = flow.indexOf(current);
    if (i == -1 || i == flow.length - 1) return null;
    return flow[i + 1];
  }
}


class JobPart {
  final String name;
  final int qty;
  final double price;
  final String? note;

  const JobPart({
    required this.name,
    this.qty = 1,
    required this.price,
    this.note,
  });

  factory JobPart.fromMap(Map<String, dynamic> m) => JobPart(
        name: asString(m['name']),
        qty: (asDouble(m['qty']) ?? 1).toInt(),
        price: asDouble(m['price']) ?? 0,
        note: m['note'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'qty': qty,
        'price': price,
        if (note != null) 'note': note,
      };
}


class StatusEvent {
  final String status;
  final DateTime? at;

  const StatusEvent({required this.status, this.at});

  factory StatusEvent.fromMap(Map<String, dynamic> m) =>
      StatusEvent(status: asString(m['status']), at: asDate(m['at']));
}

class JobModel {
  final String id;
  final String customerId;
  final String technicianId;
  final String customerName;
  final String customerArea;
  final String customerPhone;
  final String requestNumber;
  final String diagnosisTitle;
  final String problemDescription;
  final String status;
  final List<StatusEvent> statusHistory;
  final List<JobPart> parts;
  final String? beforePhotoUrl;
  final String? afterPhotoUrl;
  final double baseAmount;
  final double partsAmount;
  final double totalAmount;
  final double netPayout;
  final bool customerSigned;
  final double? rating;
  final String? reviewText;
  final double? cancellationFee;
  final String? cancelledBy;
  final DateTime? createdAt;
  final DateTime? closedAt;

  const JobModel({
    required this.id,
    this.customerId = '',
    this.technicianId = '',
    this.customerName = '',
    this.customerArea = '',
    this.customerPhone = '',
    this.requestNumber = '',
    this.diagnosisTitle = '',
    this.problemDescription = '',
    this.status = JobStatus.pending,
    this.statusHistory = const [],
    this.parts = const [],
    this.beforePhotoUrl,
    this.afterPhotoUrl,
    this.baseAmount = 0,
    this.partsAmount = 0,
    this.totalAmount = 0,
    this.netPayout = 0,
    this.customerSigned = false,
    this.rating,
    this.reviewText,
    this.cancellationFee,
    this.cancelledBy,
    this.createdAt,
    this.closedAt,
  });

  factory JobModel.fromMap(String id, Map<String, dynamic> m) {
    final base = asDouble(m['baseAmount']) ?? 0;
    final partsAmount = asDouble(m['partsAmount']) ?? 0;
    return JobModel(
      id: id,
      customerId: asString(m['customerId']),
      technicianId: asString(m['technicianId']),
      customerName: asString(m['customerName']),
      customerArea: asString(m['customerArea']),
      customerPhone: asString(m['customerPhone']),
      requestNumber: asString(m['requestNumber']),
      diagnosisTitle: asString(m['diagnosisTitle']),
      problemDescription: asString(m['problemDescription']),

  

            status: asString(m['status'], JobStatus.pending).trim(),
      statusHistory: ((m['statusHistory'] as List?) ?? const [])
          .whereType<Map>()
          .map((e) => StatusEvent.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      parts: ((m['parts'] as List?) ?? const [])
          .whereType<Map>()
          .map((e) => JobPart.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      beforePhotoUrl: m['beforePhotoUrl'] as String?,
      afterPhotoUrl: m['afterPhotoUrl'] as String?,
      baseAmount: base,
      partsAmount: partsAmount,
      totalAmount: asDouble(m['totalAmount']) ?? (base + partsAmount),
      netPayout: asDouble(m['netPayout']) ?? 0,
      customerSigned: asBool(m['customerSigned']),
      rating: asDouble(m['rating']),
      reviewText: m['reviewText'] as String?,
      cancellationFee: asDouble(m['cancellationFee']),
      cancelledBy: m['cancelledBy'] as String?,
      createdAt: asDate(m['createdAt']),
      closedAt: asDate(m['closedAt']),
    );
  }

  bool get isActive => JobStatus.active.contains(status);
  bool get isCompleted => status == JobStatus.completed;
  bool get isCancelled => status == JobStatus.cancelled;
  bool get isDisputed => status == JobStatus.disputed;

  /// When the job reached [wanted], from `statusHistory` (null if never).
  DateTime? timeOf(String wanted) {
    for (final e in statusHistory.reversed) {
      if (e.status == wanted) return e.at;
    }
    return null;
  }
}

/// One document of `jobs/{jobId}/messages`.
class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? readAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    this.text = '',
    this.imageUrl,
    required this.createdAt,
    this.readAt,
  });

  factory ChatMessage.fromMap(String id, Map<String, dynamic> m) => ChatMessage(
        id: id,
        senderId: asString(m['senderId']),
        text: asString(m['text']),
        imageUrl: m['imageUrl'] as String?,
        // A just-sent message has no server timestamp yet; show it as "now".
        createdAt: asDate(m['createdAt']) ?? DateTime.now(),
        readAt: asDate(m['readAt']),
      );
}
