import 'package:flutter/material.dart';
import '../../models/schedule_model.dart';
import '../jadwal_csp/generate_jadwal_page.dart';
import '../jadwal_csp/kbm_form_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Tempat menampung data KBM yang diinputkan user
  final List<ClassRequest> _daftarKbm = [
    ClassRequest(id: '1', namaKelas: '10 IPA 1', mataPelajaran: 'Pemrograman Web', guru: 'Pak Budi', butuhLab: true),
    ClassRequest(id: '2', namaKelas: '10 IPA 1', mataPelajaran: 'Matematika', guru: 'Bu Siti'),
    ClassRequest(id: '3', namaKelas: '10 IPA 2', mataPelajaran: 'Jaringan Komputer', guru: 'Pak Budi', butuhLab: true),
  ];

  void _tambahKbm(ClassRequest request) {
    setState(() {
      _daftarKbm.add(request);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Berhasil menambah KBM baru!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Jadwal Sekolah'),
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOMBOL UTAMA NAVIGASI
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KbmFormPage(onSave: _tambahKbm),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah KBM'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GenerateJadwalPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Generator CSP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Daftar KBM Siap Dijadwalkan (${_daftarKbm.length})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _daftarKbm.isEmpty
                  ? const Center(child: Text('Belum ada data KBM.'))
                  : ListView.builder(
                      itemCount: _daftarKbm.length,
                      itemBuilder: (context, index) {
                        final item = _daftarKbm[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: item.butuhLab ? Colors.orange : Colors.blue,
                              child: Icon(
                                item.butuhLab ? Icons.computer : Icons.book,
                                color: Colors.white,
                              ),
                            ),
                            title: Text('${item.namaKelas} - ${item.mataPelajaran}'),
                            subtitle: Text('Guru: ${item.guru} ${item.butuhLab ? "(Butuh Lab)" : ""}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}