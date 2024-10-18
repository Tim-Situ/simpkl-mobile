import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/contstants/colors.dart';

class DetailJurnalPage extends StatefulWidget {
  const DetailJurnalPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetailJurnalPageState();
}

class _DetailJurnalPageState extends State<DetailJurnalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Container(
              // margin: EdgeInsets.only(left: 20),
              // height: 20,
              // width: 20,
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
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),
        title: const Text(
          "Detail Jurnal",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),  
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
                  ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jurnal 1",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            "24 November 2024",
                            style: TextStyle(
                              fontSize: 11
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                        decoration: BoxDecoration(
                          color: SimpklColor.darkRed,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Text(
                          "Ditolak",
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
                      color: Color(0xFFD3D1D8).withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ]
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Jenis Pekerjaan",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            ": Sesuai Kompetensi",
                            style: TextStyle(
                              fontSize: 11
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bentuk Kegiatan",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            ": Membuat Website",
                            style: TextStyle(
                              fontSize: 11
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Jam Pekerjaan",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            ": 07:30 - 16:30",
                            style: TextStyle(
                              fontSize: 11
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Staff yang Menugaskan",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            ": Mas Nur",
                            style: TextStyle(
                              fontSize: 11
                            ),
                          ),
                        ],
                      )
                    ],
                  )
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
                  ]
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deskripsi Pekerjaan",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "Saya merancang dan mengembangkan website responsif untuk perusahaan Online Media. Website ini akan berfungsi sebagai platform utama untuk mempromosikan layanan digital kami kepada pelaku bisnis.",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      
                    ],
                  )
                ),
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
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 12, left: 12, bottom: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://awsimages.detik.net.id/community/media/visual/2023/05/26/yuk-serbu-ada-pendidikan-dan-pelatihan-kerja-gratis_169.jpeg?w=600&q=90',
                            ),
                          )
                        )
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
                  ]
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Catatan Pembimbing",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "Terima kasih atas laporan yang telah kamu sampaikan mengenai proyek pembuatan website untuk Online Media. Saya sangat senang melihat perkembangan dan usaha yang telah kamu tunjukkan selama masa PKL ini.",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      
                    ],
                  )
                ),
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
