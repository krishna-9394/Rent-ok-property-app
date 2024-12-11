import 'package:cloud_firestore/cloud_firestore.dart';

import 'partition.dart';

class RoomModel {
  final String id;
  final String description;
  final String roomNumber;
  List<Partition> partitions;

  RoomModel({
    required this.id,
    required this.description,
    required this.roomNumber,
    required this.partitions,
  });

  // Method to create an empty RoomModel instance
  static RoomModel empty() => RoomModel(
        id: '',
        description: '',
        roomNumber: '',
        partitions: [],
      );

  // Serialize the RoomModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'roomNumber': roomNumber,
      'partitions': partitions.map((partition) => partition.toJson()).toList(),
    };
  }

  // Factory constructor to create a RoomModel from a map
  factory RoomModel.fromMap(Map<String, dynamic> data) {
    return RoomModel(
      id: data['id'] ?? '',
      description: data['description'] ?? '',
      roomNumber: data['roomNumber'] ?? '',
      partitions: (data['partitions'] as List<dynamic>)
          .map((partition) =>
              Partition.fromMap(partition as Map<String, dynamic>))
          .toList(),
    );
  }

  // Factory constructor to create a RoomModel from Firestore DocumentSnapshot
  factory RoomModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RoomModel.fromMap({...data, 'id': snapshot.id});
  }

  @override
  String toString() {
    return 'Room $roomNumber: $description';
  }
}
