import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/images/pasfoto.jpeg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              'Rionaldo Purba',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.badge),
            title: Text('NIM'),
            subtitle: Text('241401064'),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.school),
            title: Text('Program Studi'),
            subtitle: Text('Ilmu Komputer'),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Semester'),
            subtitle: Text('Semester 5'),
          ),

          const Divider(),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              'Aplikasi pribadi untuk mengatur aktivitas belajar.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
