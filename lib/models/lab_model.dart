class LabModel {
  final String id;
  final String namaLab;
  final String jamMasuk;
  final String jamKeluar;
  final String materi;

  LabModel({
    required this.id,
    required this.namaLab,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.materi,
  });

  factory LabModel.fromJson(Map<String, dynamic> json) {
    return LabModel(
      id: json['id'] ?? '',
      namaLab: json['namaLab'] ?? '',
      jamMasuk: json['jamMasuk'] ?? '',
      jamKeluar: json['jamKeluar'] ?? '',
      materi: json['materi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'namaLab': namaLab,
    'jamMasuk': jamMasuk,
    'jamKeluar': jamKeluar,
    'materi': materi,
  };
}