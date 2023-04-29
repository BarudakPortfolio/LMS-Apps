import '../core/utils/extentions/nama_dosen.dart';

class Kelas {
  String? id;
  String? nama;
  String? namaGuru;
  String? avatar;
  String? hari;
  String? waktuMulai;
  String? waktuSelesai;
  String? ruangan;

  Kelas({
    this.id,
    this.nama,
    this.namaGuru,
    this.hari,
    this.avatar,
    this.waktuMulai,
    this.waktuSelesai,
    this.ruangan,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id: json['kelas_mapel']['mapel']['id'].toString(),
      nama: json['kelas_mapel']['mapel']['nama'],
      namaGuru: namaDosen(
        json['kelas_mapel']['guru']['nama'],
        json['kelas_mapel']['guru']['gelar_depan'],
        json['kelas_mapel']['guru']['gelar_belakang'],
      ),
      avatar: json['kelas_mapel']['guru']['avatar'],
      hari: json['hari'],
      waktuMulai: json['jam_mulai'],
      waktuSelesai: json['jam_selesai'],
      ruangan: json['ruangan']['nama'],
    );
  }
}
