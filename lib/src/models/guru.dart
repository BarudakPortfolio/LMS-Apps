class Guru {
  int? id;
  String? userId;
  String? nidn;
  String? nama;
  String? gelarDepan;
  String? gelarBelakang;
  String? avatar;
  String? jenisKelamin;
  String? agama;
  String? noHp;
  String? email;
  String? atasNama;
  String? nip;
  String? tempatLahir;
  String? tanggalLahir;
  String? province;
  String? regency;
  String? district;
  String? village;
  String? kodePos;
  String? alamat;
  String? tanggalMasuk;
  String? createdAt;
  String? updatedAt;

  Guru(
      {this.id,
      this.userId,
      this.nidn,
      this.nama,
      this.gelarDepan,
      this.gelarBelakang,
      this.avatar,
      this.jenisKelamin,
      this.agama,
      this.noHp,
      this.email,
      this.atasNama,
      this.nip,
      this.tempatLahir,
      this.tanggalLahir,
      this.province,
      this.regency,
      this.district,
      this.village,
      this.kodePos,
      this.alamat,
      this.tanggalMasuk,
      this.createdAt,
      this.updatedAt});

  Guru.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nidn = json['nidn'];
    nama = json['nama'];
    gelarDepan = json['gelar_depan'];
    gelarBelakang = json['gelar_belakang'];
    avatar = json['avatar'];
    jenisKelamin = json['jenis_kelamin'];
    agama = json['agama'];
    noHp = json['no_hp'];
    email = json['email'];
    atasNama = json['atas_nama'];
    nip = json['nip'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    province = json['province'];
    regency = json['regency'];
    district = json['district'];
    village = json['village'];
    kodePos = json['kode_pos'];
    alamat = json['alamat'];
    tanggalMasuk = json['tanggal_masuk'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
