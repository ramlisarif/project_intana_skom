import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormPerubahanJadwalPage extends StatefulWidget {
  const FormPerubahanJadwalPage({super.key});

  @override
  State<FormPerubahanJadwalPage> createState() =>
      _FormPerubahanJadwalPageState();
}

class _FormPerubahanJadwalPageState extends State<FormPerubahanJadwalPage> {
  String _pilihanAksi = 'Mengubah'; // Default opsi: Mengubah atau Pengganti
  final TextEditingController _alasanController = TextEditingController();

  void _kirimKeWA(String pesan) async {
    final encodedPesan = Uri.encodeComponent(pesan);
    final url = Uri.parse("https://wa.me/?text=$encodedPesan");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuka WhatsApp')),
      );
    }
  }

  void _submit() {
    final alasan = _alasanController.text.trim();
    if (alasan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi alasan terlebih dahulu!')),
      );
      return;
    }

    if (_pilihanAksi == 'Mengubah') {
      // 🟢 RUTE 1: MENGUBAH -> KETIK ALASAN -> BUKA WA
      final pesanWA = "Halo Admin, saya ingin MENGUBAH JADWAL.\n\nAlasan: $alasan";
      _kirimKeWA(pesanWA);
    } else {
      // 🔵 RUTE 2: PENGGANTI -> KETIK ALASAN -> SELESAI
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Pengajuan Selesai'),
          content: const Text(
            'Permintaan pengajuan Guru Pengganti telah berhasil dikirim ke sistem.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup Dialog
                Navigator.pop(context); // Kembali ke menu Utama
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      appBar: AppBar(
        title: const Text(
          'Perubahan Jadwal',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Jenis Pengajuan:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 10),

            // TOGGLE / CHOICE CHIP (MENGUBAH / PENGGANTI)
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Mengubah Jadwal')),
                    selected: _pilihanAksi == 'Mengubah',
                    selectedColor: const Color(0xFF1D4ED8),
                    labelStyle: TextStyle(
                      color: _pilihanAksi == 'Mengubah'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (val) {
                      setState(() => _pilihanAksi = 'Mengubah');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Guru Pengganti')),
                    selected: _pilihanAksi == 'Pengganti',
                    selectedColor: const Color(0xFF1D4ED8),
                    labelStyle: TextStyle(
                      color: _pilihanAksi == 'Pengganti'
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (val) {
                      setState(() => _pilihanAksi = 'Pengganti');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // FORM ALASAN
            Text(
              _pilihanAksi == 'Mengubah'
                  ? 'Alasan Mengubah:'
                  : 'Alasan Membutuhkan Pengganti:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _alasanController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tuliskan alasan lengkap di sini...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2DCD0)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // TOMBOL PROSES
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D4ED8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submit,
                icon: Icon(
                  _pilihanAksi == 'Mengubah'
                      ? Icons.chat_rounded
                      : Icons.check_circle_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  _pilihanAksi == 'Mengubah'
                      ? 'Kirim via WhatsApp'
                      : 'Selesaikan Pengajuan',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}