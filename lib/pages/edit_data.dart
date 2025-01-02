import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:simpkl_mobile/services/auth_service.dart';
import 'package:simpkl_mobile/services/jurnal_harian_service.dart';

class EditDataPage extends StatefulWidget {
  final String nama;
  final String alamat;
  final String no_hp;
  final DateTime tanggal_lahir;
  final String tempat_lahir;

  const EditDataPage({super.key, 
  required this.nama,
  required this.alamat,
  required this.no_hp,
  required this.tanggal_lahir,
  required this.tempat_lahir,
  });

  @override
  State<StatefulWidget> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  File? _image;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();


  final ImagePicker _picker = ImagePicker();
  final AuthService _authService = AuthService();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Batasan tanggal awal
      lastDate: DateTime(2100), // Batasan tanggal akhir
    );

    if (pickedDate != null) {
      setState(() {
        _tanggalLahirController.text = DateFormat('yyyy-MM-dd').format(pickedDate); // Format tanggal yang diinginkan
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
              content: Text('Foto berhasil diupload!'),
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
    if (_namaController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _nomorHpController.text.isEmpty ||
        _tempatLahirController.text.isEmpty ||
        _tanggalLahirController.text.isEmpty ||
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
      await _authService.editProfile(
        nama: _namaController.text,
        alamat: _alamatController.text,
        no_hp: _nomorHpController.text,
        tempat_lahir: _tempatLahirController.text,
        tanggal_lahir: _tanggalLahirController.text,
        fileFoto: _image!,
      );

      // Clear fields after submission
      setState(() {
        _image = null;
        _namaController.clear();
        _alamatController.clear();
        _nomorHpController.clear();
        _tempatLahirController.clear();
        _tanggalLahirController.clear();
      });

      Navigator.pop(context, true);

    } catch (e) {
      // Handle error submitting form
      PanaraInfoDialog.show(
        context,
        title: "Gagal",
        message: "Terjadi kesalahan saat mengubah profile.",
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
    _namaController.text = widget.nama;
    _alamatController.text = widget.alamat;
    _nomorHpController.text = widget.no_hp;
    _tempatLahirController.text = widget.tempat_lahir;
    _tanggalLahirController.text = DateFormat('dd MMMM yyyy', 'id_ID').format(widget.tanggal_lahir);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFFE86D38),
          ),
        ),
        centerTitle: true,
        title: const Text(
            'Data Perusahaan',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ubah Data yang Anda inginkan, masukkan data yang sesuai dengan diri Anda.",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: _image != null
                            ? ClipOval(
                                child: Image.file(
                                  _image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "NAMA",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close, color: Color(0xFFE86D38)),
                          onPressed: () {
                            _namaController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "ALAMAT",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: _alamatController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close, color: Color(0xFFE86D38)),
                          onPressed: () {
                            _alamatController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "NO HP",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: _nomorHpController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close, color: Color(0xFFE86D38)),
                          onPressed: () {
                            _nomorHpController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "TEMPAT LAHIR",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: _tempatLahirController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close, color: Color(0xFFE86D38)),
                          onPressed: () {
                            _tempatLahirController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "TANGGAL LAHIR",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
                      controller: _tanggalLahirController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE86D38)),
                        ),
                        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFE86D38)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE86D38),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "Konfirmasi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
