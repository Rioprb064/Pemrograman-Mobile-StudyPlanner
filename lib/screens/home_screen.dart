import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/activity_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study Planner')),

      body: Consumer<ActivityProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Halooww!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Simpan dan kelola aktivitas belajar disini supaya mudah diingat dan dikerjakan',
              ),

              const SizedBox(height: 52),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.push('/activities');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Icon(Icons.assignment, size: 35),
                              const SizedBox(height: 8),
                              Text(
                                '${provider.activities.length}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Total Aktivitas'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.push('/activities/completed');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Icon(Icons.check_circle, size: 35),
                              const SizedBox(height: 8),
                              Text(
                                '${provider.completedCount}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Selesai'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.push('/favorites');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Icon(Icons.favorite, size: 35),
                              const SizedBox(height: 8),
                              Text(
                                '${provider.favoriteCount}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Favorit'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.push('/activities/pending');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Icon(Icons.pending_actions, size: 35),
                              const SizedBox(height: 8),
                              Text(
                                '${provider.activities.length - provider.completedCount}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Belum Selesai'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),

      // Navigasi bawah
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _BottomButton(
                  icon: Icons.list,
                  label: 'Daftar',
                  onPressed: () {
                    context.push('/activities');
                  },
                ),
              ),

              Expanded(
                child: _BottomButton(
                  icon: Icons.add,
                  label: 'Tambah',
                  onPressed: () {
                    context.push('/activity/add');
                  },
                ),
              ),

              Expanded(
                child: _BottomButton(
                  icon: Icons.person,
                  label: 'Profil',
                  onPressed: () {
                    context.push('/profile');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _BottomButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: onPressed, icon: Icon(icon)),
        Text(label),
      ],
    );
  }
}
