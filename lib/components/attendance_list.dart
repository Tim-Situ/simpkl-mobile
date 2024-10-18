import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({super.key});

  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  final List<Map<String, String>> attendanceData = [
    {'no': '1', 'tanggal': '24 September 2024', 'status': 'Hadir'},
    {'no': '2', 'tanggal': '25 September 2024', 'status': 'Hadir'},
    {'no': '3', 'tanggal': '26 September 2024', 'status': 'Izin'},
    {'no': '4', 'tanggal': '27 September 2024', 'status': 'Sakit'},
    {'no': '5', 'tanggal': '28 September 2024', 'status': 'Alfa'},
    {'no': '6', 'tanggal': '30 September 2024', 'status': 'Izin'},
    {'no': '7', 'tanggal': '31 September 2024', 'status': 'Hadir'},
    {'no': '8', 'tanggal': '1 Oktober 2024', 'status': 'Hadir'},
    {'no': '9', 'tanggal': '2 Oktober 2024', 'status': 'Hadir'},
    {'no': '10', 'tanggal': '3 Oktober 2024', 'status': 'Hadir'},
    {'no': '11', 'tanggal': '4 Oktober 2024', 'status': 'Hadir'},
    {'no': '12', 'tanggal': '5 Oktober 2024', 'status': 'Hadir'},
    {'no': '13', 'tanggal': '6 Oktober 2024', 'status': 'Hadir'},
    {'no': '14', 'tanggal': '7 Oktober 2024', 'status': 'Hadir'},
    {'no': '15', 'tanggal': '8 Oktober 2024', 'status': 'Hadir'},
    {'no': '16', 'tanggal': '9 Oktober 2024', 'status': 'Hadir'},
    {'no': '17', 'tanggal': '10 Oktober 2024', 'status': 'Hadir'},
    {'no': '18', 'tanggal': '11 Oktober 2024', 'status': 'Hadir'},
    {'no': '19', 'tanggal': '12 Oktober 2024', 'status': 'Hadir'},
    {'no': '20', 'tanggal': '13 Oktober 2024', 'status': 'Hadir'},
    {'no': '21', 'tanggal': '14 Oktober 2024', 'status': 'Hadir'},
    {'no': '22', 'tanggal': '15 Oktober 2024', 'status': 'Hadir'},
    {'no': '23', 'tanggal': '16 Oktober 2024', 'status': 'Hadir'},
    {'no': '24', 'tanggal': '17 Oktober 2024', 'status': 'Hadir'},
    {'no': '25', 'tanggal': '18 Oktober 2024', 'status': 'Hadir'},
    {'no': '26', 'tanggal': '19 Oktober 2024', 'status': 'Hadir'},
    {'no': '27', 'tanggal': '20 Oktober 2024', 'status': 'Hadir'},
    {'no': '28', 'tanggal': '21 Oktober 2024', 'status': 'Izin'},
  ];

  List<Map<String, String>> filteredData = [];

  String filter = 'All';

  get filteredAttendanceData {
    DateTime now = DateTime.now();
    DateFormat format =
        DateFormat('d MMMM yyyy', 'id'); // Date format for parsing

    if (filter == 'Last Week') {
      filteredData = attendanceData.where((item) {
        DateTime date = format.parse(item['tanggal']!); // Parse date
        return date.isAfter(now.subtract(Duration(days: 7))) &&
            date.isBefore(now);
      }).toList();
    } else if (filter == 'Last Month') {
      filteredData = attendanceData.where((item) {
        DateTime date = format.parse(item['tanggal']!); // Parse date
        return date.isAfter(now.subtract(Duration(days: 30))) &&
            date.isBefore(now);
      }).toList();
    } else {
      filteredData = attendanceData;
    }

    return filteredData;
  }

// Format tanggal
  String formatDate(String date) {
    return DateFormat('dd MMMM yyyy').format(DateTime.parse(date));
  }

  @override
  void initState() {
    super.initState();
    filteredAttendanceData;
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
                margin: EdgeInsets.symmetric(vertical: 10),
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
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    isDense: true,
                    itemHeight: null, // Let items determine their own height
                    onChanged: (String? newValue) {
                      setState(() {
                        filter = newValue!;
                      });
                      filteredAttendanceData;
                    },
                    items: <String>['Last Week', 'Last Month', 'All']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
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
        Expanded(
          child: ListView.builder(
            key: ValueKey(filter),
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Container(
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
                        filteredData[index]['no']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
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
                          filteredData[index]['tanggal']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 75,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(filteredData[index]['status']!),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        filteredData[index]['status']!,
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
      case 'Hadir':
        return const Color(0xFFD4F8BA);
      case 'Izin':
        return const Color(0xFFF1F87C);
      case 'Sakit':
        return const Color(0xFFCECFF9);
      case 'Alfa':
        return const Color(0xFFFFAB99);
      default:
        return Colors.white;
    }
  }
}
