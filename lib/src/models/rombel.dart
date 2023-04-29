class Rombel {
  int? id;
  String? prodiId;
  String? guruId;
  String? siswaId;
  String? nama;
  String? deskripsi;
  String? tahunAjaran;
  String? semester;
  String? tingkatId;
  String? createdAt;
  String? updatedAt;

  Rombel(
      {this.id,
        this.prodiId,
        this.guruId,
        this.siswaId,
        this.nama,
        this.deskripsi,
        this.tahunAjaran,
        this.semester,
        this.tingkatId,
        this.createdAt,
        this.updatedAt});

  Rombel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prodiId = json['prodi_id'];
    guruId = json['guru_id'];
    siswaId = json['siswa_id'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    tahunAjaran = json['tahun_ajaran'];
    semester = json['semester'];
    tingkatId = json['tingkat_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}