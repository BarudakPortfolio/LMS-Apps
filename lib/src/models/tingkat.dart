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