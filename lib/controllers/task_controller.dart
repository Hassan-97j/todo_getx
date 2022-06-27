import 'package:get/get.dart';
import 'package:todo_getx/db/db_helper.dart';
import 'package:todo_getx/modals/tasks.dart';

class TaskController extends GetxController {

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[];

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
    
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) =>  Task.fromJson(data)).toList());
    update();
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
    update();

  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
    update();
  }

}