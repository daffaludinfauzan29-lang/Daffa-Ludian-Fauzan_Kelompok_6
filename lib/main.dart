// import 'package:flutter/material.dart';
// import 'constants/colors.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//     );
//   }
// } //MyApp
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int currentindex =0;
//
//   final List<Widget> pages = const [
//     HomeContent(),
//     // Content2(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Riyan App'),
//       ), // AppBar
//       body: pages[currentindex],
//
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentindex,
//
//           onTap: (index) {
//           setState(() {
//             currentindex = index;
//           });
//         },
//
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//           ),
//         ],
//       ), // BottomNavigationBar
//     ); // Scaffold
//   }
// }
//
// class HomeContent extends StatelessWidget {
//   const HomeContent ({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Selamat Datang",
//             style: TextStyle(
//               fontWeight: FontWeight.w900,
//               fontSize: 24,
//           )),
//           Container(
//             width: 300,
//             height: 20,
//             color: Colors.grey,
//           ),
//           const Padding(padding: EdgeInsets.only(bottom: 20)),
//           Container(
//             width: 400,
//             height: 20,
//             color: Colors.grey,
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 50,
//                   // color: Colors.red,
//                   decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
//                 )),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Container(
//                   height: 50,
//                   color: AppColors.primary,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FormPraktikumPage(),
    );
  }
}

class FormPraktikumPage extends StatefulWidget {
  const FormPraktikumPage({super.key});

  @override
  State<FormPraktikumPage> createState() => _FormPraktikumPageState();
}

class _FormPraktikumPageState extends State<FormPraktikumPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _mataKuliahController = TextEditingController();

  final List<String> _pilihanKehadiran = ['Hadir', 'Izin', 'Sakit'];
  String? _keterangan;
  bool _sedangMenyimpan = false;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _lokasiController.dispose();
    _mataKuliahController.dispose();
    super.dispose();
  }

  String? _wajibDiisi(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label wajib diisi';
    }
    return null;
  }

  Future<void> simpanData() async {
    // Validasi: batal kirim kalau ada field wajib yang kosong
    if (!_formKey.currentState!.validate()) return;

    setState(() => _sedangMenyimpan = true);

    try {
      await FirebaseFirestore.instance.collection('praktikum').add({
        'nama': _namaController.text.trim(),
        'nim': _nimController.text.trim(),
        'lokasi': _lokasiController.text.trim(),
        'mata_kuliah': _mataKuliahController.text.trim(),
        'keterangan': _keterangan,
        'waktu': FieldValue.serverTimestamp(),
      });

      // Kosongkan semua field setelah berhasil
      _namaController.clear();
      _nimController.clear();
      _lokasiController.clear();
      _mataKuliahController.clear();
      _formKey.currentState!.reset();
      setState(() => _keterangan = null);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil disimpan'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _sedangMenyimpan = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Praktikum Firebase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _wajibDiisi(v, 'Nama'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _wajibDiisi(v, 'NIM'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lokasiController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _wajibDiisi(v, 'Lokasi'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mataKuliahController,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _wajibDiisi(v, 'Mata Kuliah'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _keterangan,
                decoration: const InputDecoration(
                  labelText: 'Keterangan Kehadiran',
                  border: OutlineInputBorder(),
                ),
                items: _pilihanKehadiran
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _keterangan = v),
                validator: (v) =>
                v == null ? 'Keterangan kehadiran wajib dipilih' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _sedangMenyimpan ? null : simpanData,
                  child: _sedangMenyimpan
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}