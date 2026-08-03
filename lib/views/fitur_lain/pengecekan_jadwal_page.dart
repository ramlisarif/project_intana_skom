import 'package:flutter/material.dart';
import '../jadwal_csp/generate_jadwal_page.dart'; // Import halaman generator

class PengecekanJadwalPage extends StatelessWidget {
  const PengecekanJadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitur Lainnya'),
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // TOMBOL MENU GENERATOR JADWAL CSP
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF1D4ED8),
                child: Icon(Icons.auto_awesome, color: Colors.white),
              ),
              title: const Text(
                'Generator Jadwal Otomatis (CSP)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Susun jadwal KBM bebas bentrok menggunakan AI/CSP'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenerateJadwalPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}