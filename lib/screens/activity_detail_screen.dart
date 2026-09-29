import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../providers/activity_provider.dart';

class ActivityDetailScreen extends StatelessWidget {
  final String id;

  const ActivityDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivityProvider>();

    Activity? activity;

    for (Activity item in provider.activities) {
      if (item.id == id) {
        activity = item;
        break;
      }
    }

    if (activity == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Aktivitas')),
        body: const Center(child: Text('Aktivitas tidak ditemukan.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Aktivitas')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              activity.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text('ID', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(activity.id),

            const SizedBox(height: 16),

            Text(
              'Kategori',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(activity.category),

            const SizedBox(height: 16),

            Text(
              'Tanggal',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${activity.dueDate.day}/'
              '${activity.dueDate.month}/'
              '${activity.dueDate.year}',
            ),

            const SizedBox(height: 16),

            Text(
              'Deskripsi',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              activity.description.isEmpty
                  ? 'Tidak ada deskripsi.'
                  : activity.description,
            ),

            const SizedBox(height: 16),

            Text('Status', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(activity.isDone ? 'Sudah selesai' : 'Belum selesai'),

            const SizedBox(height: 16),

            Text(
              'Favorit',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(activity.isFavorite ? 'Ya' : 'Tidak'),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                context.push('/activity/edit/$id');
              },
              child: const Text('Edit Aktivitas'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                _showDeleteDialog(context, activity!.id);
              },
              child: const Text('Hapus Aktivitas'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Aktivitas'),
          content: const Text(
            'Apakah kamu yakin ingin menghapus aktivitas ini?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<ActivityProvider>().deleteActivity(id);

                Navigator.pop(dialogContext);
                context.pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
