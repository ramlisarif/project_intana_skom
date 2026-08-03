class GuruModel {
  final String nik;
  final String nama;
  final String password; // 6 Karakter

  GuruModel({
    required this.nik,
    required this.nama,
    required this.password,
  });

  factory GuruModel.fromJson(Map<String, dynamic> json) {
    return GuruModel(
      nik: json['nik'] ?? '',
      nama: json['nama'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'nik': nik,
    'nama': nama,
    'password': password,
  };
}