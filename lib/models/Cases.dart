class Cases {
  Cases({
    this.idCase,
    this.confirmedCases,
    this.totalDeaths,
    this.totalRecovered,
    this.newCases,
    this.date,
  });

  int idCase;
  int confirmedCases;
  int totalDeaths;
  int totalRecovered;
  int newCases;
  String date;

  factory Cases.fromJson(Map<String, dynamic> json) => Cases(
    idCase: json["id_case"],
    confirmedCases: json["confirmed_cases"],
    totalDeaths: json["total_deaths"],
    totalRecovered: json["total_recovered"],
    newCases: json["new_cases"],
    date: json["date"],
  );
}