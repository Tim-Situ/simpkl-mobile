import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/components/JournalCard.dart';

import 'package:simpkl_mobile/contstants/colors.dart';
import 'package:simpkl_mobile/pages/create_journal_page.dart';
import 'package:simpkl_mobile/pages/detail_jurnal_page.dart';

class JurnalPage extends StatefulWidget {
  const JurnalPage({super.key});

  @override
  State<StatefulWidget> createState() => _JurnalPageState();
}

class _JurnalPageState extends State<JurnalPage> {
  DateTime selectedDate = DateTime.now();

  // Method untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Format Tanggal
  String getFormattedDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 100),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Choose Date",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                        // Menampilkan tanggal dengan format yang diinginkan
                        Text(
                          getFormattedDate(selectedDate),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
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
              const SizedBox(
                height: 35,
              ),
              JournalCard(
                title: "Piket Pagi",
                status: "Ditolak",
                timeRange: "08:00 - 08:30",
                date: getFormattedDate(selectedDate),
                typeOfWork: "Pekerjaan Lain",
                typeOfActivity: "Inisiatif",
              ),
              const SizedBox(
                height: 15,
              ),
              JournalCard(
                title: "Daily Scrum",
                status: "Diterima",
                timeRange: "08:30 - 09:00",
                date: getFormattedDate(selectedDate),
                typeOfWork: "Sesuai Kompetensi",
                typeOfActivity: "Bimbingan",
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => DetailJurnalPage()),
                  );
              
                },
                child: JournalCard(
                  title: "Membuat Website",
                  status: "Menunggu",
                  timeRange: "09:00 - 16:00",
                  date: getFormattedDate(selectedDate),
                  typeOfWork: "Sesuai Kompetensi",
                  typeOfActivity: "Ditugaskan",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD3D1D8).withOpacity(0.3),
              // offset: Offset(5, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => CreateJournalPage()),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: SimpklColor.darkBlue,
          ),
        ),
      ),
    );
  }
}
