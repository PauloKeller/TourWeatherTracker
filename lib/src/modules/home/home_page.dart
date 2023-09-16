import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:tour_weather_tracker/src/modules/modules.dart';

class HomePage extends StatefulWidget {
  final List<String> _cityNames = [
    "Silverstone",
    "São Paulo",
    "Melbourne",
    "Monte Carlo"
  ];

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goToDetails(String cityName) {
    final route = MaterialPageRoute(builder: (context) => DetailsPage(cityName: cityName));

    Navigator.push(context, route);
  }

  void _goToSearchDelegate() async {
    final result = await showSearch<String?>(context: context, delegate: _HomeSearchDelegate(UnmodifiableListView(widget._cityNames)));

    if (result != null) {
      _goToDetails(result);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tour Weather Tracker"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _goToSearchDelegate,
            )
          ],
        ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget._cityNames.length,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () {
                _goToDetails(widget._cityNames[index]);
              },
              child: Text(widget._cityNames[index]),
            );
          },
        ),
      ),
    );
  }
}

class _HomeSearchDelegate extends SearchDelegate<String?> {
  final UnmodifiableListView<String> _cityNames;

  _HomeSearchDelegate(this._cityNames);

   _filterByQuery({int matchCount = 0}) {
    if (query.length > matchCount) {
      final filtered = _cityNames.where((city) => city.toLowerCase().contains(query.toLowerCase()));
      return UnmodifiableListView(filtered);
    }

    return _cityNames;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _filterByQuery(matchCount: 3);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: results?.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(results?[index].name ?? "Empty"),
          leading: const Icon(Icons.new_label),
          onTap: () {
            close(context, results?[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = _filterByQuery();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: results?.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(results?[index] ?? "Empty"),
          onTap: () {
            close(context, results?[index]);
          },
        );
      },
    );
  }
}
