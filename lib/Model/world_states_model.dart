class WorldStatesModel {
  int? cases;
  int? deaths;
  int? recovered;
  int? active;
  int? critical;
  int? todayRecovered;
  int? todayDeaths;
  WorldStatesModel(this.cases, this.deaths, this.recovered, this.active,
      this.critical, this.todayRecovered, this.todayDeaths);

  WorldStatesModel.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    active = json['active'];
    critical = json['critical'];
    todayRecovered = json['todayRecovered'];
    todayDeaths = json['todayRecovered'];
  }
}
