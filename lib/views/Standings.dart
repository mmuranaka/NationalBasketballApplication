import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'UserDrawer.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  List<String> years = List.generate(6, (index) => (2023 - index).toString());
  late String selectedYear;
  late StandingsData standingsData;

  @override
  void initState() {
    super.initState();
    selectedYear = '2023';
    standingsData = StandingsData(year: selectedYear); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nba.png',
              fit: BoxFit.cover, // Fixes border issues
              width: 50.0,
              height: 50.0,
            ),
            const Text('Standings',
              style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: selectedYear,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedYear = newValue;
                    standingsData = StandingsData(year: newValue);
                  });
                }
              },
              items: years.map<DropdownMenuItem<String>>((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      drawer: const UserDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: standingsData,
      ),
    );
  }
}


class StandingsData extends StatefulWidget {
  final String year;
  final String url = "https://v2.nba.api-sports.io/standings?league=standard&season=";
  final String apiKey = 'b1a357f4afd74a3891896006b04791a9';
  
  const StandingsData({super.key, required this.year});

  @override
  State createState() => _StandingsDataState();
}

class _StandingsDataState extends State<StandingsData> {
  Future<List<dynamic>> _loadStandings() async {
    final response = await http.get(Uri.parse('${widget.url}${widget.year}'),
      headers:{
        'x-rapidapi-key': widget.apiKey,
        'x-rapidapi-host': 'v2.nba.api-sports.io'
    });
    final game = json.decode(response.body);
    return game['response'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _loadStandings(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final sortedData = List.from(snapshot.data!);
                sortedData.sort((a, b) => a['conference']['rank'].compareTo(b['conference']['rank']));
                return Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: (sortedData.length) + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const ListTile(
                              title: Text(
                                'Team',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Text('W    L   Pct    ', style: TextStyle(fontWeight: FontWeight.bold)),
                            );
                          } else {
                            final team = sortedData[index - 1];
                            if (team['conference']['name'] == 'east') {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      '${team['conference']['rank']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Image.network(
                                      team['team']['logo'],
                                      width: 28,
                                      height: 28,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${team['team']['nickname']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                trailing: Text('${team['win']['total']}  ${team['loss']['total']}  ${team['win']['percentage']}'),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: (sortedData.length) + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const ListTile(
                              title: Text(
                                'Team',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Text('W    L   Pct    ', style: TextStyle(fontWeight: FontWeight.bold)),
                            );
                          } else {
                            final team = sortedData[index - 1];
                            if (team['conference']['name'] == 'west') {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      '${team['conference']['rank']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Image.network(
                                      team['team']['logo'],
                                      width: 28,
                                      height: 28,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${team['team']['nickname']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                trailing: Text('${team['win']['total']}  ${team['loss']['total']}  ${team['win']['percentage']}'),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
