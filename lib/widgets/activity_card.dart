import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../providers/activity_provider.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: () {
          context.push('/activity/${activity.id}');
        },

        title: Text(
          activity.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: activity.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),

            Text('Kategori: ${activity.category}'),

            Text(
              'Tanggal: ${activity.dueDate.day}/'
              '${activity.dueDate.month}/'
              '${activity.dueDate.year}',
            ),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                context.read<ActivityProvider>().toggleDone(activity.id);
              },
              icon: Icon(
                activity.isDone
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: activity.isDone ? Colors.green : Colors.grey,
              ),
            ),

            IconButton(
              onPressed: () {
                context.read<ActivityProvider>().toggleFavorite(activity.id);
              },
              icon: Icon(
                activity.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: activity.isFavorite ? Colors.brown : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
