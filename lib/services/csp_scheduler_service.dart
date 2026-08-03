import '../models/schedule_model.dart';

class CSPSchedulerService {
  // Domain Opsi (Hari & Jam Mengajar)
  static final List<String> _hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  static final List<int> _jamList = [1, 2, 3, 4, 5];

  /// Fungsi Utama Generator Jadwal CSP
  static List<ScheduledSlot>? generateSchedule(List<ClassRequest> requests) {
    List<ScheduledSlot> finalAssignment = [];

    // Jalankan algoritma Backtracking mulai dari KBM indeks ke-0
    bool success = _backtrack(requests, 0, finalAssignment);

    if (success) {
      return finalAssignment; // Solusi ditemukan!
    } else {
      return null; // Tidak ditemukan solusi yang memenuhi constraints
    }
  }

  /// Algoritma Backtracking Search
  static bool _backtrack(
    List<ClassRequest> requests,
    int index,
    List<ScheduledSlot> currentAssignment,
  ) {
    // 6. ULANGI HINGGA SOLUSI DITEMUKAN (Base case: semua KBM sudah dapat jadwal)
    if (index == requests.length) {
      return true;
    }

    final currentRequest = requests[index];

    // Iterasi Domain (Eksplorasi Opsi Hari & Jam)
    for (String hari in _hariList) {
      for (int jam in _jamList) {
        String ruangan = currentRequest.butuhLab
            ? 'Lab Komputer'
            : 'Ruang KBM ${currentRequest.namaKelas}';

        // 1. PILIH SATU KEMUNGKINAN
        final trialSlot = ScheduledSlot(
          request: currentRequest,
          hari: hari,
          jamKe: jam,
          ruangan: ruangan,
        );

        // 3. PERIKSA APAKAH MASIH VALID (Cek Constraints)
        if (_isValid(trialSlot, currentAssignment)) {
          
          // 2. TAMBAHKAN KE SOLUSI SEMENTARA
          currentAssignment.add(trialSlot);

          // 4. JIKA VALID, LANJUTKAN KE LANGKAH BERIKUTNYA (Rekursi)
          if (_backtrack(requests, index + 1, currentAssignment)) {
            return true;
          }

          // 5. JIKA TIDAK VALID / BENTROK DI MASA DEPAN, BATALKAN PILIHAN (BACKTRACK)
          currentAssignment.removeLast();
        }

        // 5b. COBA KEMUNGKINAN LAINNYA (Perulangan berlanjut ke jam/hari berikutnya)
      }
    }

    // 6b. SEMUA KEMUNGKINAN HABIS DICOBA (Gagal menemukan slot yang cocok)
    return false;
  }

  /// Fungsi Pengecekan Constraint (Hard Rules)
  static bool _isValid(ScheduledSlot slot, List<ScheduledSlot> currentAssignment) {
    for (var assigned in currentAssignment) {
      // Hanya cek jika Hari dan Jam Ke- nya SAMA
      if (assigned.hari == slot.hari && assigned.jamKe == slot.jamKe) {
        
        // Constraint 1: Guru tidak boleh mengajar 2 kelas sekaligus
        if (assigned.request.guru == slot.request.guru) {
          return false;
        }

        // Constraint 2: Kelas tidak boleh dapat 2 mapel sekaligus
        if (assigned.request.namaKelas == slot.request.namaKelas) {
          return false;
        }

        // Constraint 3: Lab Komputer tidak boleh dipakai 2 kelas sekaligus
        if (slot.request.butuhLab && assigned.request.butuhLab) {
          return false;
        }
      }
    }
    return true; // Jika tidak ada aturan yang dilanggar
  }
}