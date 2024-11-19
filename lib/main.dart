import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/kehadiran_provider.dart';
import 'screens/riwayat_screen.dart'; // Pastikan Anda mengimpor RiwayatScreen

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
    Widget body;

    if (_selectedIndex == 0) {
      body = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: kehadiranProvider.siswa.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(kehadiranProvider.siswa[index].nama),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // Warna teks
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    30.0), // Membuat sudut tombol lebih bulat
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 25), // Padding tombol
            ),
            onPressed: kehadiranProvider.siswa.isEmpty
                ? null
                : () {
                    kehadiranProvider.simpanKehadiran();
                  },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.save, size: 24), // Menambahkan ikon simpan
                SizedBox(width: 10), // Jarak antara ikon dan teks
                Text('Simpan Kehadiran',
                    style: TextStyle(fontSize: 18)), // Ukuran teks
              ],
            ),
          ),
        ],
      );
    } else {
      body = RiwayatScreen(); // Pastikan RiwayatScreen didefinisikan
    }

    return Scaffold(
      appBar: AppBar(title: Text('Monitoring Kehadiran Siswa')),
      body: body,
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