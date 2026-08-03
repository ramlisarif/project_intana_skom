import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/event_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sekolah.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Fungsi Pembuatan Tabel-Tabel
  Future _createDB(Database db, int version) async {
    // 1. Tabel Guru
    await db.execute('''
      CREATE TABLE guru (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nip TEXT NOT NULL,
        nama TEXT NOT NULL
      )
    ''');

    // 2. Tabel KBM
    await db.execute('''
      CREATE TABLE kbm (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kelas TEXT NOT NULL,
        mata_pelajaran TEXT NOT NULL,
        jam TEXT NOT NULL
      )
    ''');

    // 3. Tabel Lab
    await db.execute('''
      CREATE TABLE lab (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_lab TEXT NOT NULL,
        jam_masuk TEXT NOT NULL,
        jam_keluar TEXT NOT NULL
      )
    ''');

    // 4. Tabel Event
    await db.execute('''
      CREATE TABLE event (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        deskripsi TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        lokasi TEXT NOT NULL
      )
    ''');

    // Mengisi data dummy default awal saat database pertama kali dibuat
    await _insertInitialData(db);
  }

  // Data Awal (Dummy Data Seed)
  Future<void> _insertInitialData(Database db) async {
    await db.insert('event', {
      'judul': 'Ujian Praktikum Jaringan',
      'deskripsi': 'Wajib membawa kabel UTP dan Tang Crimp masing-masing.',
      'tanggal': '30 Juli 2026',
      'lokasi': 'Lab Jaringan',
    });

    await db.insert('event', {
      'judul': 'Maintenance Perangkat Lab',
      'deskripsi': 'Lab Komputer 1 ditutup sementara untuk maintenance PC.',
      'tanggal': '01 Agustus 2026',
      'lokasi': 'Lab Komputer 1',
    });
  }

  // ================= CRUD UNTUK EVENT =================

  // Create (Tambah Event)
  Future<int> insertEvent(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('event', row);
  }

  // Read (Ambil Semua Event)
  Future<List<EventModel>> getAllEvents() async {
    final db = await instance.database;
    final result = await db.query('event', orderBy: 'id DESC');

    return result.map((json) => EventModel(
      id: json['id'].toString(),
      judul: json['judul'] as String,
      deskripsi: json['deskripsi'] as String,
      tanggal: json['tanggal'] as String,
      lokasi: json['lokasi'] as String,
    )).toList();
  }

  // Delete (Hapus Event)
  Future<int> deleteEvent(int id) async {
    final db = await instance.database;
    return await db.delete(
      'event',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}