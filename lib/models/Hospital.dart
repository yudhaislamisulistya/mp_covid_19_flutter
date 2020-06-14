class Hospital {
  Hospital({
    this.idHospital,
    this.name,
    this.address,
    this.city,
    this.longitude,
    this.latitude,
  });

  int idHospital;
  String name;
  String address;
  String city;
  String longitude;
  String latitude;

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    idHospital: json["id_hospital"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );
}