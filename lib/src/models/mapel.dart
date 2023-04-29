import 'prodi.dart';
import 'tingkat.dart';

class Mapel {
  int? id;
  String? tingkatId;
  String? prodiId;
  String? kelompokId;
  String? semester;
  String? kodeMatkul;
  String? nama;
  String? jenisMk;
  String? singkatan;
  String? kkm;
  String? bobotMk;
  String? bobotSimulasi;
  String? metodePembelajaran;
  String? tglMulai;
  String? tglAkhir;
  String? bobotTm;
  String? bobotPk;
  String? bobotPl;
  String? createdAt;
  String? updatedAt;
  Tingkat? tingkat;
  Prodi? prodi;
  Tingkat? kelompok;

  Mapel(
      {this.id,
      this.tingkatId,
      this.prodiId,
      this.kelompokId,
      this.semester,
      this.kodeMatkul,
      this.nama,
      this.jenisMk,
      this.singkatan,
      this.kkm,
      this.bobotMk,
      this.bobotSimulasi,
      this.metodePembelajaran,
      this.tglMulai,
      this.tglAkhir,
      this.bobotTm,
      this.bobotPk,
      this.bobotPl,
      this.createdAt,
      this.updatedAt,
      this.tingkat,
      this.prodi,
      this.kelompok});

  Mapel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tingkatId = json['tingkat_id'];
    prodiId = json['prodi_id'];
    kelompokId = json['kelompok_id'];
    semester = json['semester'];
    kodeMatkul = json['kode_matkul'];
    nama = json['nama'];
    jenisMk = json['jenis_mk'];
    singkatan = json['singkatan'];
    kkm = json['kkm'];
    bobotMk = json['bobot_mk'];
    bobotSimulasi = json['bobot_simulasi'];
    metodePembelajaran = json['metode_pembelajaran'];
    tglMulai = json['tgl_mulai'];
    tglAkhir = json['tgl_akhir'];
    bobotTm = json['bobot_tm'];
    bobotPk = json['bobot_pk'];
    bobotPl = json['bobot_pl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tingkat =
        json['tingkat'] != null ? Tingkat.fromJson(json['tingkat']) : null;
    prodi = json['prodi'] != null ? Prodi.fromJson(json['prodi']) : null;
    kelompok =
        json['kelompok'] != null ? Tingkat.fromJson(json['kelompok']) : null;
  }
}
