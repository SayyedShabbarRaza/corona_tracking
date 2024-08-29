import 'package:corona/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String? name;
  int? cases;
  int? recovered;
  int? deaths;
  int? critical;
  int? todayRecovered;
  String? image;
  DetailScreen(this.name, this.recovered, this.cases, this.deaths,
      this.critical, this.todayRecovered, this.image,
      {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 2),
              child: isLandscape
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.image.toString()),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .65,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  LandDetail(
                                      title: 'Cases', value: widget.cases),
                                  LandDetail(
                                      title: 'Recovered',
                                      value: widget.recovered),
                                  LandDetail(
                                      title: 'Deaths', value: widget.deaths),
                                  LandDetail(
                                      title: 'Critical',
                                      value: widget.critical),
                                  LandDetail(
                                      title: 'Today Recovered',
                                      value: widget.todayRecovered),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Card(
                          child: Column(
                            children: [
                              RowData(title: 'Cases', value: widget.cases),
                              RowData(
                                  title: 'Recovered', value: widget.recovered),
                              RowData(title: 'Deaths', value: widget.deaths),
                              RowData(
                                  title: 'Critical', value: widget.critical),
                              RowData(
                                  title: 'Today Recovered',
                                  value: widget.todayRecovered),
                            ],
                          ),
                        ),
                        //image
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 7,
                          backgroundImage:
                              NetworkImage(widget.image.toString()),
                        )
                      ],
                    )),
        ],
      ),
    );
  }
}

class LandDetail extends StatelessWidget {
  String? title;
  int? value;
  LandDetail({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0),
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
              Text(
                '$value',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.04),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
