import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/components/journal_card.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:simpkl_mobile/pages/create_journal_page.dart';
import 'package:simpkl_mobile/pages/detail_jurnal_page.dart';
import 'package:simpkl_mobile/services/jurnal_harian_service.dart';
import 'package:simpkl_mobile/models/jurnal_harian_model.dart';

class JurnalPage extends StatefulWidget {
  const JurnalPage({super.key});

  @override
  State<StatefulWidget> createState() => _JurnalPageState();
}

class _JurnalPageState extends State<JurnalPage> {
  DateTime selectedDate = DateTime.now();
  bool _isLoading = false;
  List<JurnalHarianModel> _jurnalData = [];

  final JurnalHarianService _jurnalHarianService = JurnalHarianService();

  // Method untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _fetchData(); // Fetch data again after date change
    }
  }

  // Format Tanggal
  String getFormattedDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  // Fetch data from API
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      await _jurnalHarianService.getJurnal(formattedDate);
      setState(() {
        _jurnalData = _jurnalHarianService.dataJurnalHarian;
      });
    } catch (e) {
      setState(() {
        _jurnalData = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the page is loaded
  }

  // Fungsi untuk melakukan refresh
  Future<void> _refreshData() async {
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: RefreshIndicator(
          onRefresh: _refreshData, // Menyambungkan fungsi refresh
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
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
                          Text(
                            getFormattedDate(selectedDate),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
    ? const Center(child: CircularProgressIndicator())
    : _jurnalData.isNotEmpty
        ? Column(
            children: _jurnalData.map((jurnal) {
              return Dismissible(
                key: Key(jurnal.id.toString()), // Gunakan ID unik untuk setiap item
                direction: DismissDirection.endToStart, // Arah tariknya dari kanan ke kiri
                onDismissed: (direction) async {
                  // Aksi ketika item dihapus
                  await _jurnalHarianService.deleteJournal(jurnal.id);
                  _fetchData();

                  // Tampilkan snackbar sebagai konfirmasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${jurnal.deskripsiPekerjaan} dihapus')),
                  );
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailJurnalPage(jurnal: jurnal),
                      ),
                    );
                  },
                  child: JournalCard(
                    title: jurnal.deskripsiPekerjaan,
                    status: jurnal.status,
                    timeRange:
                        '${jurnal.jamMulai.format(context)} - ${jurnal.jamSelesai.format(context)}',
                    date: getFormattedDate(jurnal.tanggal),
                    typeOfWork: jurnal.jenisPekerjaan,
                    typeOfActivity: jurnal.bentukKegiatan,
                    photo: jurnal.foto,
                  ),
                ),
              );
            }).toList(),
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  width: 1,
                  color: Colors.red,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD8D1D1).withOpacity(0.3),
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                  ),
                ],
                color: Colors.red.withOpacity(0.4),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 53,
                  ),
                  child: Text(
                    "Kamu belum mengumpulkan Jurnal\nuntuk kehadiran Hari ini",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateJournalPage()),
          );

          if (result == true) {
            _fetchData();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Jurnal berhasil ditambahkan!')),
            );
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: SimpklColor.darkBlue,
        ),
      ),
    );
  }
}
