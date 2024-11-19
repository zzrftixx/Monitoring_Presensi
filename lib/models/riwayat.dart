import 'package:monitoring_kehadiran_siswa/models/siswa.dart';

class Riwayat {
  final String tanggal;
  final List<Siswa> siswaHadir;
  final List<Siswa> siswaTidakHadir;

  Riwayat({
    required this.tanggal,
    required this.siswaHadir,
    required this.siswaTidakHadir,
  });
}
