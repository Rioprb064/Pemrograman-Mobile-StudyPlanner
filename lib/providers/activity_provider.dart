import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../models/dummy_data.dart';

class ActivityProvider extends ChangeNotifier {
  final List<Activity> _activities = List.from(dummyActivities);

  List<Activity> get activities => _activities;

  List<Activity> get favoriteActivities {
    return _activities.where((activity) => activity.isFavorite).toList();
  }

  int get completedCount {
    return _activities.where((activity) => activity.isDone).length;
  }

  int get favoriteCount {
    return _activities.where((activity) => activity.isFavorite).length;
  }

  String generateId() {
    int number = _activities.length + 1;

    String id = 'SP${number.toString().padLeft(3, '0')}';

    while (_activities.any((activity) => activity.id == id)) {
      number++;
      id = 'SP${number.toString().padLeft(3, '0')}';
    }

    return id;
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void updateActivity(Activity activity) {
    int index = _activities.indexWhere((item) => item.id == activity.id);

    if (index != -1) {
      _activities[index] = activity;
      notifyListeners();
    }
  }

  void deleteActivity(String id) {
    _activities.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toggleDone(String id) {
    int index = _activities.indexWhere((item) => item.id == id);

    if (index != -1) {
      _activities[index].isDone = !_activities[index].isDone;
      notifyListeners();
    }
  }

  void toggleFavorite(String id) {
    int index = _activities.indexWhere((item) => item.id == id);

    if (index != -1) {
      _activities[index].isFavorite = !_activities[index].isFavorite;
      notifyListeners();
    }
  }
}
