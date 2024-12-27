import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:simpkl_mobile/models/jurnal_harian_model.dart';

class DetailJurnalPage extends StatefulWidget {
  final JurnalHarianModel jurnal;

  const DetailJurnalPage({super.key, required this.jurnal});

  @override
  State<StatefulWidget> createState() => _DetailJurnalPageState();
}

class _DetailJurnalPageState extends State<DetailJurnalPage> {

  String getFormattedDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  Color getStatusColor(String status) {
    if (status == "DITERIMA") {
      return SimpklColor.darkGreen;
    } else if (status == "DITOLAK") {
      return SimpklColor.darkRed;
    } else if (status == "MENUNGGU") {
      return SimpklColor.darkYellow;
    } else {
      return Colors.grey; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    final jurnal = widget.jurnal;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD3D1D8).withOpacity(0.3),
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),
        title: const Text(
          "Detail Jurnal",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent, // Menghapus warna latar belakang
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD3D1D8).withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getFormattedDate(jurnal.tanggal),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                        decoration: BoxDecoration(
                            color: getStatusColor(jurnal.status),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "${jurnal.status}",
                          style: TextStyle(
                            fontSize: 12, 
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
  width: MediaQuery.of(context).size.width,
  margin: const EdgeInsets.symmetric(vertical: 5),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFFD3D1D8).withOpacity(0.3),
        blurRadius: 20,
      ),
    ],
  ),
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Jenis Pekerjaan",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              ":",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${jurnal.jenisPekerjaan}",
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Bentuk Kegiatan",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              ":",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${jurnal.bentukKegiatan}",
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Jam Pekerjaan",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              ":",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${jurnal.jamMulai.format(context)} - ${jurnal.jamSelesai.format(context)}",
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Staff yang Menugaskan",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              ":",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${jurnal.staf}",
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),


              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD3D1D8).withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ]),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Deskripsi Pekerjaan",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          jurnal.deskripsiPekerjaan,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD3D1D8).withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: Colors.white,
                      title: const Text(
                        'Foto Kegiatan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 12, left: 12, bottom: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                jurnal.foto,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD3D1D8).withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ]),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Catatan Pembimbing",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          jurnal.catatanPembimbing ?? 'Tidak ada catatan pembimbing.',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
