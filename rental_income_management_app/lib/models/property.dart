import 'package:cloud_firestore/cloud_firestore.dart';

import '../utility/enums.dart';
import 'room.dart';

class PropertyModel {
  final String id;
  final String name;
  final Property propertyType;
  final String description;
  final String? managerAssigned;
  String ownerId;
  final String flatHouseBuildingName;
  final String areaStreetSectorVillage;
  final String postalCode;
  final String townCity;
  final String country;
  final List<RoomModel> rooms;
  final DateTime? registeredOn;
  final DateTime? updatedOn;

  PropertyModel({
    required this.id,
    required this.name,
    required this.propertyType,
    required this.description,
    required this.ownerId,
    required this.flatHouseBuildingName,
    required this.areaStreetSectorVillage,
    required this.postalCode,
    required this.townCity,
    required this.country,
    required this.rooms,
    this.registeredOn,
    this.updatedOn,
    this.managerAssigned,
  });

  // Method to create an empty instance
  static PropertyModel empty() => PropertyModel(
        id: '',
        name: '',
        propertyType: Property.residential,
        description: '',
        ownerId: '',
        flatHouseBuildingName: '',
        areaStreetSectorVillage: '',
        postalCode: '',
        townCity: '',
        country: '',
        rooms: [],
        registeredOn: null,
        updatedOn: null,
        managerAssigned: null,
      );

  // Method to serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'propertyType': propertyType.toString().split('.').last,
      'description': description,
      'ownerId': ownerId,
      'flatHouseBuildingName': flatHouseBuildingName,
      'areaStreetSectorVillage': areaStreetSectorVillage,
      'postalCode': postalCode,
      'townCity': townCity,
      'country': country,
      'rooms': rooms.map((room) => room.toJson()).toList(),
      'registeredOn': registeredOn?.toIso8601String(),
      'updatedOn': updatedOn?.toIso8601String(),
      'managerAssigned': managerAssigned,
    };
  }

  // Factory to create from a Map
  factory PropertyModel.fromMap(Map<String, dynamic> data) {
    return PropertyModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      propertyType:
          propertyMap[(data['propertyType'] as String).toLowerCase()] ??
              Property.residential,
      description: data['description'] ?? '',
      ownerId: data['ownerId'] ?? '',
      flatHouseBuildingName: data['flatHouseBuildingName'] ?? '',
      areaStreetSectorVillage: data['areaStreetSectorVillage'] ?? '',
      postalCode: data['postalCode'] ?? '',
      townCity: data['townCity'] ?? '',
      country: data['country'] ?? '',
      rooms: (data['rooms'] as List<dynamic>)
          .map((room) => RoomModel.fromMap(room as Map<String, dynamic>))
          .toList(),
      registeredOn: data['registeredOn'] != null
          ? DateTime.parse(data['registeredOn'])
          : null,
      updatedOn:
          data['updatedOn'] != null ? DateTime.parse(data['updatedOn']) : null,
          managerAssigned: data['managerAssigned'],
    );
  }

  // Factory to create from a Firestore DocumentSnapshot
  factory PropertyModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return PropertyModel.fromMap({...data, 'id': snapshot.id});
  }

  // Override toString for better readability
  @override
  String toString() {
    return '$name, $flatHouseBuildingName, $areaStreetSectorVillage, $townCity, $country-$postalCode';
  }
}
