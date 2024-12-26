import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/services/presensi_service.dart'; // Pastikan path ini sesuai
import 'package:simpkl_mobile/models/presensi.dart'; // Pastikan path ini sesuai

class AttendanceList extends StatefulWidget {
  const AttendanceList({super.key});

  @override
  AttendanceListState createState() => AttendanceListState();
}

class AttendanceListState extends State<AttendanceList> {
  List<DataKehadiran> attendanceData = [];
  List<DataKehadiran> filteredData = [];
  String filter = 'Semua';
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
      setState(() {
        attendanceData = response.data.dataKehadiran;

        // Mengurutkan data berdasarkan tanggal (descending)
        attendanceData.sort((a, b) => b.tanggal.compareTo(a.tanggal));

        filteredData = attendanceData; // Inisialisasi filteredData
        isLoading = false; // Set loading ke false setelah data diambil
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading ke false jika terjadi error
      });
    }
  }

  get filteredAttendanceData {
    DateTime now = DateTime.now();

    if (filter == 'Seminggu terakhir') {
      filteredData = attendanceData.where((item) {
        DateTime date = item.tanggal; // Gunakan tanggal dari DataKehadiran
        return date.isAfter(now.subtract(const Duration(days: 7))) &&
            date.isBefore(now);
      }).toList();
    } else if (filter == 'Sebulan terakhir') {
      filteredData = attendanceData.where((item) {
        DateTime date = item.tanggal; // Gunakan tanggal dari DataKehadiran
        return date.isAfter(now.subtract(const Duration(days: 30))) &&
            date.isBefore(now);
      }).toList();
    } else {
      filteredData = attendanceData;
    }

    return filteredData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Absensi Siswa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 240, 240, 240),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    alignment: Alignment.center,
                    dropdownColor: Colors.white,
                    value: filter,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.orange, size: 16),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    isDense: true,
                    itemHeight: null,
                    onChanged: (String? newValue) {
                      setState(() {
                        filter = newValue!;
                      });
                      filteredAttendanceData; // Memperbarui data yang difilter
                    },
                    items: <String>[
                      'Seminggu terakhir',
                      'Sebulan terakhir',
                      'Semua'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
        isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Menampilkan indikator loading
            : Expanded(
                child: ListView.builder(
                  key: ValueKey(filter),
                  itemCount: filteredAttendanceData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              (index + 1).toString(), // Menampilkan nomor urut
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 240, 240, 240),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                DateFormat('EEEE, d MMMM yyyy', 'id').format(
                                    filteredData[index]
                                        .tanggal), // Format tanggal
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 62,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(filteredData[index]
                                  .status), // Mengambil warna status
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              filteredData[index].status,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(178, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'HADIR':
        return const Color(0xFFD4F8BA);
      case 'IZIN':
        return const Color(0xFFF1F87C);
      case 'SAKIT':
        return const Color(0xFFCECFF9);
      case 'ALFA':
        return const Color(0xFFFFAB99);
      default:
        return Colors.white;
    }
  }
}
