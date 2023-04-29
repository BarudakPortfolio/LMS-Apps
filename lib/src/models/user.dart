class UserModel {
  String? idUser;
  String? name;
  String? nim;
  String? agama;
  String? jenisKelamin;
  String? kelas;
  String? type;
  String? semester;
  String? avatar;
  String? email;
  String? noTelp;
  String? prodi;
  String? alamat;
  String? tempatLahir;
  String? tanggalLahir;
  String? tahunMasuk;

  UserModel({
    this.idUser,
    this.name,
    this.nim,
    this.agama,
    this.jenisKelamin,
    this.kelas,
    this.type,
    this.avatar,
    this.semester,
    this.email,
    this.noTelp,
    this.alamat,
    this.tanggalLahir,
    this.tempatLahir,
    this.prodi,
    this.tahunMasuk,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['user_id'],
      name: json['nama'],
      nim: json['nim'],
      agama: json['agama'],
      jenisKelamin: json['jenis_kelamin'],
      kelas: json['kelas'][0]['nama'],
      type: json['user']['user_type'],
      semester: json['semester'],
      avatar: json['avatar'],
      email: json['email'],
      noTelp: json['no_hp'],
      alamat: json['alamat'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: json['tanggal_lahir'],
      prodi: json['prodi']['nama'],
      tahunMasuk: json['tahun_masuk'],
    );
  }
}
