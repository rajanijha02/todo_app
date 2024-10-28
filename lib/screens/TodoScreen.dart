import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/TodoController.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final Color appColor = Color(0xff184b75);
  final Color lightAppColor = Color(0xff225885);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ).paddingOnly(right: Get.width / 20),
            Obx(() {
              return DropdownButton<String>(
                value: todoController.filter.value,
                dropdownColor: appColor,
                onChanged: (newValue) {
                  if (newValue != null) {
                    todoController.changeFilter(newValue);
                  }
                },
                items: <String>['All', 'Completed', 'Pending']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                icon: Icon(Icons.filter_list, color: Colors.white)
                    .paddingOnly(left: Get.width / 30),
                underline: Container(),
              );
            }),
          ],
        ),
        backgroundColor: lightAppColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: todoController.filteredTasks.length,
                itemBuilder: (context, index) {
                  var task = todoController.filteredTasks[index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(
                        vertical: 10, horizontal: Get.width / 30),
                    child: ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      title: Text(
                        task['title'],
                        style: TextStyle(
                            fontSize: Get.width / 26,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade800),
                      ),
                      leading: Checkbox(
                        activeColor: appColor,
                        checkColor: Colors.grey.shade300,
                        value: task['completed'],
                        onChanged: (value) {
                          todoController.toggleTaskStatus(
                              todoController.tasks.indexOf(task));
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red.shade800),
                        onPressed: () {
                          todoController.removeTask(todoController.tasks.indexOf(task));
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text('Add New Task',
                    style:
                    TextStyle(color: appColor, fontSize: Get.width / 25)),
                content: TextField(
                  controller: todoController.taskTitleController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    labelStyle:
                    TextStyle(fontSize: Get.width / 26, color: appColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appColor),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel', style: TextStyle(color: appColor)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: appColor),
                    onPressed: () {
                      if (todoController.taskTitleController.text.isNotEmpty) {
                        todoController
                            .addTask(todoController.taskTitleController.text);
                        Get.back();
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
