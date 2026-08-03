import 'package:flutter/material.dart';
import 'detail_eskul_page.dart';

class JadwalEskulPage extends StatelessWidget {
  const JadwalEskulPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy Eskul dikelompokkan berdasarkan Hari
    final Map<String, List<Map<String, String>>> dataEskulPerHari = {
      'Senin': [
        {
          'nama_eskul': 'Pramuka',
          'kelas': 'Kelas 7 & 8',
          'jam': '15.00 - 17.00',
        },
        {
          'nama_eskul': 'Paskibra',
          'kelas': 'Kelas 7, 8 & 9',
          'jam': '15.30 - 17.00',
        },
      ],
      'Selasa': [
        {
          'nama_eskul': 'Futsal',
          'kelas': 'Semua Kelas',
          'jam': '15.30 - 17.30',
        },
        {
          'nama_eskul': 'English Club',
          'kelas': 'Kelas 7 & 8',
          'jam': '15.00 - 16.30',
        },
      ],
      'Rabu': [
        {
          'nama_eskul': 'Basket',
          'kelas': 'Semua Kelas',
          'jam': '15.30 - 17.30',
        },
      ],
      'Kamis': [
        {
          'nama_eskul': 'Seni Tari',
          'kelas': 'Kelas 7 & 8',
          'jam': '15.00 - 17.00',
        },
      ],
      'Jumat': [
        {
          'nama_eskul': 'PMR (Palang Merah Remaja)',
          'kelas': 'Semua Kelas',
          'jam': '14.00 - 16.00',
        },
      ],
      'Sabtu': [
        {
          'nama_eskul': 'Coding / IT Club',
          'kelas': 'Kelas 8 & 9',
          'jam': '08.00 - 11.00',
        },
        {
          'nama_eskul': 'Musik / Band',
          'kelas': 'Semua Kelas',
          'jam': '09.00 - 12.00',
        },
      ],
    };

    final daftarHari = dataEskulPerHari.keys.toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Bagian Ekstrakurikuler',
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
        itemCount: daftarHari.length,
        itemBuilder: (context, index) {
          final hari = daftarHari[index];
          final totalEskul = dataEskulPerHari[hari]?.length ?? 0;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2DCD0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sports_soccer_rounded,
                  color: Color(0xFF1D4ED8),
                ),
              ),
              title: Text(
                'Hari $hari',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1E293B),
                ),
              ),
              subtitle: Text(
                '$totalEskul Kegiatan Eskul',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFF1D4ED8),
              ),
              onTap: () {
                // NAVIGASI KE DETAIL ESKUL BERDASARKAN HARI
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailEskulPage(
                      hari: hari,
                      listEskul: dataEskulPerHari[hari] ?? [],
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