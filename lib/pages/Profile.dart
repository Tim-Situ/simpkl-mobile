import 'package:flutter/material.dart';
import 'package:simpkl_mobile/pages/logIn.dart';
import 'dataSiswa.dart';
import 'dataPembimbing.dart';
import 'dataPerusahaan.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Account Selector
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 20, left: 20, bottom: 20),
            child: Column(
              children: [
                Text(
                  'Choose Account',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'mgbelvanaufal@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Profile Picture and Name
          const Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              SizedBox(height: 15),
              Text(
                'MGhaziveda Belvanaufal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // Menu Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                buildMenuItem(
                  context: context,
                  icon: Icons.person,
                  title: 'Data Siswa',
                  color: const Color.fromRGBO(237, 242, 255, 1),
                  iconColor: const Color.fromRGBO(44, 85, 211, 1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataSiswaPage()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context: context,
                  icon: Icons.groups,
                  title: 'Pembimbing',
                  color: const Color.fromRGBO(237, 242, 255, 1),
                  iconColor: const Color.fromRGBO(44, 85, 211, 1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataPembimbingPage()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context: context,
                  icon: Icons.business,
                  title: 'Perusahaan',
                  color: const Color.fromRGBO(237, 242, 255, 1),
                  iconColor: const Color.fromRGBO(44, 85, 211, 1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataPerusahaanPage()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context: context,
                  icon: Icons.logout,
                  title: 'Logout',
                  color: const Color.fromRGBO(255, 117, 117, 0.5),
                  textColor: Colors.red,
                  iconColor: const Color.fromARGB(255, 255, 17, 0),
                  circleColor: const Color.fromARGB(74, 255, 82, 82),
                  arrowColor: const Color.fromARGB(255, 255, 17, 0),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => logIn()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildMenuItem({
  required BuildContext context,
  required IconData icon,
  required String title,
  required Color color,
  Color textColor = Colors.black,
  required Color iconColor,
  Color? circleColor,
  Color? arrowColor,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: circleColor ?? const Color.fromRGBO(205, 217, 255, 1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        trailing: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: circleColor ?? const Color.fromRGBO(205, 217, 255, 1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.chevron_right,
              color: arrowColor ?? iconColor,
              size: 20,
            ),
          ),
        ),
      ),
    ),
  );
}
