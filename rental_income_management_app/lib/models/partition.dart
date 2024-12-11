import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_income_management_app/utility/enums.dart';

class Partition {
  final int rent;
  final RoomStatus status;
  final String tenantId;
  final String paymentHistory;

  Partition({
    required this.rent,
    required this.status,
    required this.tenantId,
    required this.paymentHistory,
  });

  // Method to create an empty Partition instance
  static Partition empty() => Partition(
        rent: 0,
        status: RoomStatus.vacant,
        tenantId: '',
        paymentHistory: '',
      );

  // Serialize the Partition to JSON
  Map<String, dynamic> toJson() {
    return {
      'rent': rent,
      'status': status.toString().split('.').last,
      'tenantId': tenantId,
      'paymentHistory': paymentHistory,
    };
  }

  // Factory constructor to create a Partition from a map
  factory Partition.fromMap(Map<String, dynamic> data) {
    return Partition(
      rent: data['rent'] ?? 0,
      status: RoomStatus.values.firstWhere(
          (e) =>
              e.toString().split('.').last == (data['status'] ?? 'vacant'),
          orElse: () => RoomStatus.occupied),
      tenantId: data['tenantId'] ?? '',
      paymentHistory: data['paymentHistory'] ?? '',
    );
  }

  // Factory constructor to create a Partition from Firestore DocumentSnapshot
  factory Partition.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Partition.fromMap(data);
  }

  @override
  String toString() {
    return 'Partition rented for $rent, Status: $status, Tenant ID: $tenantId';
  }
}
