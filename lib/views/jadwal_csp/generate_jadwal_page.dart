import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl untuk format tanggal
import '../../models/schedule_model.dart';
import '../../services/csp_scheduler_service.dart';

class GenerateJadwalPage extends StatefulWidget {
  const GenerateJadwalPage({super.key});

  @override
  State<GenerateJadwalPage> createState() => _GenerateJadwalPageState();
}

class _GenerateJadwalPageState extends State<GenerateJadwalPage> {
  final List<ClassRequest> _requests = [];
  List<ScheduledSlot>? _hasilJadwal;
  bool _isProcessing = false;

  final _formKey = GlobalKey<FormState>();
  final _mapelController = TextEditingController();

  final List<String> _listKelas = const ['Kelas VII', 'Kelas VIII', 'Kelas IX'];
  String? _selectedKelas;

  final List<String> _listGuru = const [
    'Bu Raisanti Baradi,S.Pd',
    'Bu Marlia Mahmud,S.Pd',
    'Bu Fahria Kasim,S.Pd',
    'Bu Uliyanti Robo,S.Pd',
    'Bu Nurdiana Mahmud,SH',
    'Pak Yenny Mas’ud,S.Pd',
    'Dandi Karim,S.Pd',
  ];
  String? _selectedGuru;

  bool _butuhLab = false;

  @override
  void dispose() {
    _mapelController.dispose();
    super.dispose();
  }

  // Helper untuk mengonversi Jam Ke menjadi Rentang Waktu
  String _formatWaktu(int jamKe) {
    switch (jamKe) {
      case 1:
        return '07.30 – 08.15';
      case 2:
        return '08.15 – 09.00';
      case 3:
        return '09.00 – 09.45';
      case 4:
        return '10.00 – 10.45';
      case 5:
        return '10.45 – 11.30';
      case 6:
        return '11.30 – 12.15';
      default:
        return 'Jam Ke-$jamKe';
    }
  }

  // Helper untuk mendapatkan Tanggal Spesifik berdasarkan Nama Hari
  String _getTanggalLengkap(String namaHari) {
    DateTime now = DateTime.now();

    // Pemetaan nama hari ke offset hari dari Senin
    Map<String, int> mapHari = {
      'Senin': DateTime.monday,
      'Selasa': DateTime.tuesday,
      'Rabu': DateTime.wednesday,
      'Kamis': DateTime.thursday,
      'Jumat': DateTime.friday,
      'Sabtu': DateTime.saturday,
    };

    int targetDay = mapHari[namaHari] ?? DateTime.monday;
    int currentDay = now.weekday;

    // Hitung selisih hari menuju hari yang dimaksud di minggu berjalan
    DateTime targetDate = now.add(Duration(days: targetDay - currentDay));

    // Format tampilan tanggal (Contoh: 14 September 2026)
    return DateFormat('d MMMM yyyy', 'id_ID').format(targetDate);
  }

  void _tambahRequest() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _requests.add(
          ClassRequest(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            namaKelas: _selectedKelas!,
            mataPelajaran: _mapelController.text.trim(),
            guru: _selectedGuru!,
            butuhLab: _butuhLab,
          ),
        );

