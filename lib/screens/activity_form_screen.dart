import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../providers/activity_provider.dart';

class ActivityFormScreen extends StatefulWidget {
  final String? id;

  const ActivityFormScreen({super.key, this.id});

  @override
  State<ActivityFormScreen> createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  DateTime? _selectedDate;

  bool _isDone = false;
  bool _isFavorite = false;

  final List<String> _categories = [
    'Pemrograman',
    'Kuliah',
    'Tugas',
    'Penelitian',
    'Ujian',
  ];

  bool get isEdit => widget.id != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final provider = context.read<ActivityProvider>();

      final activity = provider.activities.firstWhere(
        (item) => item.id == widget.id,
      );

      _titleController.text = activity.title;
      _descriptionController.text = activity.description;
      _selectedCategory = activity.category;
      _selectedDate = activity.dueDate;
      _isDone = activity.isDone;
      _isFavorite = activity.isFavorite;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveActivity() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tanggal harus dipilih.')));
      return;
    }

    final provider = context.read<ActivityProvider>();

    if (isEdit) {
      final activity = Activity(
        id: provider.generateId(),
        title: _titleController.text.trim(),
        category: _selectedCategory!,
        dueDate: _selectedDate!,
        description: _descriptionController.text.trim(),
        isDone: _isDone,
        isFavorite: _isFavorite,
      );

      provider.updateActivity(activity);
    } else {
      final activity = Activity(
        id: provider.generateId(),
        title: _titleController.text.trim(),
        category: _selectedCategory!,
        dueDate: _selectedDate!,
        description: _descriptionController.text.trim(),
        isDone: _isDone,
        isFavorite: _isFavorite,
      );

      provider.addActivity(activity);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Aktivitas' : 'Tambah Aktivitas'),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              maxLength: 80,
              decoration: const InputDecoration(
                labelText: 'Judul Aktivitas',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Judul wajib diisi.';
                }

                if (value.trim().length < 3) {
                  return 'Judul minimal 3 karakter.';
                }

                if (value.trim().length > 80) {
                  return 'Judul maksimal 80 karakter.';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kategori wajib dipilih.';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            InkWell(
              onTap: _selectDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'Pilih tanggal'
                      : '${_selectedDate!.day}/'
                            '${_selectedDate!.month}/'
                            '${_selectedDate!.year}',
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              maxLength: 300,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != null && value.length > 300) {
                  return 'Deskripsi maksimal 300 karakter.';
                }

                return null;
              },
            ),

            SwitchListTile(
              title: const Text('Sudah selesai'),
              value: _isDone,
              onChanged: (value) {
                setState(() {
                  _isDone = value;
                });
              },
            ),

            SwitchListTile(
              title: const Text('Favorit'),
              value: _isFavorite,
              onChanged: (value) {
                setState(() {
                  _isFavorite = value;
                });
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _saveActivity,
              child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Aktivitas'),
            ),

            const SizedBox(height: 8),

            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }
}
