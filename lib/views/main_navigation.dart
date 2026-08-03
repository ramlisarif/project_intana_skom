import 'package:flutter/material.dart';

// Import Model & Pages
import 'package:project_intana_skom/models/guru_model.dart';
import 'package:project_intana_skom/views/even/event_page.dart';
import 'package:project_intana_skom/views/fitur_lain/form_perubahan_jadwal_page.dart';
import 'package:project_intana_skom/views/kbm/jadwal_hari_ini_page.dart';
import 'package:project_intana_skom/views/eskul/jadwal_eskul_page.dart';
import 'package:project_intana_skom/views/jadwal_csp/generate_jadwal_page.dart';
import 'package:project_intana_skom/views/lab/lab_page.dart'; // Import Halaman Generator CSP

class MainNavigation extends StatefulWidget {
  final GuruModel guru;

  const MainNavigation({super.key, required this.guru});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  static const Color schoolPrimary = Color(0xFF1D4ED8);
  static const Color bgCreamTop = Color(0xFFFAF7F0);
  static const Color bgCreamBottom = Color(0xFFECE7DB);

  @override
  void initState() {
    super.initState();
    // 6 TAB MENU UTAMA:
    _pages = [
      JadwalHariIniPage(guru: widget.guru), // Indeks 0 -> KBM
      LabPage(guru: widget.guru), // Indeks 1 -> Lab
      const GenerateJadwalPage(), // Indeks 2 -> Generator CSP (FITUR BARU TERPISAH)
      const EventPage(), // Indeks 3 -> Event
      const JadwalEskulPage(), // Indeks 4 -> Eskul
      const FormPerubahanJadwalPage(), // Indeks 5 -> Lainnya
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [bgCreamTop, bgCreamBottom],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 16,
            top: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE2DCD0), width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x221D4ED8),
                blurRadius: 18,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFFFFDF9),
              elevation: 0,
              selectedItemColor: schoolPrimary,
              unselectedItemColor: const Color(0xFF8C857B),
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_outlined),
                  activeIcon: Icon(Icons.school_rounded),
                  label: 'KBM',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.science_outlined),
                  activeIcon: Icon(Icons.science_rounded),
                  label: 'Lab',
                ),
                // FITUR BARU CSP TERPISAH DENGAN IKON PETIR / AI
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_awesome_outlined),
                  activeIcon: Icon(Icons.auto_awesome_rounded),
                  label: 'Jadwal CSP',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.campaign_outlined),
                  activeIcon: Icon(Icons.campaign_rounded),
                  label: 'Event',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_soccer_outlined),
                  activeIcon: Icon(Icons.sports_soccer_rounded),
                  label: 'Eskul',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined),
                  activeIcon: Icon(Icons.grid_view_rounded),
                  label: 'Lainnya',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
