import 'file.dart';
import 'foto.dart';
import 'kelas_mapel.dart';
import 'mapel.dart';

class Materi {
  int? id;
  String? mapelId;
  String? kelasMapelId;
  String? judul;
  String? linkYoutube;
  String? konten;
  String? pertemuanKe;
  String? tanggalPerkuliahan;
  String? bahasan;
  String? lingkup;
  String? modeKuliah;
  String? isActive;
  String? foto;
  String? createdAt;
  String? updatedAt;
  List<File>? file;
  KelasMapel? kelasMapel;
  Mapel? mapel;
  Foto? fotoAuth;

  Materi({
    this.id,
    this.mapelId,
    this.kelasMapelId,
    this.judul,
    this.linkYoutube,
    this.konten,
    this.pertemuanKe,
    this.tanggalPerkuliahan,
    this.bahasan,
    this.lingkup,
    this.modeKuliah,
    this.isActive,
    this.foto,
    this.createdAt,
    this.updatedAt,
    this.kelasMapel,
    this.file,
    this.mapel,
    this.fotoAuth,
  });

  Materi.fromJson(Map<String, dynamic> json, {Map<String, dynamic>? dataFoto}) {
    id = json['id'];
    mapelId = json['mapel_id'];
    kelasMapelId = json['kelas_mapel_id'];
    judul = json['judul'];
    linkYoutube = json['link_youtube'];
    konten = json['konten'];
    pertemuanKe = json['pertemuan_ke'];
    tanggalPerkuliahan = json['tanggal_perkuliahan'];
    bahasan = json['bahasan'];
    lingkup = json['lingkup'];
    modeKuliah = json['mode_kuliah'];
    isActive = json['is_active'];
    foto = json['foto'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['file'] != null) {
      file = <File>[];
      json['file'].forEach((v) {
        file!.add(File.fromJson(v));
      });
    }
    kelasMapel = json['kelas_mapel'] != null
        ? KelasMapel.fromJson(json['kelas_mapel'])
        : null;
    mapel = json['mapel'] != null ? Mapel.fromJson(json['mapel']) : null;
    fotoAuth = dataFoto != null ? Foto.fromJson(dataFoto) : null;
  }
}
