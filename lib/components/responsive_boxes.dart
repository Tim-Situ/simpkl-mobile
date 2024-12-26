import 'package:flutter/material.dart';
import 'package:simpkl_mobile/services/presensi_service.dart'; // Pastikan path ini sesuai
import 'package:simpkl_mobile/models/presensi.dart'; // Pastikan path ini sesuai

class ResponsiveBoxes extends StatefulWidget {
  const ResponsiveBoxes({super.key});

  @override
  ResponsiveBoxesState createState() => ResponsiveBoxesState();
}

class ResponsiveBoxesState extends State<ResponsiveBoxes> {
  int hadirCount = 0;
  int izinCount = 0;
  int sakitCount = 0;
  int alfaCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    try {
      PresensiService presensiService = PresensiService();
      KehadiranResponse response = await presensiService
          .fetchKehadiran(); // Ganti bulan dan tahun sesuai kebutuhan

      // Hitung jumlah kehadiran, izin, sakit, dan alfa
      for (var item in response.data.dataKehadiran) {
        switch (item.status.toUpperCase()) {
          case 'HADIR':
            hadirCount++;
            break;
          case 'IZIN':
            izinCount++;
            break;
          case 'SAKIT':
            sakitCount++;
            break;
          case 'ALFA':
            alfaCount++;
            break;
        }
      }

      setState(() {
        isLoading = false; // Set loading ke false setelah data diambil
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading ke false jika terjadi error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double boxWidth = (constraints.maxWidth - 25) / 4;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isLoading
                ? const CircularProgressIndicator() // Menampilkan indikator loading
                : buildBox(hadirCount.toString(), 'Hadir',
                    const Color(0xFFD4F9BA), boxWidth),
            isLoading
                ? const CircularProgressIndicator() // Menampilkan indikator loading
                : buildBox(izinCount.toString(), 'Izin',
                    const Color(0xFFF1F87C), boxWidth),
            isLoading
                ? const CircularProgressIndicator() // Menampilkan indikator loading
                : buildBox(sakitCount.toString(), 'Sakit',
                    const Color(0xFFCECFF9), boxWidth),
            isLoading
                ? const CircularProgressIndicator() // Menampilkan indikator loading
                : buildBox(alfaCount.toString(), 'Alfa',
                    const Color(0xFFFFAB99), boxWidth),
          ],
        );
      },
    );
  }

  Widget buildBox(String number, String label, Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(178, 0, 0, 0),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(178, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
