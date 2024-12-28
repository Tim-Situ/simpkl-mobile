import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/database/database_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpkl_mobile/pages/edit_data.dart';

class DataSiswaPage extends StatefulWidget {
  const DataSiswaPage({super.key});

  @override
  DataSiswaPageState createState() => DataSiswaPageState();
}

class DataSiswaPageState extends State<DataSiswaPage> {
  ProfileModel? dataDariDb;

  void getProfile() async {
    dataDariDb = await DatabaseHelper().getProfile();
    setState(() {});
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      String newPhotoUrl = await uploadImageToDatabase(image.path);

      setState(() {
        dataDariDb?.foto = newPhotoUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto berhasil diubah')),
      );
    }
  }

  Future<String> uploadImageToDatabase(String imagePath) async {
    await Future.delayed(const Duration(seconds: 2));
    return "https://your-database-url.com/new-photo-url.jpg";
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  void _navigateToEdit(BuildContext context, String field, String currentValue) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditDataPage(
    //       // title: 'Ubah $field',
    //       // field: field.toLowerCase(),
    //       // currentValue: currentValue,
    //       // onSave: (String newValue) {
    //         // getProfile();
    //       // },
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDataEmpty = dataDariDb == null ||
        (dataDariDb?.nisn == null &&
            dataDariDb?.nama == null &&
            dataDariDb?.alamat == null &&
            dataDariDb?.noHp == null &&
            dataDariDb?.jurusan == null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Data Siswa',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      body: isDataEmpty
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.2,
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
                      "Data Pribadi Anda Kosong",
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
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(dataDariDb?.foto ??
                              "https://gambarpkl.blob.core.windows.net/gambar-simpkl/1735314679-user-profile.png"),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: _pickAndUploadImage, // Fungsi untuk memilih dan mengunggah foto
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF2C55D3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit_square,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDataItem(
                    Icons.credit_card,
                    dataDariDb?.nisn ?? "Not Found",
                    canEdit: false,
                  ),
                  _buildDataItem(
                    Icons.person,
                    dataDariDb?.nama ?? "Not Found",
                    canEdit: true,
                    onEdit: () => _navigateToEdit(
                        context, 'Nama', dataDariDb?.nama ?? ""),
                  ),
                  _buildDataItem(
                    Icons.location_on,
                    dataDariDb?.alamat ?? "Not Found",
                    canEdit: true,
                    onEdit: () => _navigateToEdit(
                        context, 'Alamat', dataDariDb?.alamat ?? ""),
                  ),
                  _buildDataItem(
                    Icons.call,
                    dataDariDb?.noHp ?? "Not Found",
                    canEdit: true,
                    onEdit: () => _navigateToEdit(
                        context, 'Nomor HP', dataDariDb?.noHp ?? ""),
                  ),
                  _buildDataItem(
                    Icons.date_range,
                    dataDariDb?.tanggalLahir != null
                        ? "${dataDariDb?.tempatLahir ?? 'Not Found'}, ${getFormattedDate(dataDariDb!.tanggalLahir)}"
                        : "Not Found",
                    canEdit: true,
                    onEdit: () => _navigateToEdit(
                        context,
                        'Tempat dan Tanggal Lahir',
                        "${dataDariDb?.tempatLahir ?? ''}, ${dataDariDb?.tanggalLahir != null ? getFormattedDate(dataDariDb!.tanggalLahir) : ''}"),
                  ),
                  _buildDataItem(
                    Icons.school,
                    dataDariDb?.jurusan ?? "Not Found",
                    canEdit: false,
                  ),
                  _buildDataItem(
                    Icons.power_settings_new_sharp,
                    dataDariDb?.statusAktif == true ? "Aktif" : "Tidak Aktif",
                    canEdit: false,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDataItem(IconData icon, String text,
      {bool canEdit = false, VoidCallback? onEdit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0F5FF),
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFCDD9FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: const Color(0xFF2C55D3),
                size: 20,
              ),
            ),
          ),
          title: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
          trailing: canEdit 
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8), // Add spacing if needed
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCDD9FF),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF2C55D3),
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: onEdit,
                  ),
                ),
              ],
            )
          : null,
        ),
      ),
    );
  }
}
