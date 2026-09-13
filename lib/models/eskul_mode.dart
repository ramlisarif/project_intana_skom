class EskulModel {
  final String id;
  final String namaEskul;
  final String pembimbing;
  final String jadwal;
  final String aktivitas;
  final String? infoPertandingan;
  final DateTime generatedAt; // Perbaikan: DataTime -> DateTime

  EskulModel({
    required this.id,
    required this.namaEskul,
    required this.pembimbing,
    required this.jadwal,
    required this.aktivitas,
    this.infoPertandingan,
    required this.generatedAt,
  });

  factory EskulModel.fromJson(Map<String, dynamic> json) {
    return EskulModel(
      id: json['id'] ?? '',
      namaEskul: json['namaEskul'] ?? '',
      pembimbing: json['pembimbing'] ?? '',
      jadwal: json['jadwal'] ?? '',
      aktivitas: json['aktivitas'] ?? '',
      infoPertandingan: json['infoPertandingan'],
      // Perbaikan: Parse string ISO8601 dari JSON menjadi DateTime.
      // Jika data null/kosong, otomatis pakai waktu saat ini (DateTime.now()).
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'namaEskul': namaEskul,
    'pembimbing': pembimbing,
    'jadwal': jadwal,
    'aktivitas': aktivitas,
    'infoPertandingan': infoPertandingan,
    // Perbaikan: Ubah DateTime ke string format ISO agar bisa disimpan ke DB/JSON
    'generatedAt': generatedAt.toIso8601String(),
  };
}
