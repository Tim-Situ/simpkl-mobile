import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomePage(),
    Center(child: Text('Jurnal Page')),
    Center(child: Text('Kehadiran Page')),
    Center(child: Text('Nilai Page')),
    Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> images = [
    'assets/images/foto.png',
    'assets/images/foto.png',
    'assets/images/foto.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '24 November 2022',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Icon(Icons.notifications, color: Colors.grey),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Haloo, Belvanaaufal',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: PageView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kamu belum mengumpulkan Jurnal untuk kehadiran Hari ini',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    List<IconData> data = [
      Icons.home,
      Icons.insert_drive_file_sharp,
      Icons.groups,
      Icons.assignment_outlined,
      Icons.person,
    ];

    List<String> labels = ["Beranda", "Jurnal", "Presensi", "Nilai", "Profil"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(bottom: 4, right: 13, left: 13),
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(45.8),
            boxShadow: const [
              BoxShadow(blurRadius: 2, color: Colors.blueAccent)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              data.length,
              (i) => GestureDetector(
                    onTap: () => onItemTapped(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 10),
                      decoration: BoxDecoration(
                        border: i == selectedIndex
                            ? const Border(
                                top: BorderSide(
                                width: 3.0,
                                color: Colors.white,
                              ))
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              data[i],
                              size: 25,
                              color: i == selectedIndex
                                  ? Colors.white
                                  : Colors.lightBlueAccent,
                            ),
                            Text(
                              labels[i],
                              style: TextStyle(
                                color: i == selectedIndex
                                    ? Colors.white
                                    : Colors.lightBlueAccent,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
