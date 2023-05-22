import '../../../models/guru.dart';

String namaDosen(Guru guru) {
  final nama = guru.nama ?? "";
  final gelarDepan = guru.gelarDepan ?? "";
  final gelarBelakang = guru.gelarBelakang ?? "";
  return "$gelarDepan $nama $gelarBelakang";
}
