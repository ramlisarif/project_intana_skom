import 'package:cloud_firestore/cloud_firestore.dart';

class JadwalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1. Mengambil data jadwal secara real-time dari Firestore
  Stream<List<Map<String, String>>> getJadwal(
    String namaHari,
    String namaKelas,
  ) {
    return _db
        .collection('jadwal')
        .doc(namaHari)
        .collection(namaKelas)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'id': doc
                  .id, // SANGAT PENTING: Dibutuhkan untuk proses Edit & Hapus
              'jam': data['jam']?.toString() ?? '',
              'mapel': data['mapel']?.toString() ?? '',
              'guru': data['guru']?.toString() ?? '-',
            };
          }).toList();
        });
  }

  // 2. Tambah Jadwal Baru
  Future<void> tambahJadwal({
    required String namaHari,
    required String namaKelas,
    required String mapel,
    required String guru,
    required String jam,
  }) async {
    await _db.collection('jadwal').doc(namaHari).collection(namaKelas).add({
      'mapel': mapel,
      'guru': guru,
      'jam': jam,
    });
  }

  // 3. Edit / Update Jadwal yang Sudah Ada
  Future<void> updateJadwal({
    required String namaHari,
    required String namaKelas,
    required String docId,
    required String mapel,
    required String guru,
    required String jam,
  }) async {
    await _db
        .collection('jadwal')
        .doc(namaHari)
        .collection(namaKelas)
        .doc(docId)
        .update({'mapel': mapel, 'guru': guru, 'jam': jam});
  }

  // 4. Hapus Jadwal
  Future<void> hapusJadwal({
    required String namaHari,
    required String namaKelas,
    required String docId,
  }) async {
    await _db
        .collection('jadwal')
        .doc(namaHari)
        .collection(namaKelas)
        .doc(docId)
        .delete();
  }

  // 5. Fungsi Seeder: Upload otomatis seluruh data master dari foto ke Firestore
  Future<void> uploadDataJadwalMaster() async {
    final Map<String, Map<String, List<Map<String, String>>>> masterJadwal = {
      'Hari Senin': {
        'Kelas 7': [
          {'jam': '07.00 - 07.30 WIT', 'mapel': 'UPACARA', 'guru': '-'},
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'BHS.INDONESIA',
            'guru': 'Raisanti Baradi, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'BHS.INGGRIS',
            'guru': 'Yenny Mas\'ud, S.Pd',
          },
          {
            'jam': '11.20 - 13.10 WIT',
            'mapel': 'PPKN',
            'guru': 'Uliyanti Robo, S.Pd',
          },
        ],
        'Kelas 8': [
          {'jam': '07.00 - 07.30 WIT', 'mapel': 'UPACARA', 'guru': '-'},
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'MATEMATIKA',
            'guru': 'Marlia Mahmud, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'IPA',
            'guru': 'Fahria Kasim, S.Pd',
          },
          {
            'jam': '11.20 - 13.10 WIT',
            'mapel': 'PEN.AGAMA ISLAM',
            'guru': 'Nurdiana Mahmud, SH',
          },
        ],
        'Kelas 9': [
          {'jam': '07.00 - 07.30 WIT', 'mapel': 'UPACARA', 'guru': '-'},
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'IPA',
            'guru': 'Fahria Kasim, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'TIKOM',
            'guru': 'Dandi Karim, S.Pd',
          },
          {
            'jam': '11.20 - 13.10 WIT',
            'mapel': 'MATEMATIKA',
            'guru': 'Marlia Mahmud, S.Pd',
          },
        ],
      },
      'Hari Selasa': {
        'Kelas 7': [
          {
            'jam': '07.30 - 08.50 WIT',
            'mapel': 'IPS',
            'guru': 'Sarina Abubakar, S.Pd',
          },
          {
            'jam': '08.50 - 10.00 WIT',
            'mapel': 'IPA',
            'guru': 'Fahria Kasim, S.Pd',
          },
          {'jam': '10.00 - 10.40 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.40 - 12.00 WIT',
            'mapel': 'MATEMATIKA',
            'guru': 'Marlia Mahmud, S.Pd',
          },
          {
            'jam': '12.00 - 13.30 WIT',
            'mapel': 'BHS.INDONESIA',
            'guru': 'Raisanti Baradi, S.Pd',
          },
        ],
        'Kelas 8': [
          {
            'jam': '07.30 - 08.10 WIT',
            'mapel': 'MATEMATIKA',
            'guru': 'Marlia Mahmud, S.Pd',
          },
          {
            'jam': '08.10 - 09.30 WIT',
            'mapel': 'BHS.INGGRIS',
            'guru': 'Yenny Mas\'ud, S.Pd',
          },
          {
            'jam': '09.30 - 10.00 WIT',
            'mapel': 'IPS',
            'guru': 'Sarina Abubakar, S.Pd',
          },
          {'jam': '10.00 - 10.40 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.40 - 11.20 WIT',
            'mapel': 'IPS',
            'guru': 'Sarina Abubakar, S.Pd',
          },
          {
            'jam': '11.20 - 13.00 WIT',
            'mapel': 'PPKN',
            'guru': 'Maryani Albugis, S.Pd',
          },
          {
            'jam': '13.00 - 13.30 WIT',
            'mapel': 'IPA',
            'guru': 'Fahria Kasim, S.Pd',
          },
        ],
        'Kelas 9': [
          {
            'jam': '07.30 - 08.50 WIT',
            'mapel': 'BHS.INGGRIS',
            'guru': 'Yenny Mas\'ud, S.Pd',
          },
          {
            'jam': '08.50 - 10.00 WIT',
            'mapel': 'PRAKARYA',
            'guru': 'Maryani Albugis, S.Pd',
          },
          {'jam': '10.00 - 10.40 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.40 - 12.00 WIT',
            'mapel': 'IPA',
            'guru': 'Fahria Kasim, S.Pd',
          },
          {
            'jam': '12.00 - 13.30 WIT',
            'mapel': 'PEN.AGAMA ISLAM',
            'guru': 'Dandi Karim, S.Pd',
          },
        ],
      },
      'Hari Rabu': {
        'Kelas 7': [
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'PJOK',
            'guru': 'Darmin Umar, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'TIKOM',
            'guru': 'Dandi Karim, S.Pd',
          },
          {
            'jam': '11.20 - 12.40 WIT',
            'mapel': 'BHS.INGGRIS',
            'guru': 'Yenny Mas\'ud, S.Pd',
          },
        ],
        'Kelas 8': [
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'IPA',
            'guru': 'Fahria Kasim, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'IPS',
            'guru': 'Sarina Abubakar, S.Pd',
          },
          {
            'jam': '11.20 - 12.40 WIT',
            'mapel': 'PRAKARYA',
            'guru': 'Maryani Albugis, S.Pd',
          },
        ],
        'Kelas 9': [
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'BHS.INDONESIA',
            'guru': 'Raisanti Baradi, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'BHS.INGGRIS',
            'guru': 'Yenny Mas\'ud, S.Pd',
          },
          {
            'jam': '11.20 - 12.40 WIT',
            'mapel': 'IPS',
            'guru': 'Uliyanti Robo, S.Pd',
          },
        ],
      },
      'Hari Kamis': {
        'Kelas 7': [
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'MATEMATIKA',
            'guru': 'Marlia Mahmud, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'IPA',
            'guru': 'Fahria Kasim, S.Pd',
          },
          {
            'jam': '11.20 - 13.00 WIT',
            'mapel': 'IPS',
            'guru': 'Sarina Abubakar, S.Pd',
          },
        ],
        'Kelas 8': [
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'PJOK',
            'guru': 'Darmin Umar, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 12.00 WIT',
            'mapel': 'BHS.INDONESIA',
            'guru': 'Raisanti Baradi, S.Pd',
          },
          {
            'jam': '12.00 - 13.00 WIT',
            'mapel': 'BHS.INGGRIS',
            'guru': 'Yenny Mas\'ud, S.Pd',
          },
        ],
        'Kelas 9': [
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'BHS.INDONESIA',
            'guru': 'Raisanti Baradi, S.Pd',
          },
          {'jam': '09.30 - 10.00 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.00 - 12.00 WIT',
            'mapel': 'PPKN',
            'guru': 'Nurdiana Mahmud, SH',
          },
          {
            'jam': '12.00 - 13.00 WIT',
            'mapel': 'BHS.INDONESIA',
            'guru': 'Raisanti Baradi, S.Pd',
          },
        ],
      },
      'Hari Jumat': {
        'Kelas 7': [
          {'jam': '07.00 - 07.30 WIT', 'mapel': 'SHOLAT DHUHA', 'guru': '-'},
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'PEND.AGAMA ISLAM',
            'guru': 'Nurdiana Mahmud, SH',
          },
          {'jam': '09.30 - 10.10 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.10 - 11.00 WIT',
            'mapel': 'PRAKARYA',
            'guru': 'Maryani Albugis, S.Pd',
          },
        ],
        'Kelas 8': [
          {'jam': '07.00 - 07.30 WIT', 'mapel': 'SHOLAT DHUHA', 'guru': '-'},
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'BHS.INDONESIA',
            'guru': 'Raisanti Baradi, S.Pd',
          },
          {'jam': '09.30 - 10.10 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.10 - 11.00 WIT',
            'mapel': 'TIKOM',
            'guru': 'Dandi Karim, S.Pd',
          },
        ],
        'Kelas 9': [
          {'jam': '07.00 - 07.30 WIT', 'mapel': 'SHOLAT DHUHA', 'guru': '-'},
          {
            'jam': '07.30 - 09.30 WIT',
            'mapel': 'MATEMATIKA',
            'guru': 'Marlia Mahmud, S.Pd',
          },
          {'jam': '09.30 - 10.10 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '10.10 - 11.00 WIT',
            'mapel': 'PJOK',
            'guru': 'Darmin Umar, S.Pd',
          },
        ],
      },
      'Hari Sabtu': {
        'Kelas 7': [
          {
            'jam': '07.30 - 08.50 WIT',
            'mapel': 'SENAM INDONESIA HEBAT',
            'guru': 'Senam / Guru Wali',
          },
          {'jam': '08.50 - 09.30 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '09.30 - 11.20 WIT',
            'mapel': 'GURU WALI',
            'guru': 'Senam / Guru Wali',
          },
        ],
        'Kelas 8': [
          {
            'jam': '07.30 - 08.50 WIT',
            'mapel': 'SENAM INDONESIA HEBAT',
            'guru': 'Senam / Guru Wali',
          },
          {'jam': '08.50 - 09.30 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '09.30 - 11.20 WIT',
            'mapel': 'GURU WALI',
            'guru': 'Senam / Guru Wali',
          },
        ],
        'Kelas 9': [
          {
            'jam': '07.30 - 08.50 WIT',
            'mapel': 'SENAM INDONESIA HEBAT',
            'guru': 'Senam / Guru Wali',
          },
          {'jam': '08.50 - 09.30 WIT', 'mapel': 'ISTIRAHAT', 'guru': '-'},
          {
            'jam': '09.30 - 10.00 WIT',
            'mapel': 'IPS',
            'guru': 'Uliyanti Robo, S.Pd',
          },
          {
            'jam': '10.00 - 11.20 WIT',
            'mapel': 'GURU WALI',
            'guru': 'Senam / Guru Wali',
          },
        ],
      },
    };

    // Loop data untuk disimpan ke Firestore
    for (var entryHari in masterJadwal.entries) {
      String namaHari = entryHari.key;
      var kelasMap = entryHari.value;

      for (var entryKelas in kelasMap.entries) {
        String namaKelas = entryKelas.key;
        List<Map<String, String>> listJadwal = entryKelas.value;

        // Ambil reference ke sub-collection
        var subColRef = _db
            .collection('jadwal')
            .doc(namaHari)
            .collection(namaKelas);

        // Hapus data lama agar tidak menumpuk saat di-upload ulang
        var oldDocs = await subColRef.get();
        for (var doc in oldDocs.docs) {
          await doc.reference.delete();
        }

        // Upload item jadwal satu per satu
        for (var item in listJadwal) {
          await subColRef.add(item);
        }
      }
    }
  }
}
