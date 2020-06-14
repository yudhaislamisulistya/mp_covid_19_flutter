class Dial {
  Dial({
    this.idDial,
    this.name,
    this.callphone,
  });

  int idDial;
  String name;
  String callphone;

  factory Dial.fromJson(Map<String, dynamic> json) => Dial(
    idDial: json["id_dial"],
    name: json["name"],
    callphone: json["callphone"],
  );

}