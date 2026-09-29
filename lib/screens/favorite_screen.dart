import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activity_provider.dart';
import '../widgets/activity_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit')),

      body: Consumer<ActivityProvider>(
        builder: (context, provider, child) {
          final favorites = provider.favoriteActivities;

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada aktivitas favorit.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return ActivityCard(activity: favorites[index]);
            },
          );
        },
      ),
    );
  }
}
