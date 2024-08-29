import 'package:corona/Model/countries_model.dart';
import 'package:corona/View/detail_screen.dart';
import 'package:corona/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  StatesServices services = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'search by country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<CountriesModel>>(
              future: services.fetchingCountries(),
              builder: (context, AsyncSnapshot<List<CountriesModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  width: MediaQuery.of(context).size.width * .1,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  width: MediaQuery.of(context).size.width * .1,
                                  height:
                                      MediaQuery.of(context).size.height * .01,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height:
                                      MediaQuery.of(context).size.width * .03,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var name = snapshot.data![index].country;
                      if (searchController.text.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            snapshot.data![index].country
                                                .toString(),
                                            snapshot.data![index].recovered,
                                            snapshot.data![index].cases,
                                            snapshot.data![index].deaths,
                                            snapshot.data![index].critical,
                                            snapshot
                                                .data![index].todayRecovered,
                                            snapshot
                                                .data![index].countryinfo!.flag
                                                .toString(),
                                          )));
                                },
                                child: ListTile(
                                  leading: Image(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width: MediaQuery.of(context).size.width *
                                          .1,
                                      image: NetworkImage(snapshot
                                          .data![index].countryinfo!.flag
                                          .toString())),
                                  title: Text(
                                      snapshot.data![index].country.toString()),
                                  subtitle: Text(
                                      snapshot.data![index].cases.toString()),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (name!
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            snapshot.data![index].country
                                                .toString(),
                                            snapshot.data![index].recovered,
                                            snapshot.data![index].cases,
                                            snapshot.data![index].deaths,
                                            snapshot.data![index].critical,
                                            snapshot
                                                .data![index].todayRecovered,
                                            snapshot
                                                .data![index].countryinfo!.flag
                                                .toString(),
                                          )));
                                },
                                child: ListTile(
                                  leading: Image(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width: MediaQuery.of(context).size.width *
                                          .1,
                                      image: NetworkImage(snapshot
                                          .data![index].countryinfo!.flag
                                          .toString())),
                                  title: Text(
                                      snapshot.data![index].country.toString()),
                                  subtitle: Text(
                                      snapshot.data![index].cases.toString()),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
