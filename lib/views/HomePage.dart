import 'package:flutter/material.dart';
import 'package:mp5/views/TeamPage.dart';
import 'UserDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Displays recent news from the News API REST service

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> teams = [
    'None',
    'Atlanta Hawks',
    'Boston Celtics',
    'Brooklyn Nets',
    'Charlotte Hornets',
    'Chicago Bulls',
    'Cleveland Cavaliers',
    'Dallas Mavericks',
    'Denver Nuggets',
    'Detroit Pistons',
    'Golden State Warriors',
    'Houston Rockets',
    'Indiana Pacers',
    'Los Angeles Clippers',
    'Los Angeles Lakers',
    'Memphis Grizzlies',
    'Miami Heat',
    'Milwaukee Bucks',
    'Minnesota Timberwolves',
    'New Orleans Pelicans',
    'New York Knicks',
    'Oklahoma City Thunder',
    'Orlando Magic',
    'Philadelphia 76ers',
    'Phoenix Suns',
    'Portland Trail Blazers',
    'Sacramento Kings',
    'San Antonio Spurs',
    'Toronto Raptors',
    'Utah Jazz',
    'Washington Wizards',
  ];
  String favoriteTeam = 'None';
  Map mapDisplay = const Map(favoriteTeam: 'None');

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteTeam = (prefs.getString('favoriteTeam') ?? 'None');
      mapDisplay = Map(favoriteTeam: prefs.getString('favoriteTeam') ?? 'None');
    });
  }

  Future<void> _saveTeam() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('favoriteTeam', favoriteTeam);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
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
            Text('NBA $screenWidth x $screenHeight',
              style: const TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                const Text(
                  'Favorite Team:',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: favoriteTeam,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        favoriteTeam = newValue;
                        mapDisplay = Map(favoriteTeam: favoriteTeam);
                        _saveTeam();
                      });
                    }
                  },
                  items: teams.map<DropdownMenuItem<String>>((String team) {
                    return DropdownMenuItem<String>(
                      value: team,
                      child: Text(team),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const UserDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: mapDisplay,
      )
    );
  }
}

class Map extends StatelessWidget {
  final String favoriteTeam;
  const Map({super.key, required this.favoriteTeam});

  @override
  Widget build(BuildContext context) {  
    return Stack(
      children: [
        Image.asset(
          'assets/images/map.jpeg',
          fit: BoxFit.fitWidth,
        ),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Atlanta Hawks', imageName: 'atlanta_hawks', xPercent: 72, yPercent: 23),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Boston Celtics', imageName: 'boston_celtics', xPercent: 88, yPercent: 61),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Brooklyn Nets', imageName: 'brooklyn_nets', xPercent: 82, yPercent: 59),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Charlotte Hornets', imageName: 'charlotte_hornets', xPercent: 75, yPercent: 29),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Chicago Bulls', imageName: 'chicago_bulls', xPercent: 60, yPercent: 52),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Cleveland Cavaliers', imageName: 'cleveland_cavaliers', xPercent: 71, yPercent: 51),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Dallas Mavericks', imageName: 'dallas_mavericks', xPercent: 44, yPercent: 18),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Denver Nuggets', imageName: 'denver_nuggets', xPercent: 30, yPercent: 44),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Detroit Pistons', imageName: 'detroit_pistons', xPercent: 68, yPercent: 58),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Golden State Warriors', imageName: 'golden_state_warriors', xPercent: 0, yPercent: 46),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Houston Rockets', imageName: 'houston_rockets', xPercent: 47, yPercent: 12),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Indiana Pacers', imageName: 'indiana_pacers', xPercent: 64, yPercent: 46),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Los Angeles Clippers', imageName: 'los_angeles_clippers', xPercent: 4, yPercent: 34),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Los Angeles Lakers', imageName: 'los_angeles_lakers', xPercent: 7, yPercent: 30),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Memphis Grizzlies', imageName: 'memphis_grizzlies', xPercent: 59, yPercent: 30),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Miami Heat', imageName: 'miami_heat', xPercent: 79, yPercent: 7),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Milwaukee Bucks', imageName: 'milwaukee_bucks', xPercent: 58, yPercent: 59),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Minnesota Timberwolves', imageName: 'minnesota_timberwolves', xPercent: 50, yPercent: 62),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'New Orleans Pelicans', imageName: 'new_orleans_pelicans', xPercent: 57, yPercent: 12),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'New York Knicks', imageName: 'new_york_knicks', xPercent: 85, yPercent: 54),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Oklahoma City Thunder', imageName: 'oklahoma_city_thunder', xPercent: 43, yPercent: 30),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Orlando Magic', imageName: 'orlando_magic', xPercent: 75, yPercent: 12),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Philadelphia 76ers', imageName: 'philadelphia_76ers', xPercent: 83, yPercent: 50),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Phoenix Suns', imageName: 'phoenix_suns', xPercent: 17, yPercent: 28),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Portland Trail Blazers', imageName: 'portland_trail_blazers', xPercent: 3, yPercent: 69),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Sacramento Kings', imageName: 'sacramento_kings', xPercent: 3, yPercent: 51),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'San Antonio Spurs', imageName: 'san_antonio_spurs', xPercent: 40, yPercent: 13),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Toronto Raptors', imageName: 'toronto_raptors', xPercent: 74, yPercent: 62),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Utah Jazz', imageName: 'utah_Jazz', xPercent: 21, yPercent: 50),
        TeamPicture(favoriteTeam: favoriteTeam, name: 'Washington Wizards', imageName: 'washington_wizards', xPercent: 79, yPercent: 45),
      ],
    );
  }
}

class TeamPicture extends StatefulWidget {
  final String favoriteTeam;
  final double xPercent;
  final double yPercent;
  final String imageName;
  final String name;

  const TeamPicture({super.key, required this.favoriteTeam, required this.xPercent,
    required this.yPercent, required this.imageName, required this.name,
  });

  @override
  State createState() => _TeamPictureState();
}

class _TeamPictureState extends State<TeamPicture>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final x = widget.xPercent / 100 * screenWidth;
    final y = widget.yPercent / 100 * screenHeight;

    return Positioned(
      bottom: y,
      left: x,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) =>
                  TeamPage(name: widget.name, imageName: widget.imageName),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              },
            ),
          );
        }, // Image tapped
        child: Hero(
          tag: widget.name,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.favoriteTeam == widget.name ? _animation.value : 1.0,
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/${widget.imageName}.png',
              fit: BoxFit.cover, // Fixes border issues
              width: widget.favoriteTeam == widget.name ? 60 : 50,
              height: widget.favoriteTeam == widget.name ? 60 : 50,
            ),
          ),
        ),
      ),
    );
  }
}