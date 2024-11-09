import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = true;

  final List<String> playlistNames = [
    'Liked Songs',
    'On - K-Pop',
    'Hivi!',
    'One Direction',
    'Juicy Luicy'
  ];

  final List<String> playlistDescriptions = [
    '287 Song',
    'BLACKPINK, NCT, TREASURE, AESPA',
    'Artist',
    'Artist',
    'Artist'
  ];

  final List<String> songNames = [
    'Iglo',
    'DRIP',
    'Mean It',
    'APT',
    'hey, im tired',
    'La La La Lost You'
  ];

  final List<String> songDescriptions = [
    'Artist: KISS OF LIFE, Album: The Album',
    'Artist: BABYMONSTER, Album: DRIP',
    'Artist: Lauv, Album: ~how im feeling',
    'Artist: ROSE, Bruno Mars, Album: APT',
    'Artist: Arash Buana, Album: life update',
    'Artist: 88rising, NIKI, Album: Head In The Clouds II'
  ];

  final List<Color> gridItemColors = [
    const Color.fromARGB(255, 231, 154, 148),
    const Color.fromARGB(255, 133, 181, 219),
    const Color.fromARGB(255, 152, 218, 154),
    const Color.fromARGB(255, 245, 237, 167),
    const Color.fromARGB(255, 219, 172, 228)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/account');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Your Playlists',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 200,
            child: buildGridView(),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Liked Songs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: buildListView(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/account');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.1,
      ),
      itemCount: playlistNames.length,
      itemBuilder: (context, index) {
        Color itemColor = gridItemColors[index % gridItemColors.length];
        return Card(
          color: itemColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  playlistNames[index],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  playlistDescriptions[index],
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: songNames.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.music_note),
          title: Text(songNames[index]),
          subtitle: Text(songDescriptions[index]),
        );
      },
    );
  }
}
