import 'guru.dart';

class KelasMapel {
  int? id;
  String? asistenId;
  String? guruId;
  String? mapelId;
  String? nama;
  String? tahunAjaran;
  String? semester;
  String? bobotUts;
  String? bobotUas;
  String? bobotAbsen;
  String? bobotTugas;
  Guru? guru;

  KelasMapel({
    this.id,
    this.asistenId,
    this.guruId,
    this.mapelId,
    this.nama,
    this.tahunAjaran,
    this.semester,
    this.bobotUts,
    this.bobotUas,
    this.bobotAbsen,
    this.bobotTugas,
    this.guru,
  });

  KelasMapel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    asistenId = json['asisten_id'];
    guruId = json['guru_id'];
    mapelId = json['mapel_id'];
    nama = json['nama'];
    tahunAjaran = json['tahun_ajaran'];
    semester = json['semester'];
    bobotUts = json['bobot_uts'];
    bobotUas = json['bobot_uas'];
    bobotAbsen = json['bobot_absen'];
    bobotTugas = json['bobot_tugas'];
    guru = json['guru'] != null ? Guru.fromJson(json['guru']) : null;
  }
}
