import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Standings.dart';
import '/views/HomePage.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
    width: MediaQuery.of(context).size.width * 0.5,
    child: 
      ListView(children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const HomePage(),
            ));
          },
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(Icons.home)
              ),
              Text(
                'Home',
                style: TextStyle(fontSize: 18),
              )
            ]
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const StandingsPage(),
            ));
          },
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(Icons.sports_basketball)
              ),
              Text(
                'Standings',
                style: TextStyle(fontSize: 18),
              )
            ]
          ),
        )
      ])
    );
  }
}