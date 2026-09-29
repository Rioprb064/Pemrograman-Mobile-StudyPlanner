# Study Planner

Study Planner adalah aplikasi Flutter sederhana untuk membantu mahasiswa
mengatur dan memantau aktivitas belajar.

## Fitur

- Menampilkan daftar aktivitas belajar
- Menambahkan aktivitas
- Mengedit aktivitas
- Menghapus aktivitas dengan konfirmasi
- Membatalkan proses tambah/edit
- Menandai aktivitas sebagai selesai
- Menandai aktivitas sebagai favorit
- Pencarian aktivitas
- Filter berdasarkan kategori
- Filter berdasarkan status
- Halaman detail aktivitas
- Statistik aktivitas pada halaman Beranda
- Halaman Profil

## Data Aktivitas

Setiap aktivitas memiliki:

- ID
- Judul
- Kategori
- Tanggal
- Deskripsi
- Status selesai
- Status favorit

Aplikasi menggunakan minimal 10 data dummy pada saat awal dijalankan.

## Teknologi

- Flutter
- Dart
- Provider
- go_router

## Struktur Project

```text
lib/
├── main.dart
├── models/
│   ├── activity.dart
│   └── dummy_data.dart
├── providers/
│   └── activity_provider.dart
├── router/
│   └── app_router.dart
├── screens/
│   ├── home_screen.dart
│   ├── activity_list_screen.dart
│   ├── activity_detail_screen.dart
│   ├── activity_form_screen.dart
│   ├── favorite_screen.dart
│   └── profile_screen.dart
└── widgets/
    └── activity_card.dart