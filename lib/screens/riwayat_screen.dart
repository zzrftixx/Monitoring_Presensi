import 'package:flutter/material.dart';
import 'package:monitoring_kehadiran_siswa/models/riwayat.dart';
import 'package:provider/provider.dart';
import '../providers/kehadiran_provider.dart';

class RiwayatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kehadiranProvider = Provider.of<KehadiranProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Kehadiran'),
      ),
      body: ListView.builder(
        itemCount: kehadiranProvider.riwayat.length,
        itemBuilder: (context, index) {
          final riwayat = kehadiranProvider.riwayat[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Tanggal: ${riwayat.tanggal}'),
              subtitle: Text(
                  'Hadir: ${riwayat.siswaHadir.length}, Tidak Hadir: ${riwayat.siswaTidakHadir.length}'),
              onTap: () {
                // Navigasi ke halaman detail
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailRiwayatScreen(riwayat: riwayat),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailRiwayatScreen extends StatelessWidget {
  final Riwayat riwayat;

  DetailRiwayatScreen({required this.riwayat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kehadiran'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal: ${riwayat.tanggal}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Siswa Hadir:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...riwayat.siswaHadir.map((siswa) => ListTile(
                  title: Text(siswa.nama),
                  leading: Icon(Icons.check_circle, color: Colors.green),
                )),
            SizedBox(height: 20),
            Text('Siswa Tidak Hadir:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...riwayat.siswaTidakHadir.map((siswa) => ListTile(
                  title: Text(siswa.nama),
                  leading: Icon(Icons.cancel, color: Colors.red),
                )),
          ],
        ),
      ),
    );
  }
}
