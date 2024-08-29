import 'package:corona/Model/world_states_model.dart';
import 'package:corona/View/countries_list.dart';
import 'package:corona/services/states_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  StatesServices fetching = StatesServices();

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder<WorldStatesModel>(
                  future: fetching.fetching(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return isLandscape
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.65,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: PieChart(
                                        dataMap: {
                                          'Total': double.parse(
                                              snapshot.data!.cases.toString()),
                                          'Recovered': double.parse(snapshot
                                              .data!.recovered
                                              .toString()),
                                          'Deaths': double.parse(
                                              snapshot.data!.deaths.toString()),
                                        },
                                        animationDuration:
                                            const Duration(milliseconds: 1200),
                                        chartType: ChartType.ring,
                                        chartValuesOptions:
                                            const ChartValuesOptions(
                                                showChartValuesInPercentage:
                                                    true),
                                        colorList: colorlist,
                                        legendOptions: const LegendOptions(
                                            showLegendsInRow: true,
                                            legendPosition:
                                                LegendPosition.bottom),
                                        chartRadius:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                      ),
                                    ),
                                    //List
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .55,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              LandData(
                                                  title: 'Total',
                                                  value: snapshot.data!.cases),
                                              LandData(
                                                  title: 'Recovered',
                                                  value:
                                                      snapshot.data!.recovered),
                                              LandData(
                                                  title: 'Deaths',
                                                  value: snapshot.data!.deaths),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Button

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CountriesList()));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff1aa260),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Track countries',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PieChart(
                                  dataMap: {
                                    'Total': double.parse(
                                        snapshot.data!.cases.toString()),
                                    'Recovered': double.parse(
                                        snapshot.data!.recovered.toString()),
                                    'Deaths': double.parse(
                                        snapshot.data!.deaths.toString()),
                                  },
                                  animationDuration:
                                      const Duration(milliseconds: 1200),
                                  chartType: ChartType.ring,
                                  chartValuesOptions: const ChartValuesOptions(
                                      showChartValuesInPercentage: true),
                                  colorList: colorlist,
                                  legendOptions: const LegendOptions(
                                      legendPosition: LegendPosition.left),
                                  chartRadius:
                                      MediaQuery.of(context).size.width / 3.2,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              .06),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        RowData(
                                            title: 'Total',
                                            value: snapshot.data!.cases),
                                        RowData(
                                            title: 'Recovered',
                                            value: snapshot.data!.recovered),
                                        RowData(
                                            title: 'Deaths',
                                            value: snapshot.data!.deaths),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CountriesList()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff1aa260),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Track countries',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ],
                            );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowData extends StatelessWidget {
  String? title;
  int? value;
  RowData({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text('$value'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class LandData extends StatelessWidget {
  String? title;
  int? value;
  LandData({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.04),
              ),
              Text('$value'),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
