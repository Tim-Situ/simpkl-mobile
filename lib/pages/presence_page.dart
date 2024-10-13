import 'package:flutter/material.dart';
import 'package:simpkl_mobile/components/attendance_list.dart';
import 'package:simpkl_mobile/components/responsive_boxes.dart';

class PresencePage extends StatelessWidget {
  const PresencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
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
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD3D1D8).withOpacity(0.3),
                                offset: const Offset(5, 10),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ResponsiveBoxes(),
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
                  child: AttendanceList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
