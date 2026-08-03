import '../models/guru_model.dart';
import '../models/jadwal_kbm_model.dart';

class ApiService {
  // Simulasi Login NIK & Password
  static Future<GuruModel?> login(String nik, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (password.length == 6 && nik.isNotEmpty) {
      return GuruModel(
        nik: nik,
        nama: "Intan Pratama, S.Kom",
        password: password,
      );
    }
    return null;
  }

  // Simulasi Input & Simpan Nilai Otomatis
  static Future<bool> simpanNilaiOtomatis(
    List<JadwalKbmModel> listAbsensi,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    // Logika pengirijaman data ke server API
    return true;
  }
}
