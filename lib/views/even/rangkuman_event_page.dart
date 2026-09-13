import 'package:flutter/material.dart';

class RangkumanEventPage extends StatelessWidget {
  // const RangkumanEventPage({super.key});
  final Map<String, List<Map<String, String>>> dataEventPerBulan;
  const RangkumanEventPage({super.key, required this.dataEventPerBulan});
  // Data Rekapitulasi Kegiatan Sekolah
  final List<Map<String, dynamic>> _monthlyEvents = const [
    {'bulan': 'Januari 2026', 'total': 4},
    {'bulan': 'Februari 2026', 'total': 1},
    {'bulan': 'Maret 2026', 'total': 3},
    {'bulan': 'April 2026', 'total': 2},
    {'bulan': 'Mei 2026', 'total': 4},
    {'bulan': 'Juni 2026', 'total': 5},
    {'bulan': 'Juli 2026', 'total': 2},
    {'bulan': 'Agustus 2026', 'total': 1},
    {'bulan': 'Oktober 2026', 'total': 1},
    {'bulan': 'Desember 2026', 'total': 4},
  ];

  int get _totalSemuaEvent =>
      _monthlyEvents.fold(0, (sum, item) => sum + (item['total'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),
      appBar: AppBar(
        title: const Text(
          'Rangkuman Kegiatan Sekolah',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stat Card Total Kegiatan
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0E7FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.event_available,
                        color: Color(0xFF1D4ED8),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Kegiatan 2026',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          '$_totalSemuaEvent Event',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D4ED8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Rincian Kegiatan Per Bulan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // List Rekap Per Bulan
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _monthlyEvents.length,
              itemBuilder: (context, index) {
                final item = _monthlyEvents[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF1D4ED8),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      item['bulan'],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E7FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${item['total']} Event',
                        style: const TextStyle(
                          color: Color(0xFF1D4ED8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
