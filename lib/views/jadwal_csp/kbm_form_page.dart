import 'package:flutter/material.dart';
import '../../models/schedule_model.dart';

class KbmFormPage extends StatefulWidget {
  final Function(ClassRequest) onSave;

  const KbmFormPage({super.key, required this.onSave}) : _onSave = onSave;

  final Function(ClassRequest) _onSave;

  @override
  State<KbmFormPage> createState() => _KbmFormPageState();
}

class _KbmFormPageState extends State<KbmFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _kelasController = TextEditingController();
  final _mapelController = TextEditingController();
  final _guruController = TextEditingController();
  bool _butuhLab = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newRequest = ClassRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        namaKelas: _kelasController.text.trim(),
        mataPelajaran: _mapelController.text.trim(),
        guru: _guruController.text.trim(),
        butuhLab: _butuhLab,
      );

      widget._onSave(newRequest);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mata Pelajaran (KBM)'),
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _kelasController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kelas (misal: 10 IPA 1)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mapelController,
                decoration: const InputDecoration(
                  labelText: 'Mata Pelajaran',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _guruController,
                decoration: const InputDecoration(
                  labelText: 'Nama Guru',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Membutuhkan Ruang Lab?'),
                subtitle: const Text('Aktifkan jika mapel ini butuh Lab Komputer'),
                value: _butuhLab,
                onChanged: (val) => setState(() => _butuhLab = val),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D4ED8),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Simpan Ke Daftar KBM'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}