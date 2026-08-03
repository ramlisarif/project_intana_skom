import 'package:flutter/material.dart';

class DetailEventPage extends StatelessWidget {
  final String bulan;
  final List<Map<String, String>> listEvent;

  const DetailEventPage({
    super.key,
    required this.bulan,
    required this.listEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      appBar: AppBar(
        title: Text(
          'Event - $bulan',
          style: const TextStyle(
            color: Color(0xFF1D4ED8),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF1D4ED8)),
      ),
      body: listEvent.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada event di bulan ini.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listEvent.length,
              itemBuilder: (context, index) {
                final item = listEvent[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. NAMA EVENT
                      Text(
                        item['nama_event'] ?? 'tidak ada',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 10),

                      // 2. TANGGAL & HARI
                      Row(
                        children: [
                          const Icon(
                            Icons.event_note_rounded,
                            size: 18,
                            color: Color(0xFF1D4ED8),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${item['hari']}, ${item['tgl']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // 3. JAM
                    ],
                  ),
                );
              },
            ),
    );
  }
}
