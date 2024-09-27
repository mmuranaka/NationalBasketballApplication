import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/team.dart';
import '../utils/db_helper.dart';

class TeamPage extends StatefulWidget {
  final String name;
  final String imageName;
  final String url = "https://v2.nba.api-sports.io/teams?name=";
  final String apiKey = 'b1a357f4afd74a3891896006b04791a9';

  const TeamPage({super.key, required this.name, required this.imageName});

  @override
  State createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  Future<Team> _loadTeamInfo(int mode) async {
    if (mode==0) {
      try {
        final data =  await DBHelper().query('team', where: 'name = ?', whereArgs: [widget.name]);
        final teamData = data.first;
        return Team(
          apiID: teamData['apiID'] as int,
          name: teamData['name'] as String,
          conference: teamData['conference'] as String,
          division: teamData['division'] as String,
        );
      } 
      // ignore: non_constant_identifier_names
      catch (DatabaseException) {
        final response = await http.get(Uri.parse('${widget.url}${widget.name}'),
          headers:{
            'x-rapidapi-key': widget.apiKey,
            'x-rapidapi-host': 'v2.nba.api-sports.io'
          });
        final team = json.decode(response.body);
        final teamData = Team(
          apiID: team['response'][0]['id'],
          name: team['response'][0]['name'],
          conference: team['response'][0]['leagues']['standard']['conference'],
          division: team['response'][0]['leagues']['standard']['division'],
        );
        teamData.dbSave();
        return teamData;
      }
    }
    else {
      final response = await http.get(Uri.parse('${widget.url}${widget.name}'),
          headers:{
            'x-rapidapi-key': widget.apiKey,
            'x-rapidapi-host': 'v2.nba.api-sports.io'
          });
        final team = json.decode(response.body);
        final teamData = Team(
          apiID: team['response'][0]['id'],
          name: team['response'][0]['name'],
          conference: team['response'][0]['leagues']['standard']['conference'],
          division: team['response'][0]['leagues']['standard']['division'],
        );
        teamData.dbEdit();
        return teamData;
    }
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text(widget.name,
          style: const TextStyle(color: Colors.black)),
        actions: [IconButton(icon: const Icon(Icons.refresh),
          onPressed: () {
            _loadTeamInfo(1);
            setState(() {});
          },
        )],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FutureBuilder <Team>(
          future: _loadTeamInfo(0),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final teamInfo = snapshot.data!;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Hero(
                          tag: widget.name,
                          child: Image.asset(
                            'assets/images/${widget.imageName}.png',
                            width: 150,            
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        height: 150,
                        width: 450,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Text(
                              teamInfo.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32, // Adjust the font size as needed
                              ),
                            ),
                            Text(
                              'Conference: ${teamInfo.conference}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Divsion: ${teamInfo.division}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ]
                        )
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Players',
                      style: TextStyle(fontSize: 24)
                    ),
                  ),
                  TeamPlayers(teamID: teamInfo.apiID)
                ]
              );
            }
            else if (snapshot.hasError) {
              return Center(
              child: Text('${snapshot.error}'),
              );
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }  
          }  
        )  
      )
    );
  }
}

class TeamPlayers extends StatefulWidget {
  final int teamID;
  final String url = "https://v2.nba.api-sports.io/players?team=";
  final String apiKey = 'b1a357f4afd74a3891896006b04791a9';
  
  const TeamPlayers({super.key, required this.teamID});

  @override
  State createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  Future<List<dynamic>>? futurePlayers;

  @override
  void initState() {
    super.initState();
    futurePlayers = _loadPlayers();
  }

  Future<List<dynamic>> _loadPlayers() async {
    const String seasonParameter = '&season=2023';
    final response = await http.get(Uri.parse('${widget.url}${widget.teamID}$seasonParameter'),
      headers:{
        'x-rapidapi-key': widget.apiKey,
        'x-rapidapi-host': 'v2.nba.api-sports.io'
    });
    final players = json.decode(response.body);
    return players['response'];  
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futurePlayers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final sortedData = List.from(snapshot.data!);
          sortedData.sort((a, b) => a['lastname'].compareTo(b['lastname']));
          return Expanded(
            child: ListView.builder(
              itemCount: (sortedData.length) + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text(
                            '#',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          width: 375,
                          child: Text(
                            'NAME',
                            style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            'POS',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text('HT',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            'WT',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            'COLLEGE',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            'YRS',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ), 
                  );
                }
                else {
                  final player = sortedData[index-1];
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text(
                            '${player['leagues']['standard']['jersey'] ?? '0'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 375,
                          child: Text(
                            '${player['firstname']} ${player['lastname']}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            '${player['leagues']['standard']['pos'] ?? ''}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            player['height']['feets'] != null 
                            ? '${player['height']['feets']}\'${player['height']['inches']??'0'}"' 
                            : '',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            '${player['weight']['pounds'] ?? ''}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            '${player['college'] ?? ''}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            '${player['nba']['pro']+1}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
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
    );
  }
}

