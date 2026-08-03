import 'package:flutter/material.dart';
import 'detail_event_page.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data event dikelompokkan per bulan sesuai dokumen kegiatan setahun
    final Map<String, List<Map<String, String>>> dataEventPerBulan = {
      'Januari 2026': [
        {
          'nama_event': 'Libur tahun pelajaran semester genap',
          'tgl': '1 - 3 Januari 2026',
          'hari': 'Kamis, Jumat, Sabtu',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
        {
          'nama_event': 'Masuk sekolah',
          'tgl': '4 Januari 2026',
          'hari': 'Minggu',
          'Ketrangan': 'Persiapan workshop selama 3 hari untuk memulai tahun pelajaran semester genap',
        },
        {
          'nama_event': 'Libur memperingati Isra Mikraj Nabi Muhammad SAW',
          'tgl': '16 Januari 2026',
          'hari': 'Jumat',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
        {
          'nama_event': 'Pelaksanaan kegiatan keagamaan di bulan suci Ramadhan & pesantren kilat',
          'tgl': '23 - 28 Januari 2026',
          'hari': 'Jumat - Rabu',
          'Ketrangan': 'Siswa dan guru melakukan pengajian bersama',
        },
      ],
      'Februari 2026': [
        {
          'nama_event': 'Libur Di bulan suci Ramadhan',
          'tgl': '16 - 21 Februari 2026',
          'hari': 'Senin - Sabtu',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
      ],
      'Maret 2026': [
        {
          'nama_event': 'Pelaksanaan kegiatan keagamaan di bulan suci Ramadhan & pesantren kilat',
          'tgl': '2 - 7 Maret 2026',
          'hari': 'Senin - Sabtu',
          'Ketrangan': 'Siswa dan guru melakukan pengajian bersama',
        },
        {
          'nama_event': 'Libur Di bulan suci Ramadhan',
          'tgl': '9 - 18 Maret 2026',
          'hari': 'Senin - Rabu',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
        {
          'nama_event': 'Libur Nasional – Hari besar & Bulan Ramadhan',
          'tgl': '19 - 28 Maret 2026',
          'hari': 'Kamis - Sabtu',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
      ],
      'April 2026': [
        {
          'nama_event': 'Libur Nasional (Wafatnya Isa Al-Masih)',
          'tgl': '3 April 2026',
          'hari': 'Jumat',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
        {
          'nama_event': 'Pelaksanaan tengah semester genap',
          'tgl': '13 - 18 April 2026',
          'hari': 'Senin - Sabtu',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
      ],
      'Mei 2026': [
        {
          'nama_event': 'Libur Nasional (Hari Buruh Internasional)',
          'tgl': '1 Mei 2026',
          'hari': 'Jumat',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
        {
          'nama_event': 'Tes Kemampuan Akademik (TKA) siswa kelas IX',
          'tgl': '3 - 6 Mei 2026',
          'hari': 'Minggu - Rabu',
          'Ketrangan': 'Khusus kelas IX dengan mapel BHS Indonesia dan Matematika',
        },
        {
          'nama_event': 'Libur Nasional (Kenaikan Isa Al-Masih)',
          'tgl': '14 Mei 2026',
          'hari': 'Kamis',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
        {
          'nama_event': 'Libur Hari Raya Idul Fitri',
          'tgl': '27 - 30 Mei 2026',
          'hari': 'Rabu - Sabtu',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
      ],
      'Juni 2026': [
        {
          'nama_event': 'Libur Nasional (Hari Lahir Pancasila)',
          'tgl': '1 Juni 2026',
          'hari': 'Senin',
          'Ketrangan': 'Seluruh siswa dan guru libur',
        },
        {
          'nama_event': 'Ujian Akhir Sekolah / Semester Genap',
          'tgl': '8 - 13 Juni 2026',
          'hari': 'Senin - Sabtu',
          'Ketrangan': 'Khusus kelas IX & Seluruh siswa dari kelas VII-IX',
        },
        {
          'nama_event': 'Ekstra Kurikuler (Ekskul)',
          'tgl': '15 - 19 Juni 2026',
          'hari': 'Senin - Jumat',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
        {
          'nama_event': 'Pembagian Buku Raport Pendidikan',
          'tgl': '20 Juni 2026',
          'hari': 'Sabtu',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
        {
          'nama_event': 'Libur Semester Genap',
          'tgl': '22 Juni - 11 Juli 2026',
          'hari': 'Senin - Sabtu',
          'Ketrangan': 'Khusus Siswa',
        },
      ],
      'Juli 2026': [
        {
          'nama_event': 'Jadwal penerimaan siswa baru',
          'tgl': '9 - 11 Juli 2026',
          'hari': 'Kamis - Sabtu',
          'Ketrangan': 'Khusus siswa baru & kepanitiaan penerima siswa baru (28 siswa terdaftar)',
        },
        {
          'nama_event': 'Pengenalan Lingkungan Sekolah (PLS) TP 2026-2027',
          'tgl': '13 - 17 Juli 2026',
          'hari': 'Senin - Jumat',
          'Ketrangan': 'Kepala sekolah dan seluruh guru',
        },
      ],
      'Agustus 2026': [
        {
          'nama_event': 'Memperingati HUT Kemerdekaan Indonesia',
          'tgl': '13 - 17 Agustus 2026',
          'hari': 'Kamis - Senin',
          'Ketrangan': 'Melakukan berbagai kegiatan untuk HUT Kemerdekaan (Seluruh warga sekolah)',
        },
      ],
      'Oktober 2026': [
        {
          'nama_event': 'Pelaksanaan Ujian Tengah Semester (PTS)',
          'tgl': '12 - 17 Oktober 2026',
          'hari': 'Senin - Sabtu',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
      ],
      'Desember 2026': [
        {
          'nama_event': 'Asesmen Sumatif Akhir Semester',
          'tgl': '7 - 12 Desember 2026',
          'hari': 'Senin - Sabtu',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
        {
          'nama_event': 'Kegiatan Ekstra Kurikuler',
          'tgl': '14 - 18 Desember 2026',
          'hari': 'Senin - Jumat',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
        {
          'nama_event': 'Penerimaan Buku Laporan Pendidikan',
          'tgl': '19 Desember 2026',
          'hari': 'Sabtu',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
        {
          'nama_event': 'Libur Semester Ganjil',
          'tgl': '21 - 31 Desember 2026',
          'hari': 'Senin - Kamis',
          'Ketrangan': 'Seluruh siswa dari kelas VII-IX',
        },
      ],
    };

    final daftarBulan = dataEventPerBulan.keys.toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Bagian Event',
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
        itemCount: daftarBulan.length,
        itemBuilder: (context, index) {
          final bulan = daftarBulan[index];
          final totalEvent = dataEventPerBulan[bulan]?.length ?? 0;

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
                vertical: 10,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF1D4ED8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                ),
              ),
              title: Text(
                bulan,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1E293B),
                ),
              ),
              subtitle: Text(
                '$totalEvent Event Tersedia',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFF1D4ED8),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailEventPage(
                      bulan: bulan,
                      listEvent: dataEventPerBulan[bulan] ?? [],
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