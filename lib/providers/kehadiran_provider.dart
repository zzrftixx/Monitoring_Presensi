// import 'package:flutter/material.dart';
// import '../models/siswa.dart';
// import '../models/riwayat.dart';

// class KehadiranProvider with ChangeNotifier {
//   List<Siswa> _siswa = [
//     Siswa(nama: 'Ali', nim: '362358302101'),
//     Siswa(nama: 'Budi', nim: '362358302202'),
//     Siswa(nama: 'Citra', nim: '362358302303'),
//     Siswa(nama: 'andra', nim: '362358302404'),
//     Siswa(nama: 'dony', nim: '362358302505'),
//     Siswa(nama: 'setiwan', nim: '362358302606'),
//   ];

//   List<Riwayat> _riwayat = [];

//   List<Siswa> get siswa => _siswa;
//   List<Riwayat> get riwayat => _riwayat;

//   void addRiwayat(Riwayat newRiwayat) {
//     _riwayat.add(newRiwayat);
//     notifyListeners();
//   }

//   void addSiswa(Siswa newSiswa) {
//     _siswa.add(newSiswa);
//     notifyListeners();
//   }

//   void toggleKehadiran(int index) {
//     _siswa[index].hadir = !_siswa[index].hadir;
//     notifyListeners();
//   }

//   void simpanKehadiran() {
//     int jumlahHadir = _siswa.where((s) => s.hadir).length;
//     int jumlahTidakHadir = _siswa.length - jumlahHadir;
//     _riwayat.add(Riwayat(
//       tanggal: DateTime.now().toString(),
//       hadir: jumlahHadir,
//       tidakHadir: jumlahTidakHadir,
//     ));
//     _siswa.forEach((s) => s.hadir = false); // Reset kehadiran
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import '../models/siswa.dart';
import '../models/riwayat.dart';

class KehadiranProvider with ChangeNotifier {
  List<Siswa> _siswa = [
    Siswa(nama: 'Ali', nim: '362358302101'),
    Siswa(nama: 'Budi', nim: '362358302202'),
    Siswa(nama: 'Citra', nim: '362358302303'),
    Siswa(nama: 'Andra', nim: '362358302404'),
    Siswa(nama: 'Dony', nim: '362358302505'),
    Siswa(nama: 'Setiawan', nim: '362358302606'),
  ];

  List<Riwayat> _riwayat = [];

  List<Siswa> get siswa => _siswa;
  List<Riwayat> get riwayat => _riwayat;

  void addRiwayat(Riwayat newRiwayat) {
    _riwayat.add(newRiwayat);
    notifyListeners();
  }

  void addSiswa(Siswa newSiswa) {
    _siswa.add(newSiswa);
    notifyListeners();
  }

  void toggleKehadiran(int index) {
    _siswa[index].hadir = !_siswa[index].hadir;
    notifyListeners();
  }

  void simpanKehadiran(Function(List<Siswa>, List<Siswa>) onSaved) {
    List<Siswa> siswaHadir = _siswa.where((s) => s.hadir).toList();
    List<Siswa> siswaTidakHadir = _siswa.where((s) => !s.hadir).toList();

    _riwayat.add(Riwayat(
      tanggal: DateTime.now().toString(),
      siswaHadir: siswaHadir,
      siswaTidakHadir: siswaTidakHadir,
    ));

    _siswa.forEach((s) => s.hadir = false); // Reset kehadiran
    notifyListeners();

    // Panggil callback untuk mengembalikan siswa yang hadir dan tidak hadir
    onSaved(siswaHadir, siswaTidakHadir);
  }
}

  // void simpanKehadiran() {
  //   List<Siswa> siswaHadir = _siswa.where((s) => s.hadir).toList();
  //   List<Siswa> siswaTidakHadir = _siswa.where((s) => !s.hadir).toList();

  //   _riwayat.add(Riwayat(
  //     tanggal: DateTime.now().toString(),
  //     siswaHadir: siswaHadir,
  //     siswaTidakHadir: siswaTidakHadir,
  //   ));

  //   _siswa.forEach((s) => s.hadir = false); // Reset kehadiran
  //   notifyListeners();
  // }