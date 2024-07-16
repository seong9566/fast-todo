import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/material.dart';

class TodoDataNotifier extends ValueNotifier<List<Todo>> {
  //최초에는 아무것도 없기 때문에 빈 List로 초기화
  TodoDataNotifier() : super([]);

  void addTodo(Todo todo) {
    // valueNotify의 값 = value로 호출
    value.add(todo);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
