import 'package:flutter/material.dart';

class RekapanEventPage extends StatelessWidget {
  const RekapanEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy rekap event
    final List<Map<String, String>> dataRekap = [
      {'tahun': '2026', 'tgl': '12 Jan 2026', 'nama': 'Rapat Kerja Awal Tahun'},
      {'tahun': '2026', 'tgl': '05 Feb 2026', 'nama': 'Workshop Flutter Dev'},
      {'tahun': '2026', 'tgl': '09 Mar 2026', 'nama': 'Ujian Tengah Semester'},
      {'tahun': '2025', 'tgl': '15 Des 2025', 'nama': 'Pentas Seni Akhir Tahun'},
      {'tahun': '2025', 'tgl': '17 Agu 2025', 'nama': 'Lomba Kemerdekaan RI'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      appBar: AppBar(
        title: const Text(
          'Tabel Rekapan Event',
          style: TextStyle(
            color: Color(0xFF1D4ED8),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF1D4ED8)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
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
          child: DataTable(
            columnSpacing: 16,
            columns: const [
              DataColumn(
                label: Text(
                  'Tahun',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Tanggal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Nama Event',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: dataRekap.map((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item['tahun']!)),
                  DataCell(Text(item['tgl']!)),
                  DataCell(
                    Text(
                      item['nama']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}