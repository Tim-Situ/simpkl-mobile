import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:simpkl_mobile/services/jurnal_harian_service.dart';

class CreateJournalPage extends StatefulWidget {
  const CreateJournalPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateJournalPageState();
}

class _CreateJournalPageState extends State<CreateJournalPage> {
  File? _image;

  List<String> dataJenisPekerjaan = <String>[
    'Sesuai Kompetensi Keahlian',
    'Pekerjaan Lain'
  ];
  List<String> dataBentukKegiatan = <String>[
    'Mandiri',
    'Bimbingan',
    'Ditugaskan',
    'Inisiatif'
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String? selectedJobType;
  String? selectedActivityForm;
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _staffController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final JurnalHarianService _journalService = JurnalHarianService();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Batasan tanggal awal
      lastDate: DateTime(2100), // Batasan tanggal akhir
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate); // Format tanggal yang diinginkan
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
        // Format waktu menjadi HH:mm:ss (jam:menit:detik)
        _startTimeController.text =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
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
        // Format waktu menjadi HH:mm:ss (jam:menit:detik)
        _endTimeController.text =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      // Menampilkan dialog untuk memilih galeri atau kamera
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pilih Sumber Gambar'),
            content: const Text('Pilih sumber gambar:'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: const Text('Kamera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: const Text('Galeri'),
              ),
            ],
          );
        },
      );

      if (source != null) {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Dokumentasi berhasil diupload!'),
              duration: Duration(seconds: 2), // Durasi tampilan Snackbar
            ),
          );
        }
      } else {
        // print("No image selected.");
      }
    } catch (e) {
      // print("Error picking image: $e");
    }
  }

  Future<void> _submitForm() async {
    if (_dateController.text.isEmpty ||
        selectedJobType == null ||
        selectedActivityForm == null ||
        _jobDescriptionController.text.isEmpty ||
        _startTimeController.text.isEmpty ||
        _endTimeController.text.isEmpty ||
        _staffController.text.isEmpty ||
        _image == null) {
          print("KOSONG");
          PanaraInfoDialog.show(
            context,
            title: "Peringatan",
            message: "Semua data harus diisi dengan lengkap.",
            buttonText: "Okay",
            onTapDismiss: () {
                Navigator.pop(context);
            },
            panaraDialogType: PanaraDialogType.normal,
          );
          return;
        }

    try {
      await _journalService.addJournal(
        hari: _dateController.text,
        tanggal: _dateController.text,
        jenisPekerjaan: selectedJobType!,
        deskripsiPekerjaan: _jobDescriptionController.text,
        bentukKegiatan: selectedActivityForm!,
        jamMulai: _startTimeController.text,
        jamSelesai: _endTimeController.text,
        staf: _staffController.text,
        fileFoto: _image!,
      );

      // Clear fields after submission
      setState(() {
        _image = null;
        _dateController.clear();
        _startTimeController.clear();
        _endTimeController.clear();
        _jobDescriptionController.clear();
        _staffController.clear();
        selectedJobType = null;
        selectedActivityForm = null;
      });

      Navigator.pop(context, true);

    } catch (e) {
      // Handle error submitting form
      PanaraInfoDialog.show(
        context,
        title: "Gagal",
        message: "Terjadi kesalahan saat menyimpan jurnal.",
        buttonText: "Okay",
        onTapDismiss: () {
            Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.normal,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Set default date to today
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                color: SimpklColor.darkYellow,
                size: 16,
              ),
            ),
          ),
        ),
        title: const Text(
          "Tambah Jurnal",
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
              const Text(
                  "Masukkan Data Jurnal yang yang sesuai dengan tugas Anda."),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller:
                      _dateController, // Mengontrol teks dalam TextFormField
                  readOnly:
                      true, // Membuat field hanya bisa dibuka, tidak bisa diketik manual
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: SimpklColor
                              .darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD3D1D8).withOpacity(0.3),
                              offset: const Offset(5, 10),
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
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText:
                        'Jenis Pekerjaan', // Label dropdown sama dengan TextFormField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: SimpklColor
                              .darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: selectedJobType,
                  onChanged: (String? value) {
                    setState(() {
                      selectedJobType = value;
                    });
                  },
                  items: dataJenisPekerjaan
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _jobDescriptionController,
                  maxLines: null,
                  minLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Pekerjaan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: SimpklColor
                              .darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText:
                        'Bentuk Kegiatan', // Label dropdown sama dengan TextFormField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: SimpklColor
                              .darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: selectedActivityForm,
                  onChanged: (String? value) {
                    setState(() {
                      selectedActivityForm = value;
                    });
                  },
                  items: dataBentukKegiatan
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller:
                      _startTimeController, // Mengontrol teks dalam TextFormField
                  readOnly:
                      true, // Membuat field hanya bisa dibuka, tidak bisa diketik manual
                  onTap: () async {
                    _selectStartTime(
                        context); // Memunculkan time picker saat field di-tap
                  },
                  decoration: InputDecoration(
                    labelText: 'Jam Mulai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: SimpklColor
                              .darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD3D1D8).withOpacity(0.3),
                              offset: const Offset(5, 10),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons
                              .access_time_outlined, // Mengganti ikon menjadi ikon jam
                          color: SimpklColor.darkBlue,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller:
                      _endTimeController, // Mengontrol teks dalam TextFormField
                  readOnly:
                      true, // Membuat field hanya bisa dibuka, tidak bisa diketik manual
                  onTap: () async {
                    _selectEndTime(
                        context); // Memunculkan time picker saat field di-tap
                  },
                  decoration: InputDecoration(
                    labelText: 'Jam Selesai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: SimpklColor
                              .darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD3D1D8).withOpacity(0.3),
                              offset: const Offset(5, 10),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons
                              .access_time_outlined, // Mengganti ikon menjadi ikon jam
                          color: SimpklColor.darkBlue,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _staffController,
                  decoration: InputDecoration(
                    labelText: 'Staff yang Menugaskan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: SimpklColor
                              .darkBlue), // Border warna grey saat normal
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                              Icon(Icons.cloud_upload_outlined,
                                  size: 50, color: SimpklColor.darkBlue),
                              SizedBox(height: 10),
                              Text(
                                'Click to upload',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'choose your photo from your file',
                                style: TextStyle(
                                    fontSize: 14, color: SimpklColor.darkBlue),
                              ),
                            ],
                          )
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  PanaraConfirmDialog.show(
                    context,
                    title: "Apakah Kamu Yakin?",
                    message:
                        "Jurnal tidak bisa diedit atau dihapus setelah disimpan!",
                    confirmButtonText: "Yakin",
                    cancelButtonText: "Batal",
                    onTapCancel: () {
                      Navigator.pop(context);
                    },
                    onTapConfirm: () {
                      _submitForm();
                      Navigator.pop(context);
                    },
                    panaraDialogType: PanaraDialogType.normal,
                    barrierDismissible:
                        false, // optional parameter (default is true)
                  );
                },
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Ink(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
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
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
