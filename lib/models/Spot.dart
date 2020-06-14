class Spot {
  Spot({
    this.idSpot,
    this.name,
    this.address,
    this.city,
    this.longitude,
    this.latitude,
  });

  int idSpot;
  String name;
  String address;
  String city;
  String longitude;
  String latitude;

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
    idSpot: json["id_spot"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );
}
