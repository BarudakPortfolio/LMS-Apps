class FileModel {
  int? id;
  String? materiId;
  String? tipeFile;
  String? namaFile;
  String? ukuranFile;
  String? direktori;
  String? createdAt;
  String? updatedAt;

  FileModel(
      {this.id,
      this.materiId,
      this.tipeFile,
      this.namaFile,
      this.ukuranFile,
      this.direktori,
      this.createdAt,
      this.updatedAt});

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materiId = json['materi_id'];
    tipeFile = json['tipe_file'];
    namaFile = json['nama_file'];
    ukuranFile = json['ukuran_file'];
    direktori = json['direktori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
