import 'package:flutter/material.dart';

class DetailEskulPage extends StatelessWidget {
  final String hari;
  final List<Map<String, String>> listEskul;

  const DetailEskulPage({
    super.key,
    required this.hari,
    required this.listEskul,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      appBar: AppBar(
        title: Text(
          'Jadwal Eskul - Hari $hari',
          style: const TextStyle(
            color: Color(0xFF1D4ED8),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF1D4ED8)),
      ),
      body: listEskul.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada jadwal eskul untuk hari ini.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listEskul.length,
              itemBuilder: (context, index) {
                final item = listEskul[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                      // 1. NAMA ESKUL
                      Text(
                        item['nama_eskul'] ?? '-',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D4ED8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 10),

                      // 2. KELAS
                      Row(
                        children: [
                          const Icon(
                            Icons.groups_rounded,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Peserta: ${item['kelas'] ?? '-'}',
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
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_filled_rounded,
                            size: 18,
                            color: Color(0xFF1D4ED8),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Jam: ${item['jam'] ?? '-'}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}