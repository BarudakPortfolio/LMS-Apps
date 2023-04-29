import 'file.dart';
import 'kelas_mapel.dart';
import 'guru.dart';
import 'mapel.dart';

class Tugas {
  int? id;
  String? tugasId;
  String? siswaId;
  String? foto;
  String? linkYoutube;
  String? linkDownload;
  String? tipeFile;
  String? namaFile;
  String? ukuranFile;
  String? direktori;
  String? nilai;
  String? pesan;
  String? tanggalUpload;
  String? isDone;
  String? revisi;
  String? revisiCount;
  String? alasanRevisi;
  String? createdAt;
  String? updatedAt;
  Detail? detail;
  List<File>? file;
  Guru? guru;
  KelasMapel? kelasMapel;

  Tugas({
    this.id,
    this.tugasId,
    this.siswaId,
    this.foto,
    this.linkYoutube,
    this.linkDownload,
    this.tipeFile,
    this.namaFile,
    this.ukuranFile,
    this.direktori,
    this.nilai,
    this.pesan,
    this.tanggalUpload,
    this.isDone,
    this.revisi,
    this.revisiCount,
    this.alasanRevisi,
    this.createdAt,
    this.updatedAt,
    this.detail,
    this.file,
    this.guru,
    this.kelasMapel,
  });

  Tugas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tugasId = json['tugas_id'];
    siswaId = json['siswa_id'];
    foto = json['foto'];
    linkYoutube = json['link_youtube'];
    linkDownload = json['link_download'];
    tipeFile = json['tipe_file'];
    namaFile = json['nama_file'];
    ukuranFile = json['ukuran_file'];
    direktori = json['direktori'];
    nilai = json['nilai'];
    pesan = json['pesan'];
    tanggalUpload = json['tanggal_upload'];
    isDone = json['is_done'];
    revisi = json['revisi'];
    revisiCount = json['revisi_count'];
    alasanRevisi = json['alasan_revisi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    if (json['file'] != null) {
      file = [];
      json['file'].forEach((v) {
        file!.add(File.fromJson(v));
      });
    }
    guru = json['detail']['kelas_mapel']['guru'] != null
        ? Guru.fromJson(json['detail']['kelas_mapel']['guru'])
        : null;
    kelasMapel = json['detail']['kelas_mapel'] != null
        ? KelasMapel.fromJson(json['detail']['kelas_mapel'])
        : null;
  }
}

class Detail {
  int? id;
  String? mapelId;
  String? kelasMapelId;
  String? judul;
  String? linkYoutube;
  String? konten;
  String? jenis;
  String? tanggalMulai;
  String? tanggalPengumpulan;
  String? isActive;
  String? tahunAjaran;
  String? semester;
  String? createdAt;
  String? updatedAt;
  String? rombel;
  Mapel? mapel;
  List<ImageTugas>? image;

  Detail(
      {this.id,
      this.mapelId,
      this.kelasMapelId,
      this.judul,
      this.linkYoutube,
      this.konten,
      this.jenis,
      this.tanggalMulai,
      this.tanggalPengumpulan,
      this.isActive,
      this.tahunAjaran,
      this.semester,
      this.createdAt,
      this.updatedAt,
      this.rombel,
      this.mapel,
      this.image});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mapelId = json['mapel_id'];
    kelasMapelId = json['kelas_mapel_id'];
    judul = json['judul'];
    linkYoutube = json['link_youtube'];
    konten = json['konten'];
    jenis = json['jenis'];
    tanggalMulai = json['tanggal_mulai'];
    tanggalPengumpulan = json['tanggal_pengumpulan'];
    isActive = json['is_active'];
    tahunAjaran = json['tahun_ajaran'];
    semester = json['semester'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rombel = json['rombel'];
    mapel = json['mapel'] != null ? Mapel.fromJson(json['mapel']) : null;
    if (json['image'] != null) {
      image = <ImageTugas>[];
      json['image'].forEach((v) {
        image!.add(ImageTugas.fromJson(v));
      });
    }
  }
}

class Tingkat {
  int? id;
  String? nama;
  String? deskripsi;
  String? createdAt;
  String? updatedAt;

  Tingkat({this.id, this.nama, this.deskripsi, this.createdAt, this.updatedAt});

  Tingkat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class ImageTugas {
  int? id;
  String? tugasId;
  String? image;
  String? createdAt;
  String? updatedAt;

  ImageTugas(
      {this.id, this.tugasId, this.image, this.createdAt, this.updatedAt});

  ImageTugas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tugasId = json['tugas_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
