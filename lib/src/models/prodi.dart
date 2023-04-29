import 'rombel.dart';

class Prodi {
  int? id;
  String? kodeProdi;
  String? nama;
  String? singkatan;
  String? jenjang;
  int? jmlMahasiswa;
  int? jmlDosen;
  String? status;
  String? nidn;
  String? namaKajur;
  String? createdAt;
  String? updatedAt;
  String? ketua;
  List<Rombel>? rombel;

  Prodi(
      {this.id,
        this.kodeProdi,
        this.nama,
        this.singkatan,
        this.jenjang,
        this.jmlMahasiswa,
        this.jmlDosen,
        this.status,
        this.nidn,
        this.namaKajur,
        this.createdAt,
        this.updatedAt,
        this.ketua,
        this.rombel});

  Prodi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeProdi = json['kode_prodi'];
    nama = json['nama'];
    singkatan = json['singkatan'];
    jenjang = json['jenjang'];
    jmlMahasiswa = json['jml_mahasiswa'];
    jmlDosen = json['jml_dosen'];
    status = json['status'];
    nidn = json['nidn'];
    namaKajur = json['nama_kajur'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ketua = json['ketua'];
    if (json['rombel'] != null) {
      rombel = <Rombel>[];
      json['rombel'].forEach((v) {
        rombel!.add(Rombel.fromJson(v));
      });
    }
  }
}