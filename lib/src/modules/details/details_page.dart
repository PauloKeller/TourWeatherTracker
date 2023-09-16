import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tour_weather_tracker/src/modules/modules.dart';
import 'package:tour_weather_tracker/src/entities/entities.dart';

class DetailsPage extends StatefulWidget {
  final String cityName;

  const DetailsPage({Key? key, required this.cityName}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsBlocInterface _detailsBloc;

  Widget _weatherListItem(WeatherEntity? result, bool isBold) {
    final fontWeight = isBold ? FontWeight.bold : FontWeight.normal;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          result?.main ?? "",
          style: TextStyle(fontWeight: fontWeight),
        ),
        Text(result?.dateTime.toString() ?? "",
            style: TextStyle(fontWeight: fontWeight)),
      ],
    );
  }

  Widget _weathersList(List<WeatherEntity?> results) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        if (results.isEmpty) {
          return const Text("No records");
        }

        return _weatherListItem(results[index], index == 0);
      },
    );
  }

  Future<void> _waitForSeconds() async {
    await Future.delayed(const Duration(seconds: 0));
    _detailsBloc.loadData(widget.cityName);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _detailsBloc = Provider.of<DetailsBlocInterface>(context);
  }

  @override
  void initState() {
    super.initState();

    _waitForSeconds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: SafeArea(
        child: Consumer<DetailsBlocInterface>(
          builder: (context, bloc, child) {
            if (bloc.isLoading) {
              if (bloc.errorMessage != null) {
                return Text(bloc.errorMessage ?? "Failed to load data");
              }

              return const Text("Loading records");
            }

            return _weathersList(bloc.weathers);
          },
        ),
      ),
    );
  }
}
