class Foto {
  int? id;
  String? materiId;
  String? siswaId;
  String? foto;
  String? createdAt;
  String? updatedAt;

  Foto(
      {this.id,
      this.materiId,
      this.siswaId,
      this.foto,
      this.createdAt,
      this.updatedAt});

  Foto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materiId = json['materi_id'];
    siswaId = json['siswa_id'];
    foto = json['foto'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
