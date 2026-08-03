import 'package:flutter/material.dart';
import 'jadwal_per_kelas_page.dart';

class PilihKelasPage extends StatelessWidget {
  final String hari;
  final Map<String, List<Map<String, String>>> daftarKelasJadwal;

  const PilihKelasPage({
    super.key,
    required this.hari,
    required this.daftarKelasJadwal,
  });

  @override
  Widget build(BuildContext context) {
    final listKelas = daftarKelasJadwal.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Hari $hari - Pilih Kelas',
          style: const TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E3A8A)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listKelas.length,
        itemBuilder: (context, index) {
          final namaKelas = listKelas[index];
          final listJadwal = daftarKelasJadwal[namaKelas] ?? [];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E3A8A),
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
                  color: const Color(0xFF2563EB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.class_rounded,
                  color: Color(0xFF2563EB),
                ),
              ),
              title: Text(
                namaKelas,
                style: const TextStyle(
                  fontSize: 17,
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
                // NAVIGASI 2: Dari Kelas ke Detail Jadwal
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JadwalPerKelasPage(
                      namaHari: hari,
                      namaKelas: namaKelas,
                      // jadwalList: listJadwal,
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
