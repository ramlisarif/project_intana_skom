import 'package:flutter/material.dart';

class JadwalPerKelasPage extends StatelessWidget {
  final String namaHari;
  final String namaKelas;

  const JadwalPerKelasPage({
    super.key,
    required this.namaHari,
    required this.namaKelas,
  });

  // Master Data Jadwal Mengajar dariFoto Dokumen (Senin - Sabtu)
  static const Map<String, Map<String, List<Map<String, String>>>>
  masterJadwal = {
    'Hari Senin': {
      'Kelas 7': [
        {'jam': '07.00 - 07.30 WIT', 'mapel': 'UPACARA', 'guru': '-'},
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'BHS.INDONESIA',
          'guru': 'Raisanti Baradi, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'BHS.INGGRIS',
          'guru': 'Yenny Mas\'ud, S.Pd',
        },
        {
          'jam': '11.20 - 13.10 WIT',
          'mapel': 'PPKN',
          'guru': 'Uliyanti Robo, S.Pd',
        },
      ],
      'Kelas 8': [
        {'jam': '07.00 - 07.30 WIT', 'mapel': 'UPACARA', 'guru': '-'},
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'MATEMATIKA',
          'guru': 'Marlia Mahmud, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'IPA',
          'guru': 'Fahria Kasim, S.Pd',
        },
        {
          'jam': '11.20 - 13.10 WIT',
          'mapel': 'PEN.AGAMA ISLAM',
          'guru': 'Nurdiana Mahmud, SH',
        },
      ],
      'Kelas 9': [
        {'jam': '07.00 - 07.30 WIT', 'mapel': 'UPACARA', 'guru': '-'},
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'IPA',
          'guru': 'Fahria Kasim, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'TIKOM',
          'guru': 'Dandi Karim, S.Pd',
        },
        {
          'jam': '11.20 - 13.10 WIT',
          'mapel': 'MATEMATIKA',
          'guru': 'Marlia Mahmud, S.Pd',
        },
      ],
    },
    'Hari Selasa': {
      'Kelas 7': [
        {
          'jam': '07.30 - 08.50 WIT',
          'mapel': 'IPS',
          'guru': 'Sarina Abubakar, S.Pd',
        },
        {
          'jam': '08.50 - 10.00 WIT',
          'mapel': 'IPA',
          'guru': 'Fahria Kasim, S.Pd',
        },
        {'jam': '10.00 - 10.40 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.40 - 12.00 WIT',
          'mapel': 'MATEMATIKA',
          'guru': 'Marlia Mahmud, S.Pd',
        },
        {
          'jam': '12.00 - 13.30 WIT',
          'mapel': 'BHS.INDONESIA',
          'guru': 'Raisanti Baradi, S.Pd',
        },
      ],
      'Kelas 8': [
        {
          'jam': '07.30 - 08.10 WIT',
          'mapel': 'MATEMATIKA',
          'guru': 'Marlia Mahmud, S.Pd',
        },
        {
          'jam': '08.10 - 09.30 WIT',
          'mapel': 'BHS.INGGRIS',
          'guru': 'Yenny Mas\'ud, S.Pd',
        },
        {
          'jam': '09.30 - 10.00 WIT',
          'mapel': 'IPS',
          'guru': 'Sarina Abubakar, S.Pd',
        },
        {'jam': '10.00 - 10.40 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.40 - 11.20 WIT',
          'mapel': 'IPS',
          'guru': 'Sarina Abubakar, S.Pd',
        },
        {
          'jam': '11.20 - 13.00 WIT',
          'mapel': 'PPKN',
          'guru': 'Maryani Albugis, S.Pd',
        },
        {
          'jam': '13.00 - 13.30 WIT',
          'mapel': 'IPA',
          'guru': 'Fahria Kasim, S.Pd',
        },
      ],
      'Kelas 9': [
        {
          'jam': '07.30 - 08.50 WIT',
          'mapel': 'BHS.INGGRIS',
          'guru': 'Yenny Mas\'ud, S.Pd',
        },
        {
          'jam': '08.50 - 10.00 WIT',
          'mapel': 'PRAKARYA',
          'guru': 'Maryani Albugis, S.Pd',
        },
        {'jam': '10.00 - 10.40 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.40 - 12.00 WIT',
          'mapel': 'IPA',
          'guru': 'Fahria Kasim, S.Pd',
        },
        {
          'jam': '12.00 - 13.30 WIT',
          'mapel': 'PEN.AGAMA ISLAM',
          'guru': 'Dandi Karim, S.Pd',
        },
      ],
    },
    'Hari Rabu': {
      'Kelas 7': [
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'PJOK',
          'guru': 'Darmin Umar, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'TIKOM',
          'guru': 'Dandi Karim, S.Pd',
        },
        {
          'jam': '11.20 - 12.40 WIT',
          'mapel': 'BHS.INGGRIS',
          'guru': 'Yenny Mas\'ud, S.Pd',
        },
      ],
      'Kelas 8': [
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'IPA',
          'guru': 'Fahria Kasim, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'IPS',
          'guru': 'Sarina Abubakar, S.Pd',
        },
        {
          'jam': '11.20 - 12.40 WIT',
          'mapel': 'PRAKARYA',
          'guru': 'Maryani Albugis, S.Pd',
        },
      ],
      'Kelas 9': [
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'BHS.INDONESIA',
          'guru': 'Raisanti Baradi, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'BHS.INGGRIS',
          'guru': 'Yenny Mas\'ud, S.Pd',
        },
        {
          'jam': '11.20 - 12.40 WIT',
          'mapel': 'IPS',
          'guru': 'Uliyanti Robo, S.Pd',
        },
      ],
    },
    'Hari Kamis': {
      'Kelas 7': [
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'MATEMATIKA',
          'guru': 'Marlia Mahmud, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'IPA',
          'guru': 'Fahria Kasim, S.Pd',
        },
        {
          'jam': '11.20 - 13.00 WIT',
          'mapel': 'IPS',
          'guru': 'Sarina Abubakar, S.Pd',
        },
      ],
      'Kelas 8': [
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'PJOK',
          'guru': 'Darmin Umar, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 12.00 WIT',
          'mapel': 'BHS.INDONESIA',
          'guru': 'Raisanti Baradi, S.Pd',
        },
        {
          'jam': '12.00 - 13.00 WIT',
          'mapel': 'BHS.INGGRIS',
          'guru': 'Yenny Mas\'ud, S.Pd',
        },
      ],
      'Kelas 9': [
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'BHS.INDONESIA',
          'guru': 'Raisanti Baradi, S.Pd',
        },
        {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.00 - 12.00 WIT',
          'mapel': 'PPKN',
          'guru': 'Nurdiana Mahmud, SH',
        },
        {
          'jam': '12.00 - 13.00 WIT',
          'mapel': 'BHS.INDONESIA',
          'guru': 'Raisanti Baradi, S.Pd',
        },
      ],
    },
    'Hari Jumat': {
      'Kelas 7': [
        {'jam': '07.00 - 07.30 WIT', 'mapel': 'SHOLAT DHUHA', 'guru': '-'},
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'PEND.AGAMA ISLAM',
          'guru': 'Nurdiana Mahmud, SH',
        },
        {'jam': '09.30 - 10.10 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.10 - 11.00 WIT',
          'mapel': 'PRAKARYA',
          'guru': 'Maryani Albugis, S.Pd',
        },
      ],
      'Kelas 8': [
        {'jam': '07.00 - 07.30 WIT', 'mapel': 'SHOLAT DHUHA', 'guru': '-'},
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'BHS.INDONESIA',
          'guru': 'Raisanti Baradi, S.Pd',
        },
        {'jam': '09.30 - 10.10 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.10 - 11.00 WIT',
          'mapel': 'TIKOM',
          'guru': 'Dandi Karim, S.Pd',
        },
      ],
      'Kelas 9': [
        {'jam': '07.00 - 07.30 WIT', 'mapel': 'SHOLAT DHUHA', 'guru': '-'},
        {
          'jam': '07.30 - 09.30 WIT',
          'mapel': 'MATEMATIKA',
          'guru': 'Marlia Mahmud, S.Pd',
        },
        {'jam': '09.30 - 10.10 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '10.10 - 11.00 WIT',
          'mapel': 'PJOK',
          'guru': 'Darmin Umar, S.Pd',
        },
      ],
    },
    'Hari Sabtu': {
      'Kelas 7': [
        {
          'jam': '07.30 - 08.50 WIT',
          'mapel': 'SENAM INDONESIA HEBAT',
          'guru': 'Senam / Guru Wali',
        },
        {'jam': '08.50 - 09.30 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '09.30 - 11.20 WIT',
          'mapel': 'GURU WALI',
          'guru': 'Senam / Guru Wali',
        },
      ],
      'Kelas 8': [
        {
          'jam': '07.30 - 08.50 WIT',
          'mapel': 'SENAM INDONESIA HEBAT',
          'guru': 'Senam / Guru Wali',
        },
        {'jam': '08.50 - 09.30 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '09.30 - 11.20 WIT',
          'mapel': 'GURU WALI',
          'guru': 'Senam / Guru Wali',
        },
      ],
      'Kelas 9': [
        {
          'jam': '07.30 - 08.50 WIT',
          'mapel': 'SENAM INDONESIA HEBAT',
          'guru': 'Senam / Guru Wali',
        },
        {'jam': '08.50 - 09.30 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
        {
          'jam': '09.30 - 10.00 WIT',
          'mapel': 'IPS',
          'guru': 'Uliyanti Robo, S.Pd',
        },
        {
          'jam': '10.00 - 11.20 WIT',
          'mapel': 'GURU WALI',
          'guru': 'Senam / Guru Wali',
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    // 1. PEMBERSIH & PENYESUAI NAMA HARI
    // Jika dikirim 'Senin' -> otomatis jadi 'Hari Senin'
    String keyHari = namaHari.trim();
    if (!keyHari.startsWith('Hari ')) {
      keyHari = 'Hari $keyHari';
    }

    // 2. PEMBERSIH & PENYESUAI NAMA KELAS
    // Mendukung input: '7', 'Kelas 7', 'Kelas VII', 'VII', dll.
    String keyKelas = 'Kelas 7';
    String lowerKelas = namaKelas.toLowerCase();

    if (lowerKelas.contains('7') || lowerKelas.contains('vii')) {
      keyKelas = 'Kelas 7';
    } else if (lowerKelas.contains('8') || lowerKelas.contains('viii')) {
      keyKelas = 'Kelas 8';
    } else if (lowerKelas.contains('9') || lowerKelas.contains('ix')) {
      keyKelas = 'Kelas 9';
    }

    // Ambil data jadwal dari map
    final listJadwal = masterJadwal[keyHari]?[keyKelas] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          '$keyKelas - $keyHari',
          style: const TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E3A8A)),
      ),
      body: listJadwal.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Jadwal tidak ditemukan untuk:\n$keyHari - $keyKelas',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listJadwal.length,
              itemBuilder: (context, index) {
                final item = listJadwal[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6), // Warna Biru UI
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Lingkaran Putih Khas Tampilan UI
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Teks Informasi Mata Pelajaran, Guru, dan Jam
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['mapel'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            if (item['guru'] != '-') ...[
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_outline,
                                    size: 16,
                                    color: Colors.amberAccent,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      'Guru: ${item['guru']}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              'Jam: ${item['jam']}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
