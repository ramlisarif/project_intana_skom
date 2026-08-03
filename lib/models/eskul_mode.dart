class EskulModel {
  final String id;
  final String namaEskul;
  final String pembimbing;
  final String jadwal;
  final String aktivitas;
  final String? infoPertandingan;

  EskulModel({
    required this.id,
    required this.namaEskul,
    required this.pembimbing,
    required this.jadwal,
    required this.aktivitas,
    this.infoPertandingan,
  });

  factory EskulModel.fromJson(Map<String, dynamic> json) {
    return EskulModel(
      id: json['id'] ?? '',
      namaEskul: json['namaEskul'] ?? '',
      pembimbing: json['pembimbing'] ?? '',
      jadwal: json['jadwal'] ?? '',
      aktivitas: json['aktivitas'] ?? '',
      infoPertandingan: json['infoPertandingan'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'namaEskul': namaEskul,
    'pembimbing': pembimbing,
    'jadwal': jadwal,
    'aktivitas': aktivitas,
    'infoPertandingan': infoPertandingan,
  };
}