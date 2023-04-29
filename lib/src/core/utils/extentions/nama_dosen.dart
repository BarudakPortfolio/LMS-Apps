namaDosen(String? namadepan, String? gelarDepan, String? gelarBelakang) {
  namadepan ??= "";
  gelarBelakang ??= "";
  gelarDepan ??= "";
  return "$gelarDepan $namadepan $gelarBelakang";
}
