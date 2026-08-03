import 'package:flutter/material.dart';
import '../../models/guru_model.dart';
import 'jadwal_lab_kelas_page.dart';

class LabPage extends StatelessWidget {
  final GuruModel guru;

  const LabPage({super.key, required this.guru});

  @override
  Widget build(BuildContext context) {
    // Data jadwal laboratorium TP 2023/2024 Semester Genap dari dokumen
    final Map<String, List<Map<String, String>>> dataJadwal = {
      'Kelas VII': [
        {
          'jam': '11.20 - 12.40',
          'hari': 'Selasa',
          'guru': 'Fahria Kasim, S.Pd',
        },
        {'jam': '12.00 - 13.10', 'hari': 'Rabu', 'guru': '-'},
      ],
      'Kelas VIII': [
        {'jam': '11.20 - 12.00', 'hari': 'Rabu', 'guru': 'Rosita Kamis, S.Pd'},
        {
          'jam': '11.20 - 12.40',
          'hari': 'Kamis',
          'guru': 'Adewanti Maksud, S.Pd',
        },
      ],
      'Kelas IX': [
        {'jam': '10.00 - 11.20', 'hari': 'Rabu', 'guru': 'Fahria Kasim, S.Pd'},
        {'jam': '07.30 - 09.30', 'hari': 'Kamis', 'guru': 'Fahria Kasim, S.Pd'},
      ],
    };

    final daftarKelas = ['Kelas VII', 'Kelas VIII', 'Kelas IX'];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Pilih Kelas Lab',
          style: TextStyle(
            color: Color(0xFF1D4ED8),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarKelas.length,
        itemBuilder: (context, index) {
          final namaKelas = daftarKelas[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2DCD0)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF1D4ED8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.computer_rounded, color: Colors.white),
              ),
              title: Text(
                namaKelas,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1E293B),
                ),
              ),
              subtitle: const Text(
                'Klik untuk melihat jam, hari & guru',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Color(0xFF1D4ED8),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JadwalLabKelasPage(
                      namaKelas: namaKelas,
                      jadwalList: dataJadwal[namaKelas] ?? [],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
