class JadwalKbmModel {
  final String id;
  final String kelas;
  final String jam;
  final String mapel;
  final String hari;

  JadwalKbmModel({
    required this.id,
    required this.kelas,
    required this.jam,
    required this.mapel,
    required this.hari,
  });

  factory JadwalKbmModel.fromJson(Map<String, dynamic> json) {
    return JadwalKbmModel(
      id: json['id'] ?? '',
      kelas: json['kelas'] ?? '',
      jam: json['jam'] ?? '',
      mapel: json['mapel'] ?? '',
      hari: json['hari'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'kelas': kelas,
    'jam': jam,
    'mapel': mapel,
    'hari': hari,
  };
}