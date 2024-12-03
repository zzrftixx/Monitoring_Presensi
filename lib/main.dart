import 'package:flutter/material.dart';
import 'package:monitoring_kehadiran_siswa/models/siswa.dart';
import 'package:provider/provider.dart';
import 'providers/kehadiran_provider.dart';
import 'screens/riwayat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KehadiranProvider(),
      child: MaterialApp(
        title: 'Monitoring Kehadiran Siswa',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final kehadiranProvider = Provider.of<KehadiranProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Monitoring Kehadiran Siswa')),
      body: _selectedIndex == 0
          ? AttendanceScreen(kehadiranProvider: kehadiranProvider)
          : RiwayatScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pencatatan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  final KehadiranProvider kehadiranProvider;

  AttendanceScreen({required this.kehadiranProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: kehadiranProvider.siswa.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(kehadiranProvider.siswa[index].nama),
                subtitle: Text(kehadiranProvider.siswa[index].nim),
                trailing: Checkbox(
                  value: kehadiranProvider.siswa[index].hadir,
                  onChanged: (value) {
                    kehadiranProvider.toggleKehadiran(index);
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ElevatedButton(
            style: _buildButtonStyle(),
            onPressed: kehadiranProvider.siswa.isEmpty
                ? null
                : () {
                    kehadiranProvider
                        .simpanKehadiran((siswaHadir, siswaTidakHadir) {
                      _showAttendanceDialog(
                          context, siswaHadir, siswaTidakHadir);
                    });
                  },
            child: _buildButtonContent(),
          ),
        ),
      ],
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      elevation: 8,
    );
  }

  Row _buildButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.save, size: 24),
        SizedBox(width: 10),
        Text(
          'Simpan Kehadiran',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold), // Ukuran dan tebal teks
        ),
      ],
    );
  }

  void _showAttendanceDialog(BuildContext context, List<Siswa> siswaHadir,
      List<Siswa> siswaTidakHadir) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kehadiran Tersimpan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Siswa yang hadir:\n' +
                  siswaHadir.map((s) => s.nama).join(', ')),
              const SizedBox(height: 10),
              Text('Siswa yang tidak hadir:\n' +
                  siswaTidakHadir.map((s) => s.nama).join(', ')),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
          ],
        );
      },
    );
  }
}
