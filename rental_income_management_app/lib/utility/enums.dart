enum Role { owner, manager, admin, visitor }

final roleMap = {
  "owner": Role.owner,
  "manager": Role.manager,
  "admin": Role.admin,
};

enum Property { flat, pg, hostel, shop, office, residential, commercial }

final propertyMap = {
  "flat": Property.flat,
  "pg": Property.pg,
  "hostel": Property.hostel,
  "shop": Property.shop,
  "office": Property.office,
  "residential": Property.residential,
  "commercial": Property.commercial,
};

enum RoomStatus { occupied, vacant }

final RoomStatusMap = {
  "occupied": RoomStatus.occupied,
  "vacant": RoomStatus.vacant,
};
