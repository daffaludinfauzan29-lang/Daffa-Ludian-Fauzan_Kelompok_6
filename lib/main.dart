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


import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Universitas Esa Unggul',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tekan tombol di bawah untuk melihat tautan atau menguji fungsi.',
            ),
            const SizedBox(height: 24),

            // Tombol 1: Google Maps (Warna Biru)
            AppButton(
              label: 'Buka Google Maps',
              icon: Icons.location_on,
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              url: 'https://www.google.com/maps/search/?api=1&query=Universitas+Esa+Unggul',
            ),

            const SizedBox(height: 16),

            // Tombol 2: Profile GitHub (Warna Hitam / GitHub Dark)
            AppButton(
              label: 'Buka GitHub',
              icon: Icons.code,
              backgroundColor: const Color(0xFF24292E),
              foregroundColor: Colors.white,
              url: 'https://github.com/stefanuslianto19-lang',
            ),

            const SizedBox(height: 16),

            // Tombol 3: Tes Tombol (Warna Hijau Teal)
            AppButton(
              label: 'Tes Tombol',
              icon: Icons.touch_app,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              onPressed: () {
                debugPrint('Tombol berhasil ditekan!');
              },
            ),
          ],
        ),
      ),
    );
  }
}