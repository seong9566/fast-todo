import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoList extends StatelessWidget with TodoDataProvider {
  TodoList({super.key});

  /*
  * GetController 방법1.
  * class TodoList extends GetView<TodoDataHolder> with TodoDataProvider {
  * GetView 내부에 get controller => 로 GetInstance().find()가 정의 되어 있기 때문에 controller.todoList로 접근이 가능하다.
  * 단점 : 즉 확장성이 떨어진다.
  * GetView를 사용하게 되면 만약 다른 Controller를 참조 하고 싶다면 다른 Controller 모두 변경을 하기 때문에
  * 하나의 Controller만 사용하면 상관없지만 그게 아니라면 GetView를 사용하지 않는게 좋다.
  * */

  /**
   * GetController 방법2.
   * GetBuilder 사용하기
   * 만약 GetBuilder를 사용한다면 refresh(), update()로 같이 사용 해준다.
   * 단점 : 확장성이 떨어진다.
   */

  /**
   * 방법 3 Obx 활용 ( 가장 추천 하는 방법 )
   * */

  /**
   * RxList, Obx의 동작 방식
   *  @override
      @protected
      List<E> get value {
      RxInterface.proxy?.addListener(subject);
      return _value;
      }
      위 코드 처럼
      Rx가 value를 Listener로 리슨을 하고 있다.
      그리고 todoList.isEmpty를 호출 할 때 value를 따로 호출 하지 않아도 되는 이유는 아래와같다.
      get length를 호출 할때 Getx에서 value.length를 호출해서 이다.
   */

  @override
  Widget build(BuildContext context) {
    return Obx(() => todoData.todoList.isEmpty
        ? '할일을 작성해 보세요'.text.size(30).makeCentered()
        : Column(
            children: todoData.todoList.map((e) => TodoItem(e)).toList(),
          ));
  }
}
