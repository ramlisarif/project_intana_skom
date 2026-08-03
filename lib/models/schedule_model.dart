// Model untuk Data Masukan (Variabel yang akan dijadwalkan)
class ClassRequest {
  final String id;
  final String namaKelas;
  final String mataPelajaran;
  final String guru;
  final bool butuhLab; // Apakah mapel ini butuh ruangan Lab?

  ClassRequest({
    required this.id,
    required this.namaKelas,
    required this.mataPelajaran,
    required this.guru,
    this.butuhLab = false,
  });
}

// Model untuk Hasil Penjadwalan yang Sudah Berhasil Disusun
class ScheduledSlot {
  final ClassRequest request;
  final String hari;
  final int jamKe; // Slot Jam ke-1, 2, 3, dst.
  final String ruangan; // Contoh: "Ruang Kelas 10A" atau "Lab Komputer 1"

  ScheduledSlot({
    required this.request,
    required this.hari,
    required this.jamKe,
    required this.ruangan,
  });
}