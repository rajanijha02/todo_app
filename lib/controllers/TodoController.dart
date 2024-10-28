import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TodoController extends GetxController {
  final taskTitleController = TextEditingController();
  final tasks = <Map<String, dynamic>>[].obs;
  final filteredTasks = <Map<String, dynamic>>[].obs;
  final storage = GetStorage();
  final filter = 'All'.obs;
  final selectedTasks = <int, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    List? storedTasks = storage.read<List>('tasks');
    if (storedTasks != null) {
      tasks.assignAll(storedTasks.map((e) => Map<String, dynamic>.from(e)).toList());
    }
    applyFilter();
    tasks.listen((_) => applyFilter());
    filter.listen((_) => applyFilter());
  }

  void addTask(String title) {
    tasks.add({'title': title, 'completed': false});
    taskTitleController.clear();
    storage.write('tasks', tasks);
  }

  void toggleTaskStatus(int index) {
    tasks[index]['completed'] = !tasks[index]['completed'];
    tasks.refresh();
    storage.write('tasks', tasks);
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    selectedTasks.clear();
    tasks.refresh();
    storage.write('tasks', tasks);
  }

  void changeFilter(String newFilter) {
    filter.value = newFilter;
  }

  void applyFilter() {
    if (filter.value == 'All') {
      filteredTasks.assignAll(tasks);
    } else if (filter.value == 'Completed') {
      filteredTasks.assignAll(tasks.where((task) => task['completed']));
    } else if (filter.value == 'Pending') {
      filteredTasks.assignAll(tasks.where((task) => !task['completed']));
    }
  }
}
