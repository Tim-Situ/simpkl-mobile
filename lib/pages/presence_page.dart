import 'package:flutter/material.dart';
import 'package:simpkl_mobile/components/attendance_list.dart';
import 'package:simpkl_mobile/components/responsive_boxes.dart';

class PresencePage extends StatefulWidget {
  const PresencePage({super.key});

  @override
  State<PresencePage> createState() => _PresencePageState();
}

class _PresencePageState extends State<PresencePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kehadiran",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Kehadiran Siswa dikonfirmasi dengan Jurnal",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const ResponsiveBoxes(),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                        color: const Color.fromARGB(25, 44, 85, 211)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(76, 211, 209, 216),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: const AttendanceList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
