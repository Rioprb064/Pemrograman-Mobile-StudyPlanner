import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activity_provider.dart';
import '../widgets/activity_card.dart';

class ActivityListScreen extends StatefulWidget {
  final String initialStatus;

  const ActivityListScreen({super.key, this.initialStatus = 'Semua'});

  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'Semua';
  String _selectedStatus = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Pemrograman',
    'Kuliah',
    'Tugas',
    'Penelitian',
    'Ujian',
  ];

  final List<String> _statuses = ['Semua', 'Belum selesai', 'Selesai'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _selectedStatus = widget.initialStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedStatus == 'Semua'
              ? 'Daftar Aktivitas'
              : _selectedStatus == 'Selesai'
              ? 'Aktivitas Selesai'
              : 'Aktivitas Belum Selesai',
        ),
      ),

      body: Consumer<ActivityProvider>(
        builder: (context, provider, child) {
          final activities = provider.activities.where((activity) {
            final searchText = _searchController.text.toLowerCase();

            final matchSearch = activity.title.toLowerCase().contains(
              searchText,
            );

            final matchCategory =
                _selectedCategory == 'Semua' ||
                activity.category == _selectedCategory;

            bool matchStatus = true;

            if (_selectedStatus == 'Selesai') {
              matchStatus = activity.isDone;
            } else if (_selectedStatus == 'Belum selesai') {
              matchStatus = !activity.isDone;
            }

            return matchSearch && matchCategory && matchStatus;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    labelText: 'Cari aktivitas',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Kategori',
                          border: OutlineInputBorder(),
                        ),
                        items: _categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value ?? 'Semua';
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _selectedStatus,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: _statuses.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value ?? 'Semua';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: activities.isEmpty
                    ? const Center(
                        child: Text(
                          'Aktivitas tidak ditemukan.',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: activities.length,
                        itemBuilder: (context, index) {
                          return ActivityCard(activity: activities[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
