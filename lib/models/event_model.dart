import 'package:flutter/material.dart';

class EventModel {
  final String id;
  final String judul;
  final String deskripsi;
  final String tanggal;
  final String lokasi;
  final IconData ikon;

  EventModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
    required this.lokasi,
    this.ikon = Icons.event,
  });
}