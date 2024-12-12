import 'package:flutter/material.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:simpkl_mobile/main.dart';
import 'package:simpkl_mobile/pages/homepage_page.dart';
import 'package:simpkl_mobile/services/auth_service.dart';

class logIn extends StatefulWidget {
  const logIn({super.key});

  @override
  State<logIn> createState() => _LogInState();
}

class _LogInState extends State<logIn> {
  final _formKey = GlobalKey<FormState>(); // Key untuk Form
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _authService = AuthService();

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final success = await _authService.login(username, password);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login berhasil!')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey, // Key untuk validasi form
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Foto di tengah
                  Image.asset(
                    'assets/img/logoPrakeran.png', // Ganti dengan path gambar Anda
                    width: 182,
                    height: 182,
                  ),
                  const SizedBox(height: 20), // Jarak antara foto dan teks

                  // Teks "Login with Access Data"
                  const Text(
                    "Login With Access Data",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 5), // Jarak antara dua teks

                  // Teks "Live every day of field work practice..."
                  const Text(
                    "Live every day of field work practice in a more comfortable way",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30), // Jarak sebelum input username

                  // Input untuk Username dengan icon orang
                  TextFormField(
                    controller:
                        _usernameController, // Controller untuk username
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors
                                .orange), // Border warna orange saat normal
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username Tidak Boleh Kosong'; // Pesan peringatan jika kosong
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                      height: 20), // Jarak antara username dan password

                  // Input untuk Password dengan icon gembok
                  TextFormField(
                    controller:
                        _passwordController, // Controller untuk password
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors
                                .orange), // Border warna orange saat normal
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Tidak Boleh Kosong'; // Pesan peringatan jika kosong
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30), // Jarak sebelum tombol login

                  // Tombol Login
                  SizedBox(
                    width: double.infinity,
                    height: 50, // Tinggi tombol login
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            SimpklColor.darkBlue, // Warna background biru
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius 10
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white, // Teks berwarna putih
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
