import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD3D1D8).withOpacity(0.3),
                    offset: Offset(5, 10),
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD3D1D8).withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Membuat Website",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            getFormattedDate(jurnal.tanggal),
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                        decoration: BoxDecoration(
                            color: SimpklColor.darkRed,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          "Ditolak",
                          style: TextStyle(fontSize: 12, color: Colors.white),
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
                        color: Color(0xFFD3D1D8).withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ]),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jenis Pekerjaan",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ": ${jurnal.jenisPekerjaan}",
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bentuk Kegiatan",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ": ${jurnal.bentukKegiatan}",
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jam Pekerjaan",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ": ${jurnal.jamMulai.format(context)} - ${jurnal.jamSelesai.format(context)}",
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Staff yang Menugaskan",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              ": ${jurnal.staf}",
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD3D1D8).withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ]),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi Pekerjaan",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          jurnal.deskripsiPekerjaan,
                          style: TextStyle(
                            fontSize: 11,
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
                      color: Color(0xFFD3D1D8).withOpacity(0.3),
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
                      title: Text(
                        'Foto Kegiatan',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
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
                        color: Color(0xFFD3D1D8).withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ]),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Catatan Pembimbing",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Belum Ada Catatan",
                          style: TextStyle(
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
