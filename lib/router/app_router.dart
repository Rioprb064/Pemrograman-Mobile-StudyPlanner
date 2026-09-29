import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/activity_list_screen.dart';
import '../screens/activity_detail_screen.dart';
import '../screens/activity_form_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),

    GoRoute(
      path: '/activities',
      builder: (context, state) {
        return const ActivityListScreen(initialStatus: 'Semua');
      },
    ),

    GoRoute(
      path: '/activities/completed',
      builder: (context, state) {
        return const ActivityListScreen(initialStatus: 'Selesai');
      },
    ),

    GoRoute(
      path: '/activities/pending',
      builder: (context, state) {
        return const ActivityListScreen(initialStatus: 'Belum selesai');
      },
    ),

    GoRoute(
      path: '/activity/add',
      builder: (context, state) {
        return const ActivityFormScreen();
      },
    ),

    GoRoute(
      path: '/activity/edit/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return ActivityFormScreen(id: id);
      },
    ),

    GoRoute(
      path: '/activity/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return ActivityDetailScreen(id: id);
      },
    ),

    GoRoute(
      path: '/favorites',
      builder: (context, state) {
        return const FavoriteScreen();
      },
    ),

    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return const ProfileScreen();
      },
    ),
  ],
);
