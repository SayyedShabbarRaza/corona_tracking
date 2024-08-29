import 'dart:convert';

import 'package:corona/Model/countries_model.dart';
import 'package:corona/Model/world_states_model.dart';
import 'package:corona/services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetching() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print('status code is 200');
      return WorldStatesModel.fromJson(data);
    } else {
      print('status code is not 200');
      throw Exception('error');
    }
  }

  List<CountriesModel> countrylist = [];
  Future<List<CountriesModel>> fetchingCountries() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print('new code is 200');
      for (Map<String, dynamic> i in data) {
        countrylist.add(CountriesModel.fromJson(i));
      }
      return countrylist;
    } else {
      print('status code is not 200');
      return countrylist;
    }
  }
}
