class CountriesModel {
  String? country;
  CountryInfo? countryinfo;
  int? cases;
  int? deaths;
  int? recovered;
  int? todayRecovered;
  int? critical;
  CountriesModel(this.country, this.countryinfo, this.cases, this.deaths,
      this.recovered, this.todayRecovered, this.critical);

  CountriesModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryinfo = json['countryInfo'] != null
        ? CountryInfo.fromJson(json['countryInfo'])
        : null;
    deaths = json['deaths'];
    recovered = json['recovered'];
    todayRecovered = json['todayRecovered'];
    critical = json['critical'];
    cases = json['cases'];
  }
}

class CountryInfo {
  String? flag;
  CountryInfo(this.flag);
  CountryInfo.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
  }
}
