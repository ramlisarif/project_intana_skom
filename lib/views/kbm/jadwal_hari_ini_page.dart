import 'package:flutter/material.dart';
import '../../models/guru_model.dart';
import 'pilih_kelas_page.dart';

class JadwalHariIniPage extends StatelessWidget {
  final GuruModel guru;
  const JadwalHariIniPage({super.key, required this.guru});

  @override
  Widget build(BuildContext context) {
    // Master Data sesuai diagram
    final Map<String, Map<String, List<Map<String, String>>>> masterJadwal = {
      "Senin": {
        "Kelas 7": [
          {
            'mapel': 'Bahasa Indonesia',
            'jam': '07:30 - 09:30 WIT',
            'guru': 'Bu Baradi,S.Pd',
          },
          {
            'mapel': 'Matematika',
            'jam': '10:00 - 11:30 WIT',
            'guru': 'Mas’ud, S.Pd',
          },
        ],
        "Kelas 8": [
          {
            'mapel': 'matematika',
            'jam': '07:30-09:30',
            'guru': 'Bu Marlia Mahmud,S.Pd',
          },
        ],
        "Kelas 9": [
          {
            'mapel': 'Bahasa Inggris',
            'jam': '08:00 - 10:00 WIT',
            'guru': 'Nurdiana Mahmud, SH',
          },
        ],
      },
      "Selasa": {
        "Kelas 11": [
          {
            'mapel': ' Ipa(ilmu pengetahuan alam)',
            'jam': '10:15 - 11:45 WIT',
            'guru': 'Bu Fahria Kasim, S.Pd',
          },
        ],
        "Kelas 8": [
          {
            'mapel': 'IPS',
            'jam': '07:30 - 09:00 WIT',
            'guru': 'Dandi Karim, S.Pd',
          },
        ],
        "Kelas 9": [],
      },
      "Rabu": {
        "Kelas 7": [],
        "Kelas 8": [],
        "Kelas 9": [
          {
            'mapel': 'Seni Budaya',
            'jam': '08:00 - 10:00 WIT',
            'guru': 'Marlia Mahmud, S.Pd',
          },
        ],
      },
      "Kamis": {"Kelas 7": [], "Kelas 8": [], "Kelas 9": []},
      "Jumat": {"Kelas 7": [], "Kelas 8": [], "Kelas 9": []},
      "Sabtu": {"Kelas 7": [], "Kelas 8": [], "Kelas 9": []},
    };

    final List<String> daftarHari = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'KBM - ${guru.nama}',
          style: const TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
          final dataKelasHariIni = masterJadwal[hari] ?? {};

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,

                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: Color(0xFF1E3A8A),
                  size: 22,
                ),
              ),
              title: Text(
                'Hari $hari',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF1E3A8A),
                size: 18,
              ),
              onTap: () {
                // NAVIGASI 1: Dari Hari ke Pilih Kelas
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PilihKelasPage(
                      hari: hari,
                      daftarKelasJadwal: dataKelasHariIni,
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
