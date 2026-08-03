import 'package:flutter/material.dart';
import '../../models/schedule_model.dart';
import '../../services/csp_scheduler_service.dart';

class GenerateJadwalPage extends StatefulWidget {
  const GenerateJadwalPage({super.key});

  @override
  State<GenerateJadwalPage> createState() => _GenerateJadwalPageState();
}

class _GenerateJadwalPageState extends State<GenerateJadwalPage> {
  // List untuk menampung inputan permintaan KBM dari User
  final List<ClassRequest> _requests = [];
  List<ScheduledSlot>? _hasilJadwal;
  bool _isProcessing = false;

  // Controller & State untuk Form Input
  final _formKey = GlobalKey<FormState>();
  final _mapelController = TextEditingController();

  // Pilihan Dropdown Kelas (Dibuat Unik agar tidak crash)
  final List<String> _listKelas = ['Kelas VII', 'Kelas VIII', 'Kelas IX'];
  String? _selectedKelas;

  // Pilihan Dropdown Guru (Dibuat Unik agar tidak crash)
  final List<String> _listGuru = [
    'Bu Raisanti Baradi,S.Pd',
    'Bu Marlia Mahmud,S.Pd',
    'Bu Fahria Kasim,S.Pd',
    'Bu Uliyanti Robo,S.Pd',
    'Bu Nurdiana Mahmud,SH',
    'Pak Yenny Mas’ud,S.Pd',
    'Dandi Karim,S.Pd',
  ];
  String? _selectedGuru;

  // Checkbox Masuk Lab
  bool _butuhLab = false;

  @override
  void dispose() {
    _mapelController.dispose();
    super.dispose();
  }

  // Fungsi Tambah Data KBM ke Daftar
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
        // Reset Form setelah ditambah
        _mapelController.clear();
        _butuhLab = false;
        _hasilJadwal = null; // Reset hasil jadwal sebelumnya
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('KBM berhasil ditambahkan ke daftar CSP!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Fungsi Jalankan Algoritma CSP
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

    // Delay singkat untuk animasi komputasi
    await Future.delayed(const Duration(milliseconds: 400));

    // Dipanggil langsung via kelas CSPSchedulerService (Static Method)
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
    final isWideScreen = screenWidth > 600; // Flag untuk layar Tablet/Web

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
                  // ================= FORM INPUT KBM =================
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
                            Row(
                              children: const [
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

                            // LAYOUT ADAPTIF
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

                            // INPUT MATA PELAJARAN
                            TextFormField(
                              controller: _mapelController,
                              decoration: const InputDecoration(
                                labelText: 'Mata Pelajaran',
                                prefixIcon: Icon(Icons.book_outlined),
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              validator: (val) => (val == null || val.isEmpty)
                                  ? 'Isi mata pelajaran'
                                  : null,
                            ),
                            const SizedBox(height: 8),

                            // CHECKBOX MASUK LAB
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

                            // TOMBOL TAMBAH KE LIST
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

                  // ================= DAFTAR KBM INPUT =================
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

                  // ================= TOMBOL GENERATE CSP =================
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

                  // ================= HASIL JADWAL CSP =================
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
                              'Hari: ${sesi.hari} (Sesi ke-${sesi.jamKe})\nGuru: ${sesi.request.guru}\nRuang: ${sesi.ruangan}',
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

  // Helper Widget untuk Dropdown Kelas
  Widget _buildKelasDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedKelas,
      decoration: const InputDecoration(
        labelText: 'Pilih Kelas',
        prefixIcon: Icon(Icons.class_outlined),
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: _listKelas.toSet().map((kelas) {
        return DropdownMenuItem(value: kelas, child: Text(kelas));
      }).toList(),
      onChanged: (val) => setState(() => _selectedKelas = val),
      validator: (val) => val == null ? 'Pilih kelas terlebih dahulu' : null,
    );
  }

  // Helper Widget untuk Dropdown Guru
  Widget _buildGuruDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGuru,
      decoration: const InputDecoration(
        labelText: 'Pilih Guru',
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: _listGuru.toSet().map((guru) {
        return DropdownMenuItem(value: guru, child: Text(guru));
      }).toList(),
      onChanged: (val) => setState(() => _selectedGuru = val),
      validator: (val) => val == null ? 'Pilih guru terlebih dahulu' : null,
    );
  }
}
