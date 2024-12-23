import 'package:flutter/material.dart';
import 'package:simpkl_mobile/models/daftar_nilai.dart';
import 'package:simpkl_mobile/services/nilai_akhir_service.dart';

class NilaiAkhir extends StatefulWidget {
  const NilaiAkhir({super.key});

  @override
  State<NilaiAkhir> createState() => _NilaiAkhirState();
}

class _NilaiAkhirState extends State<NilaiAkhir> {
  List<DaftarNilai> results = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    try {
      final fetchedData = await NilaiAkhirService().fetchNilai();
      setState(() {
        results = fetchedData;
      });
    } catch (e) {
      // print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                // Header dengan Teks dan Icon Lonceng
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Kontainer untuk teks "Nilai Akhir" dan deskripsinya
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nilai Akhir',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Penilaian diberikan oleh Guru Pembimbing',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tombol Lonceng Notif
                    IconButton(
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background
                          borderRadius:
                              BorderRadius.circular(10), // Border radius 10
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), // Warna bayangan
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(
                            8.0), // Padding penempatkan icon di tengah
                        child: const Icon(
                          Icons.notifications_none,
                          size: 32.0,
                          color: Colors.black, //  icon
                        ),
                      ),
                      onPressed: () {
                        // Aksi ketika tombol lonceng ditekan
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Notifikasi ditekan'),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // ListView Builder untuk Daftar Nilai
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final nilai = results[index];

                    return NilaiCard(nilai: nilai);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Card untuk setiap nilai dengan garis vertikal dan layout interaktif
class NilaiCard extends StatefulWidget {
  final DaftarNilai nilai;

  const NilaiCard({super.key, required this.nilai});

  @override
  NilaiCardState createState() => NilaiCardState();
}

class NilaiCardState extends State<NilaiCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAspek(widget.nilai.aspekPenilaian.kelompokPenilaian),
                    const SizedBox(height: 8.0),
                    const Text(
                      "Sub Aspek Penilaian",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.nilai.aspekPenilaian.judul,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(
                width: 32.0,
                thickness: 1.0,
                color: Colors.grey,
              ),
              Column(
                children: [
                  Text(
                    '${widget.nilai.nilai}',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_sharp,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          if (_isExpanded) ...[
            const SizedBox(height: 20),
            Container(
              alignment:
                  Alignment.topLeft, // Pastikan teks mulai dari kiri atas
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deskripsi Penilaian",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.nilai.keterangan,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }

  //  untuk menampilkan Aspek dengan latar belakang biru
  Widget _buildAspek(String aspek) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Aspek $aspek',
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