        _formKey.currentState!.reset();
        _mapelController.clear();
        _selectedKelas = null;
        _selectedGuru = null;
        _butuhLab = false;
        _hasilJadwal = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('KBM berhasil ditambahkan ke daftar CSP!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _prosesCSP() async {
    if (_requests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tambahkan minimal 1 KBM terlebih dahulu!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    final result = CSPSchedulerService.generateSchedule(_requests);

    setState(() {
      _hasilJadwal = result;
      _isProcessing = false;
    });

    if (result == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal! Bentrok jadwal atau sesi jam/lab tidak mencukupi.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _hapusRequest(int index) {
    setState(() {
      _requests.removeAt(index);
      _hasilJadwal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generator Jadwal CSP'),
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 24.0 : 16.0,
                vertical: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Input KBM
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isWideScreen ? 24.0 : 16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.tune, color: Color(0xFF1D4ED8)),
                                SizedBox(width: 8),
                                Text(
                                  'Input Parameter Jadwal (CSP)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            if (isWideScreen)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buildKelasDropdown()),
                                  const SizedBox(width: 16),
                                  Expanded(child: _buildGuruDropdown()),
                                ],
                              )
                            else ...[
                              _buildKelasDropdown(),
                              const SizedBox(height: 12),
                              _buildGuruDropdown(),
                            ],
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _mapelController,
                              decoration: const InputDecoration(
                                labelText: 'Mata Pelajaran',
                                prefixIcon: Icon(Icons.book_outlined),
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              validator: (val) =>
                                  (val == null || val.trim().isEmpty)
                                  ? 'Isi mata pelajaran'
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Menggunakan Ruang Lab?'),
                              subtitle: const Text(
                                'Aktifkan jika butuh Lab Komputer',
                              ),
                              value: _butuhLab,
                              activeColor: const Color(0xFF1D4ED8),
                              onChanged: (val) =>
                                  setState(() => _butuhLab = val),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton.icon(
                              onPressed: _tambahRequest,
                              icon: const Icon(Icons.add_circle_outline),
                              label: const Text('Tambahkan ke Daftar KBM'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                                foregroundColor: const Color(0xFF1D4ED8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Daftar KBM Input
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daftar KBM Input (${_requests.length})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_requests.isNotEmpty)
                        TextButton(
                          onPressed: () => setState(() {
                            _requests.clear();
                            _hasilJadwal = null;
                          }),
                          child: const Text(
                            'Hapus Semua',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (_requests.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'Belum ada data KBM. Pilih Kelas & Guru di atas untuk menambahkan.',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _requests.length,
                      itemBuilder: (context, index) {
                        final item = _requests[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              backgroundColor: item.butuhLab
                                  ? Colors.orange
                                  : const Color(0xFF1D4ED8),
                              child: Icon(
                                item.butuhLab ? Icons.science : Icons.school,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            title: Text(
                              '${item.namaKelas} - ${item.mataPelajaran}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Guru: ${item.guru} ${item.butuhLab ? "(Masuk Lab)" : ""}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () => _hapusRequest(index),
                            ),
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 20),

                  // Tombol Generate
                  ElevatedButton.icon(
                    onPressed: _isProcessing ? null : _prosesCSP,
                    icon: _isProcessing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.auto_awesome),
                    label: Text(
                      _isProcessing
                          ? 'Memproses Algoritma CSP...'
                          : 'GENERATE JADWAL OTOMATIS (CSP)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Hasil Jadwal dengan Hari, Tanggal, Bulan, Tahun
                  if (_hasilJadwal != null) ...[
                    const Text(
                      'Hasil Susunan Jadwal Bebas Bentrok:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _hasilJadwal!.length,
                      itemBuilder: (context, index) {
                        final sesi = _hasilJadwal![index];
                        final tanggalStr = _getTanggalLengkap(sesi.hari);

                        return Card(
                          color: const Color(0xFFF0FDF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Colors.green,
                              width: 0.8,
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Text(
                                '${sesi.jamKe}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              '${sesi.request.namaKelas} - ${sesi.request.mataPelajaran}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Hari/Tgl: ${sesi.hari}, $tanggalStr\n'
                              'Waktu: ${_formatWaktu(sesi.jamKe)}\n'
                              'Guru: ${sesi.request.guru} | Ruang: ${sesi.ruangan}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKelasDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedKelas,
      decoration: const InputDecoration(
        labelText: 'Pilih Kelas',
        prefixIcon: Icon(Icons.class_outlined),
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: _listKelas.map((kelas) {
        return DropdownMenuItem(value: kelas, child: Text(kelas));
      }).toList(),
      onChanged: (val) => setState(() => _selectedKelas = val),
      validator: (val) => val == null ? 'Pilih kelas terlebih dahulu' : null,
    );
  }

  Widget _buildGuruDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGuru,
      decoration: const InputDecoration(
        labelText: 'Pilih Guru',
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: _listGuru.map((guru) {
        return DropdownMenuItem(value: guru, child: Text(guru));
      }).toList(),
      onChanged: (val) => setState(() => _selectedGuru = val),
      validator: (val) => val == null ? 'Pilih guru terlebih dahulu' : null,
    );
  }
}
