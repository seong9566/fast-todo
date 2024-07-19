import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:get/get.dart';

import '../../screen/main/write/d_write_todo.dart';

class TodoDataHolder extends GetxController {
  final RxList<Todo> todoList = <Todo>[].obs;

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }
    // refresh를 하게 되면, Rx가 관찰하고 있는 obs에서 rebuild가 발생함.
    todoList.refresh();
    //GetBuilder()를 사용할 시 update()를 사용해준다.
    update();
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      // Rx에 add는 내부적으로 refresh를 하기 때문에 다시 refresh()를 호출 할 필요가 없다.
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
      ));
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      todoList.refresh();
      update();
    }
  }

  void removeTodo(Todo todo) async {
    todoList.remove(todo);
    todoList.refresh();
    update();
  }
}

mixin class TodoDataProvider {
  late final TodoDataHolder todoData = Get.find();
}
