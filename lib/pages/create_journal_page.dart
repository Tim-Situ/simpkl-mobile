import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/contstants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class CreateJournalPage extends StatefulWidget {
  const CreateJournalPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateJournalPageState();
}

class _CreateJournalPageState extends State<CreateJournalPage> {
  File? _image;

  List<String> dataJenisPekerjaan = <String>['Sesuai Kompetensi Keahlian', 'Pekerjaan Lain'];
  List<String> dataBentukKegiatan = <String>['Mandiri', 'Bimbingan', 'Ditugaskan', 'Inisiatif'];

  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Batasan tanggal awal
      lastDate: DateTime(2100), // Batasan tanggal akhir
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"; // Format tanggal yang diinginkan
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Waktu default adalah waktu saat ini
    );

    if (pickedTime != null) {
      setState(() {
        // Format waktu dalam jam dan menit (misalnya: 14:30)
        _startTimeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Waktu default adalah waktu saat ini
    );

    if (pickedTime != null) {
      setState(() {
        // Format waktu dalam jam dan menit (misalnya: 14:30)
        _endTimeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dokumentasi berhasil diupload!'),
            duration: Duration(seconds: 2), // Durasi tampilan Snackbar
          ),
        );
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                color: SimpklColor.darkYellow,
                size: 16,
              ),
            ),
          ),
        ),
        title: const Text(
          "Tambah Jurnal",
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
              const Text(
                "Masukkan Data Jurnal yang yang sesuai dengan tugas Anda."
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _dateController, // Mengontrol teks dalam TextFormField
                  readOnly: true, // Membuat field hanya bisa dibuka, tidak bisa diketik manual
                  onTap: () async {
                    _selectDate(context); // Memunculkan date picker saat field di-tap
                  },
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: SimpklColor.darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
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
                          Icons.date_range_outlined,
                          color: SimpklColor.darkBlue,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Jenis Pekerjaan', // Label dropdown sama dengan TextFormField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: SimpklColor.darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: null,
                  onChanged: (String? value) {},
                  items: dataJenisPekerjaan.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: null,
                  minLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Pekerjaan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: SimpklColor.darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Bentuk Kegiatan', // Label dropdown sama dengan TextFormField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: SimpklColor.darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: null,
                  onChanged: (String? value) {},
                  items: dataBentukKegiatan.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _startTimeController, // Mengontrol teks dalam TextFormField
                  readOnly: true, // Membuat field hanya bisa dibuka, tidak bisa diketik manual
                  onTap: () async {
                    _selectStartTime(context); // Memunculkan time picker saat field di-tap
                  },
                  decoration: InputDecoration(
                    labelText: 'Jam Mulai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: SimpklColor.darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
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
                          Icons.access_time_outlined, // Mengganti ikon menjadi ikon jam
                          color: SimpklColor.darkBlue,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _endTimeController, // Mengontrol teks dalam TextFormField
                  readOnly: true, // Membuat field hanya bisa dibuka, tidak bisa diketik manual
                  onTap: () async {
                    _selectEndTime(context); // Memunculkan time picker saat field di-tap
                  },
                  decoration: InputDecoration(
                    labelText: 'Jam Selesai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: SimpklColor.darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
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
                          Icons.access_time_outlined, // Mengganti ikon menjadi ikon jam
                          color: SimpklColor.darkBlue,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Staff yang Menugaskan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: SimpklColor.darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: SimpklColor.darkBlue),
                ),
                child: InkWell(
                  onTap: _pickImage,
                  child: Center(
                    child: _image == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 50, color: SimpklColor.darkBlue),
                              SizedBox(height: 10),
                              Text(
                                'Click to upload',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'choose your photo from your file',
                                style: TextStyle(fontSize: 14, color: SimpklColor.darkBlue),
                              ),
                            ],
                          )
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  PanaraConfirmDialog.show(
                      context,
                      title: "Apakah Kamu Yakin?",
                      message: "Jurnal tidak bisa diedit atau dihapus setelah disimpan!",
                      confirmButtonText: "Yakin",
                      cancelButtonText: "Batal",
                      onTapCancel: () {
                          Navigator.pop(context);
                      },
                      onTapConfirm: () {
                          Navigator.pop(context);

                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.pop(context); // Kembali ke halaman sebelumnya
                          });
                      },
                      panaraDialogType: PanaraDialogType.normal,
                      barrierDismissible: false, // optional parameter (default is true)
                  );
                },
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Ink(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: SimpklColor.darkBlue,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Center(
                      child: Text(
                        "Submit Jurnal",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
